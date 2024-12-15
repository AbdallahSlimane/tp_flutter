import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  final String label;
  final String hintText;
  final String initialValue;
  final int? maxLength;
  final int maxLines;
  final ValueChanged<String> onChanged;

  const InputText({
    super.key,
    required this.label,
    required this.hintText,
    required this.onChanged,
    this.initialValue = '',
    this.maxLength,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          onChanged: onChanged,
          controller: TextEditingController()..text = initialValue,
          maxLength: maxLength,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            hintStyle: const TextStyle(color: Colors.black26),
          ),
        ),
      ],
    );
  }
}
