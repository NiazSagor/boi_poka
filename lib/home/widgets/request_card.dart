import 'package:boi_poka/models/book_model.dart';
import 'package:boi_poka/theme/theme.dart';
import 'package:flutter/material.dart';

class HomeRequestGridCard extends StatelessWidget {
  final BookModel book; // The book the requester is 'Looking For'
  const HomeRequestGridCard({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Info with Online Indicator
          Row(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 14,
                    backgroundColor: Colors.grey[200],
                    backgroundImage: NetworkImage(book.owner?.avatarUrl ?? 'https://i.pravatar.cc/150'),
                  ),
                  // Online Indicator Dot
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: BoipokaTheme.primaryGreen,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 1.5),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 8),
              Text(
                book.owner?.fullName ?? "Member",
                style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF5D6A78),
                    fontWeight: FontWeight.w500
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // "Looking For" Header
          const Text(
            "LOOKING FOR:",
            style: TextStyle(
              color: BoipokaTheme.primaryGreen,
              fontSize: 11,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 4),
          // Requested Book Title
          Text(
            book.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1B252F),
            ),
          ),
          const Spacer(),
          // Separator Line
          Divider(color: Colors.grey[200], thickness: 1),
          const SizedBox(height: 8),
          // Offered Book Info
          Row(
            children: [
              const Icon(Icons.sync_rounded, size: 14, color: Color(0xFF8E9BAA)),
              const SizedBox(width: 6),
              const Text(
                "For: ",
                style: TextStyle(fontSize: 12, color: Color(0xFF8E9BAA)),
              ),
              Expanded(
                child: Text(
                  "Life of Pi", // Replace with real 'offered' book data
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF5D6A78),
                      fontWeight: FontWeight.w500
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
