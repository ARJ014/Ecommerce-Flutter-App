import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Ratings {
  final String userId;
  final double ratings;
  Ratings({
    required this.userId,
    required this.ratings,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'ratings': ratings,
    };
  }

  factory Ratings.fromMap(Map<String, dynamic> map) {
    return Ratings(
      userId: map['userId'] as String,
      ratings: map['ratings'].toDouble() as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Ratings.fromJson(String source) =>
      Ratings.fromMap(json.decode(source) as Map<String, dynamic>);
}
