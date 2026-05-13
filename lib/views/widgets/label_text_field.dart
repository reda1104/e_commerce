import 'package:e_commerce/utils/app_colors.dart';
import 'package:flutter/material.dart';

class LabelTextField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  final Widget? suffixIcon;
  final bool obsecureText;
  const LabelTextField({
    super.key,
    required this.label,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.suffixIcon,
    this.obsecureText = false,
  });

  @override
  State<LabelTextField> createState() => _LabelTextFieldState();
}

class _LabelTextFieldState extends State<LabelTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: Theme.of(
            context,
          ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 16),
        TextFormField(
          validator: (value) => value!.isEmpty ? "Enter ${widget.label}" : null,
          obscureText: widget.obsecureText,
          controller: widget.controller,
          decoration: InputDecoration(
            fillColor: AppColors.lightGrey,
            filled: true,
            hintText: widget.hintText,
            suffixIcon: widget.suffixIcon,
            suffixIconColor: AppColors.grey,
            prefixIcon: Icon(widget.prefixIcon),
            prefixIconColor: AppColors.grey,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
              borderSide: BorderSide.none,
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
              borderSide: BorderSide(color: Colors.red),
            ),
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
