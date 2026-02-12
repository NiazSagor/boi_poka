import 'package:boi_poka/models/book_model.dart';
import 'package:boi_poka/theme/theme.dart';
import 'package:flutter/material.dart';

class BookListingCard extends StatelessWidget {
  final BookModel book;
  const BookListingCard({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5)
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, // Prevents vertical overflow
        children: [
          // 1. Book Cover (Fixed height to prevent vertical overflow)
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            child: Image.network(
              book.coverUrl,
              height: 160,
              width: 160,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                  height: 160,
                  color: Colors.grey[200],
                  child: const Icon(Icons.book)
              ),
            ),
          ),

          // 2. Content Area
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title - Wrapped to prevent horizontal overflow
                Text(
                  book.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),

                // Author
                Text(
                  book.author,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),

                const SizedBox(height: 8),

                // Location/Distance row
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 12, color: BoipokaTheme.primaryGreen),
                    const SizedBox(width: 4),
                    // Wrap distance in Expanded to prevent pushing icons out
                    Expanded(
                      child: Text(
                        "${book.distance} km away",
                        style: const TextStyle(fontSize: 10),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // Exchange Type Tag
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                      color: BoipokaTheme.primaryGreen.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: Text(
                    book.exchangeType.name.toUpperCase(),
                    style: const TextStyle(
                        fontSize: 9,
                        color: BoipokaTheme.primaryGreen,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
