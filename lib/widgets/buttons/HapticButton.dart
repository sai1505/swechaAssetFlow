import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HapticButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;
  final TextDecoration textDecoration;
  final double radius;
  final EdgeInsets padding;

  const HapticButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color = const Color(0xFFF50057),
    this.textColor = Colors.white,
    this.textDecoration = TextDecoration.none,
    this.radius = 25,
    this.padding = const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.mediumImpact(); // 🔥 custom haptic
        onPressed();
      },
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: textColor,
            fontSize: 18,
            decoration: textDecoration,
            decorationColor: Colors.grey,
          ),
        ),
      ),
    );
  }
}
