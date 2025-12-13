import 'package:flutter/material.dart';

class CustomSnackbar extends StatelessWidget {
  final String message;
  const CustomSnackbar({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFFF50057),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
