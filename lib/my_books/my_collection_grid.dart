import 'package:boi_poka/my_books/components/my_book_card.dart';
import 'package:boi_poka/my_books/viewmodel/my_books_viewmodel.dart';
import 'package:boi_poka/my_books/widgets/tab_selector.dart'
    show MyBooksTabSelector;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/summary_chip.dart';

class MyCollection extends StatelessWidget {
  const MyCollection({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MyBooksViewModel>();
    return Scaffold(
      backgroundColor: const Color(0xFFF9FBFB),
      appBar: AppBar(
        title: const Text(
          "My Books Dashboard",
          style: TextStyle(
            color: Color(0xFF1B252F),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.tune_rounded)),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          // 1. Top Tab Selector
          const MyBooksTabSelector(),

          // 2. Summary Statistics Chips
          const SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Row(
              children: [
                SummaryChip(
                  label: "12",
                  subLabel: "ACTIVE BOOKS",
                  color: Color(0xFFE8F5E9),
                  textColor: Color(0xFF4CAF50),
                ),
                SizedBox(width: 10),
                SummaryChip(
                  label: "3",
                  subLabel: "PENDING REQUESTS",
                  color: Color(0xFFFFF3E0),
                  textColor: Color(0xFFFB8C00),
                ),
                SizedBox(width: 10),
                SummaryChip(
                  label: "158",
                  subLabel: "TOTAL VIEWS",
                  color: Color(0xFFE3F2FD),
                  textColor: Color(0xFF2196F3),
                ),
              ],
            ),
          ),

          // 3. List of Books
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: 4,
              itemBuilder: (context, index) =>
                  MyBookCard(book: viewModel.myCollection[index]),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF00D632),
        child: const Icon(Icons.add, size: 30),
      ),
    );
  }
}
