import 'package:e_commerce/utils/app_colors.dart';
import 'package:flutter/material.dart';

class LabelTextFieldNewCard extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  const LabelTextFieldNewCard({
    super.key,
    required this.label,
    required this.controller,
    required this.hintText,
    required this.icon,
  });

  @override
  State<LabelTextFieldNewCard> createState() => _LabelTextFieldNewCardState();
}

class _LabelTextFieldNewCardState extends State<LabelTextFieldNewCard> {
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
          controller: widget.controller,
          decoration: InputDecoration(
            fillColor: AppColors.lightGrey,
            filled: true,
            hintText: widget.hintText,
            prefixIcon: Icon(widget.icon),
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
