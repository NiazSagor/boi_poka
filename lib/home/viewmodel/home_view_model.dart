import 'package:boi_poka/models/book_model.dart';
import 'package:boi_poka/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class HomeViewModel extends ChangeNotifier {
  // final SupabaseClient _supabase = Supabase.instance.client;

  HomeStatus _status = HomeStatus.initial;
  HomeStatus get status => _status;

  List<BookModel> _nearbyBooks = [];
  List<BookModel> get nearbyBooks => _nearbyBooks;

  List<BookModel> _popularBooks = [];
  List<BookModel> get popularBooks => _popularBooks;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  /// Fetches all data for the Home Screen
  Future<void> fetchHomeData() async {
    _status = HomeStatus.loading;
    notifyListeners();

    try {
      // Running multiple queries in parallel for efficiency
      // await Future.wait([
      //   _getNearbyBooks(),
      //   _getPopularBooks(),
      // ]);
      _nearbyBooks = _generateMockBooks();
      _popularBooks = _generateMockBooks().reversed.toList();
      _status = HomeStatus.loaded;

      _status = HomeStatus.loaded;
    } catch (e) {
      _errorMessage = e.toString();
      _status = HomeStatus.error;
    } finally {
      notifyListeners();
    }
  }

  // Future<void> _getNearbyBooks() async {
  //   // In a real app, we would use PostGIS or a search radius filter
  //   // For now, we fetch books filtered by the user's city
  //   final response = await _supabase
  //       .from('books')
  //       .select('*, profiles(full_name, avatar_url)')
  //       .eq('status', 'available')
  //       .limit(10);
  //
  //   _nearbyBooks = response.map((json) => BookModel.fromJson(json)).toList();
  // }
  //
  // Future<void> _getPopularBooks() async {
  //   // Fetching books with the highest view counts or specific 'popular' tag
  //   final response = await _supabase
  //       .from('books')
  //       .select('*, profiles(full_name, avatar_url)')
  //       .order('view_count', ascending: false)
  //       .limit(5);
  //
  //   _popularBooks = response.map((json) => BookModel.fromJson(json)).toList();
  // }

  // Logic for the Search bar
  void onSearch(String query) {
    // Navigate to Explore or filter local list
    print("Searching for: $query");
  }

  List<BookModel> _generateMockBooks() {
    return [
      BookModel(
        id: "1",
        title: "Pather Panchali",
        author: "Bibhutibhushan Bandyopadhyay",
        description: "A classic of Bengali literature.",
        coverUrl: "https://picsum.photos/id/1/200/300",
        category: "Classic",
        condition: BookCondition.good,
        exchangeType: ExchangeType.swap,
        distance: 1.2,
      ),
      BookModel(
        id: "2",
        title: "The Namesake",
        author: "Jhumpa Lahiri",
        description: "A story about identity and culture.",
        coverUrl: "https://picsum.photos/id/1/200/300",
        category: "Fiction",
        condition: BookCondition.newCondition,
        exchangeType: ExchangeType.donate,
        distance: 3.5,
      ),
      BookModel(
        id: "2",
        title: "The Namesake",
        author: "Jhumpa Lahiri",
        description: "A story about identity and culture.",
        coverUrl: "https://picsum.photos/id/1/200/300",
        category: "Fiction",
        condition: BookCondition.newCondition,
        exchangeType: ExchangeType.donate,
        distance: 3.5,
      ),
      BookModel(
        id: "2",
        title: "The Namesake",
        author: "Jhumpa Lahiri",
        description: "A story about identity and culture.",
        coverUrl: "https://picsum.photos/id/1/200/300",
        category: "Fiction",
        condition: BookCondition.newCondition,
        exchangeType: ExchangeType.donate,
        distance: 3.5,
      ),
      BookModel(
        id: "2",
        title: "The Namesake",
        author: "Jhumpa Lahiri",
        description: "A story about identity and culture.",
        coverUrl: "https://picsum.photos/id/1/200/300",
        category: "Fiction",
        condition: BookCondition.newCondition,
        exchangeType: ExchangeType.donate,
        distance: 3.5,
      ),
      BookModel(
        id: "2",
        title: "The Namesake",
        author: "Jhumpa Lahiri",
        description: "A story about identity and culture.",
        coverUrl: "https://picsum.photos/id/1/200/300",
        category: "Fiction",
        condition: BookCondition.newCondition,
        exchangeType: ExchangeType.donate,
        distance: 3.5,
      ),
      BookModel(
        id: "2",
        title: "The Namesake",
        author: "Jhumpa Lahiri",
        description: "A story about identity and culture.",
        coverUrl: "https://picsum.photos/id/1/200/300",
        category: "Fiction",
        condition: BookCondition.newCondition,
        exchangeType: ExchangeType.donate,
        distance: 3.5,
      ),
      // Add 2-3 more to see the horizontal scroll in action
    ];
  }
}
