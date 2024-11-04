import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:librarycom/models/review_model.dart';
import 'package:librarycom/services/firebase/firestore.dart';
import 'package:librarycom/ui/components/my_button.dart';
import 'package:librarycom/ui/components/simple_textfield.dart';
import 'package:librarycom/utils/global_methods.dart';

class AddReviews extends StatefulWidget {
  const AddReviews({
    super.key,
    required this.bookId,
    required this.bookTitle,
  });

  final String bookId;
  final String bookTitle;

  @override
  State<AddReviews> createState() => _AddReviewsState();
}

class _AddReviewsState extends State<AddReviews> {
  final _firestore = Firestore();
  late final TextEditingController messageController;
  final _key = GlobalKey<FormState>();
  final store = FirebaseFirestore.instance;
  List<ReviewModel?> bookReviews = [];

  bool _isLoading = false;

  getCurrentReviews() async {
    try {
      final models = await _firestore.getReviews(widget.bookId);
      if (mounted) {
        setState(() {
          bookReviews = models;
        });
      }
    } catch (e) {
      if (mounted) {
        showSnackBar(context, "Error loading reviews: ${e.toString}");
      }
    }
  }

  submitReview() async {
    if (_key.currentState!.validate()) {
      _key.currentState!.save();

      try {
        showSnackBar(context, "Review submitted");
      } catch (e) {}
    }
  }

  @override
  void initState() {
    super.initState();
    messageController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _isLoading ? const LinearProgressIndicator() : null,
      appBar: AppBar(
        title: const Text(
          "The Miser",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "Enter review message",
              style: TextStyle(
                color: Colors.grey[800]!,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SimpleTextfield(
              hintText: "Message",
              controller: messageController,
            ),
            const SizedBox(height: 15),
            MyButton(onPressed: submitReview, btnText: "Submit"),
          ],
        ),
      ),
    );
  }
}
