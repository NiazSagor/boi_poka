import 'package:boi_poka/models/book_model.dart';
import 'package:flutter/material.dart';

class MyBooksViewModel extends ChangeNotifier {
  List<BookModel> _myCollection = [];
  List<BookModel> get myCollection => _myCollection;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchMyBooks() async {
    _isLoading = true;
    notifyListeners();

    // Simulating API call
    await Future.delayed(const Duration(milliseconds: 800));

    _myCollection = [
      BookModel(
        id: "m1",
        title: "The Alchemist",
        author: "Paulo Coelho",
        coverUrl: "https://picsum.photos/id/1/200/300",
        category: "Fiction",
        distance: 0,
        exchangeType: ExchangeType.swap,
        description: "A beautiful story about following your dreams.",
        condition: BookCondition.good,
      ),
      BookModel(
        id: "m2",
        title: "Sapiens",
        author: "Yuval Noah Harari",
        coverUrl: "https://picsum.photos/id/1/200/300",
        category: "Academic",
        distance: 0,
        exchangeType: ExchangeType.donate,
        description: "A brief history of humankind.",
        condition: BookCondition.newCondition,
      ),
    ];

    _isLoading = false;
    notifyListeners();
  }

  void removeBook(String id) {
    _myCollection.removeWhere((book) => book.id == id);
    notifyListeners();
  }
}
