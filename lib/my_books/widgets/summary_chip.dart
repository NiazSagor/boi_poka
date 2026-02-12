import 'package:flutter/material.dart';

class SummaryChip extends StatelessWidget {
  final String label;
  final String subLabel;
  final Color color;
  final Color textColor;

  const SummaryChip({
    super.key,
    required this.label,
    required this.subLabel,
    required this.color,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: textColor.withOpacity(0.1)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(width: 8),
          Text(
            subLabel,
            style: TextStyle(color: textColor, fontWeight: FontWeight.w600, fontSize: 10, letterSpacing: 0.5),
          ),
        ],
      ),
    );
  }
}
