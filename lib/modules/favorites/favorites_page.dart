import 'package:flutter/material.dart';

class FavoritesPage extends StatelessWidget {
  final Map _filmeData;

  FavoritesPage(this._filmeData);

  @override
  Widget build(BuildContext context) {
    return Container(child: Text(_filmeData['title']));
  }
}
