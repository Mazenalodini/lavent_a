import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/local/database.dart';
import '../../../data/models/enums.dart';
import '../../../providers.dart';
import '../../common/lavent_button.dart';
import '../../common/lavent_card.dart';

class InvoicePreviewScreen extends ConsumerStatefulWidget {
  final int orderId;

  const InvoicePreviewScreen({super.key, required this.orderId});

  @override
  ConsumerState<InvoicePreviewScreen> createState() =>
      _InvoicePreviewScreenState();
}

class _InvoicePreviewScreenState extends ConsumerState<InvoicePreviewScreen> {
  bool _isGenerating = false;
  pw.Font? _arabicFont;
  pw.Font? _arabicBoldFont;

  @override
  void initState() {
    super.initState();
    _loadFonts();
  }

  Future<void> _loadFonts() async {
    // Try multiple Arabic fonts in order of preference
    final fontAttempts = [
      () async {
        final regular = await PdfGoogleFonts.amiriRegular();
        final bold = await PdfGoogleFonts.amiriBold();
        return (regular, bold);
      },
      () async {
        final regular = await PdfGoogleFonts.cairoRegular();
        final bold = await PdfGoogleFonts.cairoBold();
        return (regular, bold);
      },
      () async {
        final regular = await PdfGoogleFonts.tajawalRegular();
        final bold = await PdfGoogleFonts.tajawalBold();
        return (regular, bold);
      },
    ];

    for (final attempt in fontAttempts) {
      try {
        final (regular, bold) = await attempt();
        _arabicFont = regular;
        _arabicBoldFont = bold;
        debugPrint('Arabic font loaded successfully');
        if (mounted) setState(() {});
        return;
      } catch (e) {
        debugPrint('Font loading attempt failed: $e');
      }
    }
    debugPrint('All font loading attempts failed');
  }

  @override
  Widget build(BuildContext context) {
    final orderAsync = ref.watch(orderByIdProvider(widget.orderId));
    final receiptsAsync = ref.watch(receiptsForOrderProvider(widget.orderId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('معاينة الفاتورة'),
      ),
      body: orderAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('خطأ: $err')),
        data: (order) {
          if (order == null) {
            return const Center(child: Text('الطلب غير موجود'));
          }

          return receiptsAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, _) => Center(child: Text('خطأ: $err')),
            data: (receipts) =>
                _buildPreview(context, order, receipts),
          );
        },
      ),
    );
  }

  Widget _buildPreview(
      BuildContext context, Order order, List<Receipt> receipts) {
    // Calculate total paid including initial payment
    final receiptsSum = receipts.fold(0.0, (sum, r) => sum + r.amount);
    final initialPayment = order.initialPayment ?? 0.0;
    final totalPaid = receiptsSum + initialPayment;
    final remaining = order.totalPrice - totalPaid;
    final hasInitialPayment = initialPayment > 0;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Invoice Preview Card
          Container(
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkCardSurface : Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: isDark ? [] : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                // Header with Logo - Dark Background
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 28),
                  decoration: const BoxDecoration(
                    color: Color(0xFF1A1A1A),
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: 130,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        // Fallback if image fails to load
                        return Column(
                          children: [
                            Icon(Icons.wb_sunny_rounded, color: const Color(0xFFD4AF37), size: 48),
                            const SizedBox(height: 8),
                            const Text(
                              'LAVENT',
                              style: TextStyle(
                                color: Color(0xFFD4AF37),
                                fontSize: 24,
                                fontWeight: FontWeight.w300,
                                letterSpacing: 6,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),

                // Two-Column Info Section
                Container(
                  padding: const EdgeInsets.all(20),
                  color: isDark ? AppColors.darkSurface : const Color(0xFFF8F8F8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Client Info (Right side in RTL)
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'بيانات العميل',
                              style: AppTextStyles.labelMedium.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 12),
                            _InfoLine(label: 'اسم العميل', value: order.clientName),
                            _InfoLine(label: 'رقم الهاتف', value: Formatters.phone(order.clientPhone)),
                            if (order.clientAddress != null)
                              _InfoLine(label: 'العنوان', value: order.clientAddress!),
                          ],
                        ),
                      ),
                      const SizedBox(width: 24),
                      // Invoice Info (Left side in RTL)
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'بيانات الفاتورة',
                              style: AppTextStyles.labelMedium.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 12),
                            _InfoLine(label: 'رقم الفاتورة', value: order.orderNumber),
                            _InfoLine(label: 'تاريخ إصدار الفاتورة', value: Formatters.date(DateTime.now())),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Table Header
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkSurfaceSecondary : const Color(0xFFE8E8E8),
                  ),
                  child: Row(
                    children: [
                      Expanded(flex: 3, child: Text('البيان', style: AppTextStyles.labelMedium)),
                      Expanded(flex: 2, child: Text('السعر', style: AppTextStyles.labelMedium, textAlign: TextAlign.center)),
                      Expanded(flex: 2, child: Text('الإجمالي', style: AppTextStyles.labelMedium, textAlign: TextAlign.end)),
                    ],
                  ),
                ),

                // Table Row - Order Item
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: isDark ? AppColors.darkDivider : Colors.grey.shade200),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(order.abayaType, style: AppTextStyles.bodyMedium),
                            if (order.abayaNumber != null)
                              Text('رقم: ${order.abayaNumber}', style: AppTextStyles.bodySmall),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          Formatters.currency(order.totalPrice),
                          style: AppTextStyles.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          Formatters.currency(order.totalPrice),
                          style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                ),

                // Summary Section
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      _SummaryRow(label: 'المجموع الفرعي', value: Formatters.currency(order.totalPrice)),
                      const SizedBox(height: 8),
                      _SummaryRow(
                        label: 'المبلغ المدفوع',
                        value: Formatters.currency(totalPaid),
                        valueColor: AppColors.statusDelivered,
                      ),
                      const Divider(height: 24),
                      _SummaryRow(
                        label: 'الإجمالي',
                        value: Formatters.currency(remaining),
                        isTotal: true,
                        valueColor: remaining > 0 ? AppColors.error : AppColors.statusDelivered,
                      ),
                    ],
                  ),
                ),

                // Payments List (if any)
                if (hasInitialPayment || receipts.isNotEmpty)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    color: isDark ? AppColors.darkSurface : const Color(0xFFF8F8F8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('تفاصيل المدفوعات', style: AppTextStyles.labelMedium.copyWith(fontWeight: FontWeight.w700)),
                        const SizedBox(height: 12),
                        if (hasInitialPayment)
                          _PaymentLine(
                            date: order.orderDate,
                            type: 'دفعة مقدمة',
                            method: order.initialPaymentMethod ?? 'cash',
                            amount: initialPayment,
                          ),
                        ...receipts.map((r) => _PaymentLine(
                          date: r.date,
                          type: 'سند قبض',
                          method: r.paymentMethod,
                          amount: r.amount,
                        )),
                      ],
                    ),
                  ),

                // Footer
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: isDark ? AppColors.darkDivider : Colors.grey.shade200),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Notes
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('ملاحظات:', style: AppTextStyles.labelSmall.copyWith(color: AppColors.accent)),
                            const SizedBox(height: 4),
                            Text(
                              '• يستحق الدفع عند الاستلام',
                              style: AppTextStyles.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      // Thank you
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('شكراً لتعاملكم معنا', style: AppTextStyles.bodySmall.copyWith(color: AppColors.accent)),
                          const SizedBox(height: 4),
                          const Text('LAVENT', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Action Buttons
          LaventButton(
            label: 'طباعة / مشاركة PDF',
            icon: Icons.print_rounded,
            fullWidth: true,
            isLoading: _isGenerating,
            onPressed: () => _generateAndSharePdf(order, receipts),
          ),
          const SizedBox(height: 12),
          LaventOutlinedButton(
            label: 'حفظ كملف PDF',
            icon: Icons.save_alt_rounded,
            fullWidth: true,
            onPressed: () => _saveAsPdf(order, receipts),
          ),
        ],
      ),
    );
  }

  Future<Uint8List> _generatePdfBytes(
      Order order, List<Receipt> receipts) async {
    final pdf = pw.Document();

    // Use pre-loaded fonts or try to load Amiri (best Arabic support for PDF)
    pw.Font arabicFont;
    pw.Font arabicBoldFont;
    
    if (_arabicFont != null && _arabicBoldFont != null) {
      arabicFont = _arabicFont!;
      arabicBoldFont = _arabicBoldFont!;
    } else {
      try {
        arabicFont = await PdfGoogleFonts.amiriRegular();
        arabicBoldFont = await PdfGoogleFonts.amiriBold();
      } catch (e) {
        try {
          arabicFont = await PdfGoogleFonts.cairoRegular();
          arabicBoldFont = await PdfGoogleFonts.cairoBold();
        } catch (e2) {
          arabicFont = await PdfGoogleFonts.tajawalRegular();
          arabicBoldFont = await PdfGoogleFonts.tajawalBold();
        }
      }
    }

    // Load logo image
    pw.ImageProvider? logoImage;
    try {
      final ByteData logoData = await rootBundle.load('assets/images/logo.png');
      logoImage = pw.MemoryImage(logoData.buffer.asUint8List());
    } catch (e) {
      debugPrint('Failed to load logo for PDF: $e');
    }

    // Calculate total paid including initial payment
    final receiptsSum = receipts.fold(0.0, (sum, r) => sum + r.amount);
    final initialPayment = order.initialPayment ?? 0.0;
    final totalPaid = receiptsSum + initialPayment;
    final remaining = order.totalPrice - totalPaid;
    final hasInitialPayment = initialPayment > 0;

    // Define colors
    final darkBg = PdfColor.fromHex('1A1A1A');
    final goldColor = PdfColor.fromHex('D4AF37');
    final grayBg = PdfColor.fromHex('F5F5F5');
    final greenColor = PdfColor.fromHex('27AE60');
    final redColor = PdfColor.fromHex('E74C3C');

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        textDirection: pw.TextDirection.rtl,
        margin: const pw.EdgeInsets.all(24),
        build: (context) {
          return pw.Container(
            decoration: pw.BoxDecoration(
              borderRadius: const pw.BorderRadius.all(pw.Radius.circular(12)),
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.stretch,
              children: [
                // Dark Header with Logo
                pw.Container(
                  width: double.infinity,
                  padding: const pw.EdgeInsets.symmetric(vertical: 30),
                  decoration: pw.BoxDecoration(
                    color: darkBg,
                    borderRadius: const pw.BorderRadius.only(
                      topLeft: pw.Radius.circular(12),
                      topRight: pw.Radius.circular(12),
                    ),
                  ),
                  child: pw.Column(
                    children: [
                      // Logo Image
                      if (logoImage != null)
                        pw.Image(logoImage, height: 80)
                      else
                        pw.Column(
                          children: [
                            pw.Text(
                              'LAVENT',
                              style: pw.TextStyle(
                                font: arabicBoldFont,
                                fontSize: 28,
                                color: goldColor,
                                letterSpacing: 6,
                              ),
                            ),
                            pw.SizedBox(height: 4),
                            pw.Text(
                              'لافينت عباية',
                              style: pw.TextStyle(
                                font: arabicFont,
                                fontSize: 12,
                                color: PdfColors.white,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),

                // Two-Column Info Section
                pw.Container(
                  padding: const pw.EdgeInsets.all(20),
                  color: grayBg,
                  child: pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      // Client Info (Right in RTL)
                      pw.Expanded(
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text('بيانات العميل', style: pw.TextStyle(font: arabicBoldFont, fontSize: 13, color: PdfColors.black)),
                            pw.SizedBox(height: 10),
                            pw.Text('اسم العميل: ${order.clientName}', style: pw.TextStyle(font: arabicFont, fontSize: 10)),
                            pw.SizedBox(height: 4),
                            pw.Text('رقم الهاتف: ${Formatters.phone(order.clientPhone)}', style: pw.TextStyle(font: arabicFont, fontSize: 10)),
                            if (order.clientAddress != null) ...[
                              pw.SizedBox(height: 4),
                              pw.Text('العنوان: ${order.clientAddress}', style: pw.TextStyle(font: arabicFont, fontSize: 10)),
                            ],
                          ],
                        ),
                      ),
                      // Invoice Info (Left in RTL)
                      pw.Expanded(
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text('بيانات الفاتورة', style: pw.TextStyle(font: arabicBoldFont, fontSize: 13, color: PdfColors.black)),
                            pw.SizedBox(height: 10),
                            pw.Text('رقم الفاتورة: ${order.orderNumber}', style: pw.TextStyle(font: arabicFont, fontSize: 10)),
                            pw.SizedBox(height: 4),
                            pw.Text('تاريخ إصدار الفاتورة:', style: pw.TextStyle(font: arabicFont, fontSize: 10)),
                            pw.Text(Formatters.date(DateTime.now()), style: pw.TextStyle(font: arabicFont, fontSize: 10)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Table Header
                pw.Container(
                  padding: const pw.EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  decoration: pw.BoxDecoration(
                    color: PdfColor.fromHex('E0E0E0'),
                    border: pw.Border(
                      top: pw.BorderSide(color: PdfColors.grey400),
                      bottom: pw.BorderSide(color: PdfColors.grey400),
                    ),
                  ),
                  child: pw.Row(
                    children: [
                      pw.Expanded(flex: 3, child: pw.Text('البيان', style: pw.TextStyle(font: arabicBoldFont, fontSize: 12))),
                      pw.Expanded(flex: 2, child: pw.Text('السعر', style: pw.TextStyle(font: arabicBoldFont, fontSize: 12), textAlign: pw.TextAlign.center)),
                      pw.Expanded(flex: 2, child: pw.Text('الإجمالي', style: pw.TextStyle(font: arabicBoldFont, fontSize: 12), textAlign: pw.TextAlign.left)),
                    ],
                  ),
                ),

                // Table Row - Item
                pw.Container(
                  padding: const pw.EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  decoration: pw.BoxDecoration(
                    border: pw.Border(bottom: pw.BorderSide(color: PdfColors.grey300)),
                  ),
                  child: pw.Row(
                    children: [
                      pw.Expanded(
                        flex: 3,
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(order.abayaType, style: pw.TextStyle(font: arabicFont, fontSize: 11)),
                            if (order.abayaNumber != null)
                              pw.Text('رقم: ${order.abayaNumber}', style: pw.TextStyle(font: arabicFont, fontSize: 9, color: PdfColors.grey600)),
                          ],
                        ),
                      ),
                      pw.Expanded(flex: 2, child: pw.Text(Formatters.currency(order.totalPrice), style: pw.TextStyle(font: arabicFont, fontSize: 11), textAlign: pw.TextAlign.center)),
                      pw.Expanded(flex: 2, child: pw.Text(Formatters.currency(order.totalPrice), style: pw.TextStyle(font: arabicBoldFont, fontSize: 11), textAlign: pw.TextAlign.left)),
                    ],
                  ),
                ),

                // Summary Section
                pw.Container(
                  padding: const pw.EdgeInsets.all(20),
                  child: pw.Column(
                    children: [
                      _pdfRow('المجموع الفرعي', Formatters.currency(order.totalPrice), arabicFont),
                      pw.SizedBox(height: 8),
                      _pdfRow('المبلغ المدفوع', Formatters.currency(totalPaid), arabicFont, valueColor: greenColor),
                      pw.SizedBox(height: 12),
                      pw.Divider(color: PdfColors.grey400),
                      pw.SizedBox(height: 12),
                      _pdfRow('الإجمالي', Formatters.currency(remaining), arabicBoldFont, fontSize: 16, valueColor: remaining > 0 ? redColor : greenColor),
                    ],
                  ),
                ),

                // Payments Section - Dark Background like preview
                if (hasInitialPayment || receipts.isNotEmpty)
                  pw.Container(
                    width: double.infinity,
                    padding: const pw.EdgeInsets.all(20),
                    color: darkBg,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text('تفاصيل المدفوعات', style: pw.TextStyle(font: arabicBoldFont, fontSize: 12, color: PdfColors.white)),
                        pw.SizedBox(height: 12),
                        if (hasInitialPayment)
                          pw.Padding(
                            padding: const pw.EdgeInsets.only(bottom: 6),
                            child: pw.Text(
                              '${Formatters.date(order.orderDate)} • دفعة مقدمة • ${order.initialPaymentMethod != null ? PaymentMethod.fromName(order.initialPaymentMethod!).displayName : "نقدي"} • ${Formatters.currency(initialPayment)}',
                              style: pw.TextStyle(font: arabicFont, fontSize: 10, color: PdfColors.grey300),
                            ),
                          ),
                        ...receipts.map((r) => pw.Padding(
                          padding: const pw.EdgeInsets.only(bottom: 6),
                          child: pw.Text(
                            '${Formatters.date(r.date)} • سند قبض • ${PaymentMethod.fromName(r.paymentMethod).displayName} • ${Formatters.currency(r.amount)}',
                            style: pw.TextStyle(font: arabicFont, fontSize: 10, color: PdfColors.grey300),
                          ),
                        )),
                      ],
                    ),
                  ),

                pw.Spacer(),

                // Footer
                pw.Container(
                  padding: const pw.EdgeInsets.all(20),
                  decoration: pw.BoxDecoration(
                    color: grayBg,
                    borderRadius: const pw.BorderRadius.only(
                      bottomLeft: pw.Radius.circular(12),
                      bottomRight: pw.Radius.circular(12),
                    ),
                  ),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text('ملاحظات:', style: pw.TextStyle(font: arabicBoldFont, fontSize: 10, color: goldColor)),
                          pw.SizedBox(height: 4),
                          pw.Text('• يستحق الدفع عند الاستلام', style: pw.TextStyle(font: arabicFont, fontSize: 9)),
                        ],
                      ),
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.end,
                        children: [
                          pw.Text('شكراً لتعاملكم معنا', style: pw.TextStyle(font: arabicFont, fontSize: 10, color: goldColor)),
                          pw.SizedBox(height: 4),
                          pw.Text('LAVENT', style: pw.TextStyle(font: arabicBoldFont, fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );

    return pdf.save();
  }

  pw.Widget _pdfRow(
    String label,
    String value,
    pw.Font font, {
    double fontSize = 12,
    PdfColor? valueColor,
  }) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 4),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(label, style: pw.TextStyle(font: font, fontSize: fontSize)),
          pw.Text(
            value,
            style: pw.TextStyle(
              font: font,
              fontSize: fontSize,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _generateAndSharePdf(
      Order order, List<Receipt> receipts) async {
    setState(() => _isGenerating = true);

    try {
      final pdfBytes = await _generatePdfBytes(order, receipts);
      await Printing.layoutPdf(
        onLayout: (_) => pdfBytes,
        name: 'فاتورة_${order.orderNumber}',
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('خطأ: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isGenerating = false);
    }
  }

  Future<void> _saveAsPdf(Order order, List<Receipt> receipts) async {
    setState(() => _isGenerating = true);

    try {
      final pdfBytes = await _generatePdfBytes(order, receipts);
      final fileName = 'Lavent_Invoice_${order.orderNumber}.pdf';
      
      if (Platform.isAndroid) {
        // Try to save to Downloads/Lavent folder
        try {
          // Get Downloads directory
          final downloadDir = Directory('/storage/emulated/0/Download/Lavent');
          
          // Create Lavent folder if it doesn't exist
          if (!await downloadDir.exists()) {
            await downloadDir.create(recursive: true);
          }
          
          // Save the file
          final file = File('${downloadDir.path}/$fileName');
          await file.writeAsBytes(pdfBytes);
          
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('✅ تم حفظ الفاتورة بنجاح'),
                    Text(
                      'المسار: Download/Lavent/$fileName',
                      style: const TextStyle(fontSize: 11),
                    ),
                  ],
                ),
                duration: const Duration(seconds: 4),
                action: SnackBarAction(
                  label: 'مشاركة',
                  onPressed: () async {
                    await Printing.sharePdf(bytes: pdfBytes, filename: fileName);
                  },
                ),
              ),
            );
          }
        } catch (e) {
          // Fallback to share dialog if direct save fails (permission issues)
          debugPrint('Direct save failed: $e, falling back to share');
          await Printing.sharePdf(
            bytes: pdfBytes,
            filename: fileName,
          );
          
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('✅ اختر "حفظ في الملفات" ثم Download/Lavent'),
                duration: Duration(seconds: 3),
              ),
            );
          }
        }
      } else {
        // iOS: Save to Documents folder
        final appDir = await getApplicationDocumentsDirectory();
        final laventDir = Directory('${appDir.path}/Lavent');
        if (!await laventDir.exists()) {
          await laventDir.create(recursive: true);
        }
        final file = File('${laventDir.path}/$fileName');
        await file.writeAsBytes(pdfBytes);
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('✅ تم حفظ الفاتورة بنجاح'),
              duration: const Duration(seconds: 4),
              action: SnackBarAction(
                label: 'مشاركة',
                onPressed: () async {
                  await Printing.sharePdf(bytes: pdfBytes, filename: fileName);
                },
              ),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('خطأ في الحفظ: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isGenerating = false);
    }
  }
}
class _PreviewRow extends StatelessWidget {
  final String label;
  final String value;

  const _PreviewRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyles.bodySmall),
          Text(value, style: AppTextStyles.bodyMedium),
        ],
      ),
    );
  }
}

/// Info line for two-column layout
class _InfoLine extends StatelessWidget {
  final String label;
  final String value;

  const _InfoLine({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: RichText(
        text: TextSpan(
          style: AppTextStyles.bodySmall.copyWith(
            color: Theme.of(context).brightness == Brightness.dark 
                ? AppColors.darkTextSecondary 
                : AppColors.textSecondary,
          ),
          children: [
            TextSpan(text: '$label: '),
            TextSpan(
              text: value,
              style: AppTextStyles.bodySmall.copyWith(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).brightness == Brightness.dark 
                    ? AppColors.darkTextPrimary 
                    : AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Summary row for totals section
class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isTotal;
  final Color? valueColor;

  const _SummaryRow({
    required this.label,
    required this.value,
    this.isTotal = false,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: isTotal 
              ? AppTextStyles.headlineSmall 
              : AppTextStyles.bodyMedium,
        ),
        Text(
          value,
          style: (isTotal 
              ? AppTextStyles.headlineSmall 
              : AppTextStyles.bodyMedium).copyWith(
            color: valueColor,
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

/// Payment line for payments list
class _PaymentLine extends StatelessWidget {
  final DateTime date;
  final String type;
  final String method;
  final double amount;

  const _PaymentLine({
    required this.date,
    required this.type,
    required this.method,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    final methodDisplay = PaymentMethod.fromName(method).displayName;
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '${Formatters.date(date)} • $type • $methodDisplay',
              style: AppTextStyles.bodySmall,
            ),
          ),
          Text(
            Formatters.currency(amount),
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.statusDelivered,
            ),
          ),
        ],
      ),
    );
  }
}
