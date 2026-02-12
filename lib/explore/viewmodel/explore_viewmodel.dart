import 'package:boi_poka/models/book_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ExploreViewModel extends ChangeNotifier {
  // 1. State Variables
  Set<Marker> _markers = {};

  Set<Marker> get markers => _markers;

  List<BookModel> _recommendedBooks = [];

  List<BookModel> get recommendedBooks => _recommendedBooks;

  String? _selectedGenre;

  String? get selectedGenre => _selectedGenre;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  // 2. Map Controller
  GoogleMapController? mapController;

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
    fetchExploreData();
  }

  // 3. Data Fetching
  Future<void> fetchExploreData() async {
    _isLoading = true;
    notifyListeners();

    try {
      // In a real app, this would call Supabase with a location radius
      _recommendedBooks = _getMockRecommended();
      _generateMarkers(_recommendedBooks);
    } catch (e) {
      debugPrint("Error fetching explore data: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // 4. Filtering Logic
  void selectGenre(String genreTitle) {
    if (_selectedGenre == genreTitle) {
      _selectedGenre = null; // Toggle off
    } else {
      _selectedGenre = genreTitle;
    }

    // Filter books based on genre
    if (_selectedGenre != null) {
      _recommendedBooks = _getMockRecommended()
          .where((b) => b.category == _selectedGenre)
          .toList();
    } else {
      _recommendedBooks = _getMockRecommended();
    }

    _generateMarkers(_recommendedBooks);
    notifyListeners();
  }

  void _generateMarkers(List<BookModel> books) {
    _markers = books.map((book) {
      return Marker(
        markerId: MarkerId(book.id),
        position: LatLng(23.7947 + (int.parse(book.id) * 0.002), 90.4015),
        // Mock spread
        infoWindow: InfoWindow(title: book.title, snippet: book.author),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      );
    }).toSet();
  }

  // Mock Data for recommended section
  List<BookModel> _getMockRecommended() {
    return [
      BookModel(
        id: "101",
        title: "পদ্মা নদীর মাঝি",
        author: "Manik Bandyopadhyay",
        coverUrl: "https://picsum.photos/id/1/200/300",
        // Replace with real URL
        category: "Classic",
        distance: 0.4,
        exchangeType: ExchangeType.swap,
        description: "Classic Bengali novel.",
        condition: BookCondition.good,
      ),
      BookModel(
        id: "102",
        title: "Midnight Library",
        author: "Matt Haig",
        coverUrl: "https://picsum.photos/id/1/200/300",
        // Replace with real URL
        category: "Fiction",
        distance: 1.2,
        exchangeType: ExchangeType.lend,
        description: "A novel about choices.",
        condition: BookCondition.newCondition,
      ),
      BookModel(
        id: "102",
        title: "Midnight Library",
        author: "Matt Haig",
        coverUrl: "https://picsum.photos/id/1/200/300",
        // Replace with real URL
        category: "Fiction",
        distance: 1.2,
        exchangeType: ExchangeType.lend,
        description: "A novel about choices.",
        condition: BookCondition.newCondition,
      ),
      BookModel(
        id: "102",
        title: "Midnight Library",
        author: "Matt Haig",
        coverUrl: "https://picsum.photos/id/1/200/300",
        // Replace with real URL
        category: "Fiction",
        distance: 1.2,
        exchangeType: ExchangeType.lend,
        description: "A novel about choices.",
        condition: BookCondition.newCondition,
      ),
    ];
  }
}
