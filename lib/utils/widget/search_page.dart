import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SearchPage extends StatelessWidget {
  final imageUrl;
  SearchPage({this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Image.asset(
          imageUrl,
          width: 150,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          elevation: 3,
          borderRadius: BorderRadius.circular(3),
          child: TextField(
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: "Cari",
              border: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(3),
                  borderSide: BorderSide.none),
              suffixIcon: Icon(Icons.search, color: Colors.black45),
            ),
          ),
        ),
      ),
    );
  }
}
