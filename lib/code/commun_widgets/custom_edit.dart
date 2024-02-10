import 'package:flutter/material.dart';

class CustomEdit extends StatelessWidget {
  const CustomEdit(
      {super.key, required this.hint, this.tEC, this.onchange, this.keyboard});
  final String? hint;
  final TextEditingController? tEC;
  final ValueChanged<String>? onchange;
  final TextInputType? keyboard;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 1, color: Colors.green),
          borderRadius: BorderRadius.circular(8)),
      child: TextFormField(
        onChanged: onchange,
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
        ),
        keyboardType: keyboard,
      ),
    );
  }
}
