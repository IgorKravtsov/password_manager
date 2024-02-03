import 'package:flutter/material.dart';

class PasswrodInput extends StatefulWidget {
  final String? labelText;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final int? maxLenth;
  final Function(String)? onChanged;
  final Widget? prefixIcon;

  const PasswrodInput({
    super.key,
    this.labelText,
    this.onSaved,
    this.validator,
    this.controller,
    this.maxLenth,
    this.onChanged,
    this.prefixIcon,
  });

  @override
  State<PasswrodInput> createState() => _PasswrodInputState();
}

class _PasswrodInputState extends State<PasswrodInput> {
  var isPasswordVisible = false;

  void _togglePasswordVisibility() {
    setState(() => isPasswordVisible = !isPasswordVisible);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextField(
      controller: widget.controller,
      maxLength: widget.maxLenth,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        labelText: widget.labelText,
        // labelStyle: theme.textTheme.bodyMedium?.copyWith(
        //   color: theme.primaryColor,
        // ),
        // errorBorder: _buildOutlineBorder(context, color: Colors.redAccent),
        border: _buildOutlineBorder(context),
        // enabledBorder: _buildOutlineBorder(context),
        // focusedBorder: _buildOutlineBorder(context),
        prefixIcon: widget.prefixIcon ?? const Icon(Icons.lock),
        suffixIcon: IconButton(
          onPressed: _togglePasswordVisibility,
          icon: isPasswordVisible
              ? const Icon(Icons.visibility)
              : const Icon(Icons.visibility_off),
        ),
        // fillColor: theme.colorScheme.primaryContainer,
        // prefixIconColor: theme.primaryColor,
        // suffixIconColor: theme.primaryColor,
      ),
      obscureText: !isPasswordVisible,
    );
  }

  OutlineInputBorder _buildOutlineBorder(BuildContext context, {Color? color}) {
    final theme = Theme.of(context);
    return const OutlineInputBorder(
        // borderRadius: BorderRadius.circular(16),
        // borderSide: BorderSide(color: color ?? theme.primaryColor),
        );
  }
}
