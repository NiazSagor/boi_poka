import 'package:boi_poka/models/genre.dart';
import 'package:flutter/material.dart';

class GenreCard extends StatelessWidget {
  final Genre genre;
  const GenreCard({super.key, required this.genre});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon Container
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: genre.bgColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(genre.icon, color: genre.iconColor, size: 24),
          ),
          const Spacer(),
          // English Title
          Text(
            genre.title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1B252F),
            ),
          ),
          // Bangla Subtitle
          Text(
            genre.subtitle,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF8E9BAA),
              fontFamily: 'Hind Siliguri', // Ensure this is in pubspec
            ),
          ),
        ],
      ),
    );
  }
}
