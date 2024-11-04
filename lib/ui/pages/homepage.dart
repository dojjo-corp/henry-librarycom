// ignore: unused_import
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:librarycom/models/book_model.dart';
import 'package:librarycom/services/library_api/openlibrary_service.dart';
import 'package:librarycom/ui/components/my_drawer.dart';
import 'package:librarycom/ui/pages/book_details.dart';
import 'package:librarycom/utils/global_methods.dart';
// import 'package:librarycom/services/library_api/gutenberg_service.dart';

class Homepage extends StatefulWidget {
  const Homepage({
    super.key,
  });

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late final TextEditingController searchController;
  String searchedTerm = "";
  List<BookModel> searchResults = [];

  // ignore: prefer_final_fields
  bool _isLoading = false;

  _getBooks(String searchTerm) async {
    try {
      final libraryService = OpenLibraryService();
      final searchedBooks = await libraryService.searchBooks(searchTerm);

      if (mounted) {
        setState(() {
          searchResults = searchedBooks;
        });
      }
    } catch (e) {
      if (mounted) {
        showSnackBar(
          context,
          "Error making query: ${e.toString()}",
        );
      }
    }
  }

  clearSearch() {
    setState(() {
      searchResults.clear();
      searchController.clear();
    });
  }

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _isLoading ? const LinearProgressIndicator() : null,
      drawer: const MyDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: TextFormField(
          controller: searchController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(12),
            ),
            filled: true,
            fillColor: Colors.white70,
            suffixIcon: IconButton(
              onPressed: clearSearch,
              icon: const Icon(
                Icons.clear_rounded,
                color: Color.fromARGB(255, 220, 158, 158),
              ),
            ),
          ),
          onChanged: (String? value) {
            if (value == null) return;
            _getBooks(value);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: searchResults.length,
        // gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        // maxCrossAxisExtent: MediaQuery.sizeOf(context).width * 0.5,
        // ),
        itemBuilder: (context, index) {
          if (searchResults.isEmpty) {
            return const Center(
              child: Text("Search book title above..."),
            );
          }
          final book = searchResults[index];

          return ListTile(
            leading: Image.network(
              book.coverURL,
              height: 100,
              width: 80,
              color: Colors.grey[400],
            ),
            title: Text(
              book.topic,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              book.synopsis,
              style: TextStyle(
                color: Colors.grey[800]!,
              ),
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              maxLines: 2,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookDetailsPage(
                    model: book,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
