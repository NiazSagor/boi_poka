class UserModel {
  final String id;
  final String fullName;
  final String? avatarUrl;
  final String location;
  final double rating;
  final bool isVerified;
  final int completedExchanges;

  UserModel({
    required this.id,
    required this.fullName,
    this.avatarUrl,
    required this.location,
    this.rating = 0.0,
    this.isVerified = false,
    this.completedExchanges = 0,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      fullName: json['full_name'] ?? 'Anonymous User',
      avatarUrl: json['avatar_url'],
      location: json['location'] ?? 'Unknown, Bangladesh',
      rating: (json['rating'] ?? 0.0).toDouble(),
      isVerified: json['is_verified'] ?? false,
      completedExchanges: json['completed_exchanges'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'full_name': fullName,
    'avatar_url': avatarUrl,
    'location': location,
    'is_verified': isVerified,
  };
}
