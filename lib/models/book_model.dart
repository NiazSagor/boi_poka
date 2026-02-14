import 'package:boi_poka/models/user_model.dart';

enum BookCondition { newCondition, good, old }
enum ExchangeType { swap, lend, donate }
enum BookStatus { active, requested, outOnLoan }

class BookModel {
  final String id;
  final String title;
  final String author;
  final String description;
  final String coverUrl;
  final String category;
  final BookCondition condition;
  final ExchangeType exchangeType;
  final double distance; // Calculated dynamically in the UI
  final UserModel? owner; // Nested object from the Supabase join
  final int viewCount;

  final BookStatus status;
  final int views;
  final int requestsCount;
  final bool hasNewRequest;
  final String? lentTo;

  BookModel({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.coverUrl,
    required this.category,
    required this.condition,
    required this.exchangeType,
    this.status = BookStatus.active,
    this.views = 0,
    this.requestsCount = 0,
    this.hasNewRequest = false,
    this.lentTo,
    this.distance = 0.0,
    this.owner,
    this.viewCount = 0,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      author: json['author'] ?? '',
      description: json['description'] ?? '',
      coverUrl: json['cover_url'] ?? '',
      category: json['category'] ?? 'General',
      viewCount: json['view_count'] ?? 0,
      // Mapping string from DB to Enum
      condition: _parseCondition(json['condition']),
      exchangeType: _parseExchangeType(json['exchange_type']),
      // Mapping nested profile data
      owner: json['profiles'] != null ? UserModel.fromJson(json['profiles']) : null,
    );
  }

  static BookCondition _parseCondition(String? condition) {
    switch (condition?.toLowerCase()) {
      case 'new': return BookCondition.newCondition;
      case 'old': return BookCondition.old;
      default: return BookCondition.good;
    }
  }

  static ExchangeType _parseExchangeType(String? type) {
    switch (type?.toLowerCase()) {
      case 'lend': return ExchangeType.lend;
      case 'donate': return ExchangeType.donate;
      default: return ExchangeType.swap;
    }
  }
}