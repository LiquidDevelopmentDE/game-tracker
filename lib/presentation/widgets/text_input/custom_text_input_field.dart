import 'package:flutter/material.dart';
import 'package:game_tracker/presentation/widgets/text_input_field.dart';

class CustomTextInputField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final void Function(String)? onChanged;

  const CustomTextInputField({
    super.key,
    required this.controller,
    required this.hintText,
    this.onChanged,
  });

  @override
  State<CustomTextInputField> createState() => _CustomTextInputFieldState();
}

class _CustomTextInputFieldState extends State<CustomTextInputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: TextInputField(
        controller: widget.controller,
        hintText: widget.hintText,
        onChanged: widget.onChanged,
      ),
    );
  }
}
