import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final bool expand;
  final FormFieldSetter<String> onSaved;
  final String? initialValue;
  final TextStyle? labelStyle;
  final bool integerOnly;
  final bool isRequired;


  const CustomTextField({
    super.key,
    required this.label,
    this.expand = false,
    required this.onSaved,
    this.initialValue,
    this.labelStyle,
    this.integerOnly = false,
    this.isRequired = false,

  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: labelStyle ??
              TextStyle(
                color: Colors.black.withOpacity(0.7),
                fontSize: 20.sp,
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
      ),
      onSaved: onSaved,
      expands: expand,
      maxLines: expand ? null : 1,
      minLines: expand ? null : 1,
      cursorColor: Colors.grey,
      initialValue: initialValue,
      style: TextStyle(
        color: Colors.black.withOpacity(0.7),
        fontSize: 20.sp,
        decoration: TextDecoration.none,
      ),
      keyboardType: integerOnly ? TextInputType.number : TextInputType.text,
      inputFormatters:
          integerOnly ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly] : null,
      validator: (String? value) {
        if (isRequired && (value == null || value.isEmpty)) {
          return '값을 입력해주세요';
        }
        if (integerOnly && value != null && value.isNotEmpty) {
          if (int.tryParse(value) == null) {
            return '정수만 입력 가능합니다';
          }
        }
        return null;
      },
    );
  }
}
