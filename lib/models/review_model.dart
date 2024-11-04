import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewModel {
  String id;
  final String bookTitle;
  final String bookId;
  final String reviewer;
  final String reviewMessage;
  final Timestamp timestamp;

  ReviewModel({
    required this.id,
    required this.bookTitle,
    required this.bookId,
    required this.reviewer,
    required this.reviewMessage,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() => {
        "id": id,
        "bookTitle": bookTitle,
        "bookId": bookId,
        "reviewer": reviewer,
        "reviewMessage": reviewMessage,
        "timestamp": timestamp,
      };

  factory ReviewModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();

    return ReviewModel(
      id: data?["id"],
      bookTitle: data?["bookTitle"],
      bookId: data?["bookId"],
      reviewer: data?["reviewer"],
      reviewMessage: data?["reviewMessage"],
      timestamp: data?["timestamp"],
    );
  }

  factory ReviewModel.fromJSON(Map<String, dynamic> reviewMap) {
    return ReviewModel(
      id: reviewMap["id"],
      bookTitle: reviewMap["bookTitle"],
      bookId: reviewMap["bookId"],
      reviewer: reviewMap["reviewer"],
      reviewMessage: reviewMap["reviewMessage"],
      timestamp: reviewMap["timestamp"],
    );
  }
}
