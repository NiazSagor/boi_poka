import 'package:boi_poka/models/book_model.dart';
import 'package:flutter/material.dart';

class MyBookCard extends StatelessWidget {
  final BookModel book;

  const MyBookCard({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Book Cover
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              book.coverUrl,
              width: 80,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          // Book Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Status Pill
                _buildStatusPill(),
                const SizedBox(height: 8),
                Text(
                  book.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1B252F),
                  ),
                ),
                Text(
                  book.author,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF8E9BAA),
                  ),
                ),
                const SizedBox(height: 12),
                // Metrics: Views and Requests
                Row(
                  children: [
                    _buildMetrics(),
                  ],
                ),
                if (book.status == BookStatus.outOnLoan && book.lentTo != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 4),
                    child: Row(
                      children: [
                        // Small avatar placeholder as seen in your design
                        CircleAvatar(
                          radius: 10,
                          backgroundColor: Colors.grey[200],
                          child: const Icon(Icons.person, size: 12, color: Colors.grey),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "Lent to ",
                          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                        ),
                        Text(
                          book.lentTo!,
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1B252F)
                          ),
                        ),
                      ],
                    ),
                  ),


              ],
            ),
          ),
          const Icon(Icons.more_horiz, color: Color(0xFF8E9BAA)),
        ],
      ),
    );
  }

  Widget _buildStatusPill() {
    final currentStatus = book.status ?? BookStatus.active;
    String label = "ACTIVE";
    Color color = const Color(0xFF2ECC71);
    if (currentStatus == BookStatus.requested) {
      label = "REQUESTED";
      color = const Color(0xFFF39C12);
    } else if (currentStatus == BookStatus.outOnLoan) {
      label = "OUT ON LOAN";
      color = const Color(0xFF3498DB);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildMetrics() {
    return Row(
      children: [
        Icon(Icons.visibility_outlined, size: 14, color: Colors.grey[400]),
        const SizedBox(width: 4),
        Text(
          "${book.views}",
          style: TextStyle(color: Colors.grey[600], fontSize: 12),
        ),
        const SizedBox(width: 16),

        // Show green "1 new" if hasNewRequest is true, otherwise show request count
        book.hasNewRequest
            ? Row(
                children: [
                  const Icon(
                    Icons.notifications_active_outlined,
                    size: 14,
                    color: Color(0xFF2ECC71),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    "1 new",
                    style: TextStyle(
                      color: Color(0xFF2ECC71),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              )
            : Row(
                children: [
                  Icon(
                    Icons.layers_outlined,
                    size: 14,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(width: 4),
                  Text(
                    "${book.requestsCount} requests",
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                ],
              ),
      ],
    );
  }
}
