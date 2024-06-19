import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final bool expand;
  final FormFieldSetter<String> onSaved;

  const CustomTextField({
    super.key,
    required this.label,
    this.expand = false, required this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.black.withOpacity(0.7),
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (!expand) renderTextFormField(),
        if (expand)
          Expanded(
            child: renderTextFormField(),
          ),
      ],
    );
  }

  renderTextFormField() {
    return TextFormField(
      onChanged: (String inputText) {},
      decoration: InputDecoration(
        border: InputBorder.none,
        fillColor: Colors.grey[300],
        filled: true,
      ),onSaved: onSaved,
      expands: expand,
      maxLines: expand ? null : 1,
      minLines: expand ? null : 1,
      cursorColor: Colors.grey,
      style: TextStyle(
        color: Colors.black.withOpacity(0.7),
        fontSize: 20,
        decoration: TextDecoration.none,
      ),
    );
  }
}
