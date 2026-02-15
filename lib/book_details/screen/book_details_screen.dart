import 'package:boi_poka/models/book_model.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class BookDetailsScreen extends StatelessWidget {
  final BookModel book; // Replace with your BookModel

  const BookDetailsScreen({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // 1. Hero Image Header
          SliverAppBar(
            expandedHeight: 400,
            backgroundColor: const Color(0xFF1B4332),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: 'book-${book.id}',
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(book.coverUrl), // Or local asset
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // 2. Book Info Section
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(25),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.title,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "by ${book.author}",
                    style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 20),

                  // Quick Stats Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildStatChip("Condition", "Like New"),
                      _buildStatChip("Language", "English"),
                      _buildStatChip("Type", "Hardcover"),
                    ],
                  ),
                  _buildPosterDetails(),
                  const SizedBox(height: 30),
                  const Text(
                    "Description",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),

                  _buildDescription(),

                  const SizedBox(height: 120),
                ],
              ),
            ),
          ),
        ],
      ),

      // 3. Floating Bottom Action
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
        ),
        child: ElevatedButton(
          onPressed: () {
            // Logic for exchange request
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF00D632),
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: const Text(
            "Request Exchange",
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildPosterDetails() {
    return Column(
      children: [
        // 3. Poster Details Section
        const SizedBox(height: 25),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFF1F8E9),
            // Light green background to match the theme
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFDCEDC8)),
          ),
          child: Row(
            children: [
              // Profile Image with Verified Badge
              Stack(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                      'https://i.pravatar.cc/150?u=user123',
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.verified,
                        color: Color(0xFF00D632),
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),

              // Name, Rating, and Area
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Rakibul Hassan",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          "4.8 (24 Exchanges)",
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.grey,
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          "Dhanmondi, Dhaka",
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Message Button
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.chat_bubble_outline,
                  color: Color(0xFF1B4332),
                ),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return ReadMoreText(
      "This is where the book summary goes. In a real scenario, this would be a long string fetched from your database about the plot or condition notes.",
      trimLines: 3,
      colorClickableText: const Color(0xFF00D632),
      trimMode: TrimMode.Line,
      trimCollapsedText: ' Show more',
      trimExpandedText: ' Show less',
      moreStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1B4332),
      ),
      lessStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1B4332),
      ),
      style: TextStyle(color: Colors.grey[700], height: 1.5, fontSize: 15),
    );
  }

  Widget _buildStatChip(String label, String value) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
