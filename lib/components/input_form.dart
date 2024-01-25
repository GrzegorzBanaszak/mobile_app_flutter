import 'package:flutter/material.dart';

import 'package:mobile_app/utilis/my_colors.dart';

enum CustomInputFormIcon { USER, EMAIL, PASSWORD }

class CustomInputForm extends StatefulWidget {
  final String placeholder;
  final CustomInputFormIcon icon;
  final FormFieldValidator<String>? validator;
  final TextEditingController controller;
  const CustomInputForm({
    required this.placeholder,
    required this.icon,
    required this.validator,
    required this.controller,
    super.key,
  });

  IconData getIcon() {
    if (icon == CustomInputFormIcon.USER) {
      return Icons.person_2_outlined;
    } else if (icon == CustomInputFormIcon.EMAIL) {
      return Icons.email_outlined;
    } else {
      return Icons.lock_outline;
    }
  }

  @override
  State<CustomInputForm> createState() => _CustomInputFormState();
}

class _CustomInputFormState extends State<CustomInputForm> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      controller: widget.controller,
      obscureText: widget.icon == CustomInputFormIcon.PASSWORD,
      decoration: InputDecoration(
        hintStyle: const TextStyle(color: Colors.black38, fontSize: 15),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            width: 2,
            color: MyColors.pinkColor,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            width: 2,
            color: MyColors.pinkColor,
          ),
        ),
        hintText: widget.placeholder,
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        prefixIcon: Icon(
          widget.getIcon(),
          color: MyColors.pinkColor,
        ),
      ),
    );
  }
}
