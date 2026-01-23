import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'core/services/notification_service.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_provider.dart';
import 'data/local/auth_service.dart';
import 'data/local/database.dart';
import 'providers.dart';
import 'presentation/screens/auth/login_screen.dart';
import 'presentation/screens/auth/setup_screen.dart';
import 'presentation/screens/dashboard/dashboard_screen.dart';
import 'presentation/screens/orders/orders_list_screen.dart';
import 'presentation/screens/orders/order_form_screen.dart';
import 'presentation/screens/orders/order_detail_screen.dart';
import 'presentation/screens/receipts/receipt_form_screen.dart';
import 'presentation/screens/receipts/receipts_list_screen.dart';
import 'presentation/screens/invoices/invoices_list_screen.dart';
import 'presentation/screens/invoices/invoice_preview_screen.dart';
import 'presentation/screens/orders/archived_orders_screen.dart';
import 'presentation/screens/settings/settings_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Arabic date formatting
  await initializeDateFormatting('ar_SA', null);

  // Initialize notification service
  await NotificationService().initialize();
  await NotificationService().requestPermission();

  runApp(
    const ProviderScope(
      child: LaventApp(),
    ),
  );
}

class LaventApp extends ConsumerStatefulWidget {
  const LaventApp({super.key});

  @override
  ConsumerState<LaventApp> createState() => _LaventAppState();
}

class _LaventAppState extends ConsumerState<LaventApp> {
  @override
  void initState() {
    super.initState();
    // Connect NotificationService with database after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final db = ref.read(databaseProvider);
      NotificationService().setDatabase(db);
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeModeProvider);
    
    return MaterialApp(
      title: 'لافينت',
      debugShowCheckedModeBanner: false,

      // RTL Support & Localization
      locale: const Locale('ar', 'SA'),
      supportedLocales: const [
        Locale('ar', 'SA'),
        Locale('en', 'US'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      // Theme - No animation to prevent lerp errors
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      themeAnimationDuration: Duration.zero,

      // Start with auth wrapper
      home: const AuthWrapper(),

      // Routes
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(
              builder: (_) => const DashboardScreen(),
            );

          case '/login':
            return MaterialPageRoute(
              builder: (_) => const LoginScreen(),
            );

          case '/setup':
            return MaterialPageRoute(
              builder: (_) => const SetupScreen(),
            );

          case '/orders':
            return MaterialPageRoute(
              builder: (_) => const OrdersListScreen(),
            );

          case '/orders/new':
            return MaterialPageRoute(
              builder: (_) => const OrderFormScreen(),
            );

          case '/orders/edit':
            final orderId = settings.arguments as int;
            return MaterialPageRoute(
              builder: (_) => OrderFormScreen(orderId: orderId),
            );

          case '/orders/detail':
            final orderId = settings.arguments as int;
            return MaterialPageRoute(
              builder: (_) => OrderDetailScreen(orderId: orderId),
            );

          case '/receipts':
            return MaterialPageRoute(
              builder: (_) => const ReceiptsListScreen(),
            );

          case '/receipts/new':
            return MaterialPageRoute(
              builder: (_) => const ReceiptFormScreen(),
            );

          case '/invoices':
            return MaterialPageRoute(
              builder: (_) => const InvoicesListScreen(),
            );

          case '/invoices/preview':
            final orderId = settings.arguments as int;
            return MaterialPageRoute(
              builder: (_) => InvoicePreviewScreen(orderId: orderId),
            );

          case '/orders/archived':
            return MaterialPageRoute(
              builder: (_) => const ArchivedOrdersScreen(),
            );

          case '/settings':
            return MaterialPageRoute(
              builder: (_) => const SettingsScreen(),
            );

          default:
            return MaterialPageRoute(
              builder: (_) => const DashboardScreen(),
            );
        }
      },

      // RTL Builder
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child!,
        );
      },
    );
  }
}

/// Auth Wrapper - يتحقق من حالة المصادقة
class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  bool _isLoading = true;
  bool _isSetupComplete = false;
  bool _isSessionValid = false;

  @override
  void initState() {
    super.initState();
    _checkAuthState();
  }

  Future<void> _checkAuthState() async {
    try {
      final isSetup = await AuthService.isSetupComplete();
      bool sessionValid = false;

      if (isSetup) {
        // Check if session is expired
        final isExpired = await AuthService.isSessionExpired();
        sessionValid = !isExpired;
      }

      if (mounted) {
        setState(() {
          _isSetupComplete = isSetup;
          _isSessionValid = sessionValid;
          _isLoading = false;
        });
      }
    } catch (e) {
      // On error, show setup screen
      if (mounted) {
        setState(() {
          _isSetupComplete = false;
          _isSessionValid = false;
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (!_isSetupComplete) {
      return const SetupScreen();
    }

    if (!_isSessionValid) {
      return const LoginScreen();
    }

    return const DashboardScreen();
  }
}
