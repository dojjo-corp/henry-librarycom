import 'package:flutter/material.dart';
import 'package:librarycom/models/book_model.dart';
import 'package:librarycom/ui/components/my_button.dart';
import 'package:librarycom/ui/pages/reviews/add_reviews.dart';

class BookDetailsPage extends StatelessWidget {
  const BookDetailsPage({super.key, required this.model});

  final BookModel model;

  @override
  Widget build(BuildContext context) {
    final book = model.toMap();

    return Scaffold(
      appBar: AppBar(
        title: Text(book['title']!),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Title: ${book['title']}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // todo: AUTHOR
            Text(
              'Author: ${book['author']}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            // todo: PUBLICAITON YEAR
            Text(
              'Year: ${book['yearPublished']}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),

            // todo: SYNOPSIS
            Text(
              book["firstSentence"],
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            MyButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddReviews(
                      bookTitle: book["topic"],
                      bookId: book["id"],
                    ),
                  ),
                );
              },
              btnText: "Go to reviews",
            )
          ],
        ),
      ),
    );
  }
}
