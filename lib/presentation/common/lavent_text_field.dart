import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

/// Styled text field for forms
class LaventTextField extends StatelessWidget {
  final String label;
  final String? hint;
  final String? hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final int maxLines;
  final bool readOnly;
  final bool obscureText;
  final VoidCallback? onTap;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final void Function(String)? onChanged;

  const LaventTextField({
    super.key,
    required this.label,
    this.hint,
    this.hintText,
    this.controller,
    this.validator,
    this.keyboardType,
    this.maxLines = 1,
    this.readOnly = false,
    this.obscureText = false,
    this.onTap,
    this.suffixIcon,
    this.prefixIcon,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      maxLines: obscureText ? 1 : maxLines,
      readOnly: readOnly,
      obscureText: obscureText,
      onTap: onTap,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText ?? hint,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
      ),
    );
  }
}

/// Styled dropdown field
class LaventDropdown<T> extends StatelessWidget {
  final String label;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final void Function(T?)? onChanged;
  final String? Function(T?)? validator;

  const LaventDropdown({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: value,
      items: items,
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
      ),
      dropdownColor: AppColors.cardSurface,
      borderRadius: BorderRadius.circular(12),
    );
  }
}

/// Date picker field
class LaventDateField extends StatelessWidget {
  final String label;
  final DateTime? value;
  final void Function(DateTime) onChanged;
  final DateTime? firstDate;
  final DateTime? lastDate;

  const LaventDateField({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.firstDate,
    this.lastDate,
  });

  @override
  Widget build(BuildContext context) {
    final displayText = value != null
        ? '${value!.year}/${value!.month.toString().padLeft(2, '0')}/${value!.day.toString().padLeft(2, '0')}'
        : 'اختر التاريخ';

    return LaventTextField(
      label: label,
      controller: TextEditingController(text: value != null ? displayText : ''),
      readOnly: true,
      suffixIcon: const Icon(Icons.calendar_today_rounded),
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: value ?? DateTime.now(),
          firstDate: firstDate ?? DateTime(2020),
          lastDate: lastDate ?? DateTime(2100),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: Theme.of(context).colorScheme.copyWith(
                      primary: AppColors.accent,
                    ),
              ),
              child: child!,
            );
          },
        );
        if (picked != null) {
          onChanged(picked);
        }
      },
    );
  }
}
