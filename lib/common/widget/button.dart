// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback ontap;
  final Color? color;
  const CustomButton({
    Key? key,
    required this.text,
    required this.ontap,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: ontap,
      style: ElevatedButton.styleFrom(
          backgroundColor: color, minimumSize: const Size(double.infinity, 50)),
      child: Text(
        text,
        style: TextStyle(color: color != null ? Colors.black : Colors.white),
      ),
    );
  }
}
