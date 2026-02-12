import 'package:boi_poka/models/book_model.dart';
import 'package:flutter/material.dart';

class RecommendedBookCard extends StatelessWidget {
  final BookModel book;

  const RecommendedBookCard({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Book Cover with Distance Badge
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.network(
                  book.coverUrl,
                  height: 220,
                  width: 180,
                  fit: BoxFit.cover,
                ),
              ),
              // Distance Badge (e.g., 400m or 1.2km)
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    "${book.distance}km", // Simplified for the badge
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1B252F),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Title (Bangla/English support)
          Text(
            book.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1B252F),
            ),
          ),
          const SizedBox(height: 4),
          // Exchange Label with Icon
          Row(
            children: [
              Icon(
                book.exchangeType == ExchangeType.swap
                    ? Icons.sync
                    : Icons.front_hand_rounded,
                size: 14,
                color: const Color(0xFF8E9BAA),
              ),
              const SizedBox(width: 4),
              Text(
                book.exchangeType == ExchangeType.swap
                    ? "Exchange Only"
                    : "Free Lending",
                style: const TextStyle(fontSize: 12, color: Color(0xFF8E9BAA)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
