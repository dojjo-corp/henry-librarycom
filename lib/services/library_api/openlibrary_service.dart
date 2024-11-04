// import 'dart:convert';
import 'dart:convert';
// import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:librarycom/models/book_model.dart';
// import 'package:html/parser.dart';

class OpenLibraryService {
  static String baseURL = "https://openlibrary.org/search.json?q=";

  Future<List<BookModel>> searchBooks(String query) async {
    final url = Uri.parse('$baseURL$query/public_scan=true&has_fulltext=true');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List books = data['docs'] as List;

      // return at most 30 books
      if (books.length > 30) {
        books = books.sublist(0, 30);
      }

      return books
          .map(
            (book) => BookModel(
                id: book["key"],
                topic: book["topic"],
                author: book["author_name"],
                coverURL: book["cover_i"],
                yearPublished: book["first_publish_year"],
                synopsis: book["first_sentence"]),
          )
          .toList();
    } else {
      throw Exception('Failed to load books');
    }
  }
}
