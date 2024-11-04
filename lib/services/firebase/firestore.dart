import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:librarycom/models/review_model.dart';
import 'package:librarycom/models/user_model.dart';

class Firestore {
  static final store = FirebaseFirestore.instance;

  Future<List<ReviewModel>> getReviews(
    String bookId,
  ) async {
    try {
      final snapshot = await store.collection("All Reviews").get();
      final docs = snapshot.docs;
      // retrieve reviews for [bookId]
      final reviewDocs = docs.where((doc) {
        final data = doc.data();
        return data["bookId"] == bookId;
      }).toList();

      // if (reviewDocs.isEmpty) {
      //   throw Exception("No review found");
      // }

      // convert maps to reviewModels
      final List<ReviewModel> reviewModels = reviewDocs
          .map((reviewMap) => ReviewModel.fromJSON(reviewMap.data()))
          .toList();
      return reviewModels;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> sendReview(String bookId, ReviewModel reviewModel) async {
    try {
      final ref = store.collection("All Reviews").doc();
      reviewModel.id = ref.id;
      await store
          .collection("All Reviews")
          .doc(bookId)
          .set(reviewModel.toMap());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createUserDoc({
    required String email,
    required String username,
    // required String emoteURL,
  }) async {
    try {
      final ref = store.collection("All Users").doc();
      final userModel = UserModel(
        id: ref.id,
        email: email,
        username: username,
      );

      ref.set(userModel.toMap());
    } catch (e) {
      rethrow;
    }
  }
}
