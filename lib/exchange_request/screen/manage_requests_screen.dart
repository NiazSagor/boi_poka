import 'package:flutter/material.dart';

class ManageRequestsScreen extends StatelessWidget {
  const ManageRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: const Color(0xFFF9F8F4),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: const BackButton(color: Colors.black),
          title: const Text(
            "Manage Requests",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.tune, color: Color(0xFF00D632)),
              onPressed: () {},
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(25),
              ),
              child: TabBar(
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: const Color(0xFF00D632),
                ),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey,
                tabs: const [
                  Tab(text: "Incoming"),
                  Tab(text: "Sent"),
                  Tab(text: "History"),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            _buildRequestList(), // Incoming
            const Center(child: Text("Sent Requests")),
            const Center(child: Text("Past History")),
          ],
        ),
      ),
    );
  }

  Widget _buildRequestList() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _buildPendingRequestCard(),
        const SizedBox(height: 20),
        _buildAcceptedRequestCard(),
        const SizedBox(height: 20),
        _buildDeclinedRequestCard(),
      ],
    );
  }

  Widget _buildDeclinedRequestCard() {
    return Opacity(
      opacity: 0.8, // Slightly faded look for inactive cards
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Info Row
            Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.grey,
                  backgroundImage: NetworkImage(
                    'https://i.pravatar.cc/150?u=3',
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Rahat Kabir",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        "Declined 1 day ago",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                _buildStatusBadge("DECLINED", Colors.grey[100]!, Colors.grey),
              ],
            ),
            const SizedBox(height: 16),

            // Decline Reason Bubble
            Container(
              padding: const EdgeInsets.all(12),
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFF8F9FA),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                "\"Sorry, I've already traded this book with someone else.\"",
                style: TextStyle(
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAcceptedRequestCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          // User Info Row
          Row(
            children: [
              const CircleAvatar(
                backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=2'),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Anika Tabassum",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "⭐ 5.0 (12 trades)",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              _buildStatusBadge(
                "ACCEPTED",
                const Color(0xFFE3F2FD),
                const Color(0xFF2196F3),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Simplified Trade Info
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildCompactBookInfo("1984 - Orwell", "You are giving"),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.compare_arrows, color: Colors.grey),
              ),
              _buildCompactBookInfo("Norwegian Wood", "Receiving"),
            ],
          ),

          const SizedBox(height: 20),

          // Coordination Button
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.chat_bubble_rounded, size: 18),
            label: const Text("Message Anika to coordinate"),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF0F2F5),
              foregroundColor: const Color(0xFF4B5563),
              elevation: 0,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompactBookInfo(String title, String label) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey)),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildPendingRequestCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          // User Info Row
          Row(
            children: [
              const CircleAvatar(
                backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=1'),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Sabbir Ahmed",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "⭐ 4.8 (24 trades)",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              _buildStatusBadge("PENDING", Colors.green[50]!, Colors.green),
            ],
          ),
          const SizedBox(height: 20),

          // The Trade Visualization
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildBookWithLabel("The Great Gatsby", "MINE", Colors.blueGrey),
              const CircleAvatar(
                backgroundColor: Color(0xFFE8F5E9),
                child: Icon(Icons.swap_horiz, color: Color(0xFF00D632)),
              ),
              _buildBookWithLabel("Pather Panchali", "THEIR", Colors.green),
            ],
          ),

          const SizedBox(height: 20),

          // Actions
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    side: BorderSide(color: Colors.grey[300]!),
                  ),
                  child: const Text(
                    "Decline",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00D632),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Accept Exchange",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String text, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildBookWithLabel(String title, String label, Color color) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: 80,
              width: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey[300],
              ),
            ),
            Positioned(
              top: -5,
              right: -5,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
