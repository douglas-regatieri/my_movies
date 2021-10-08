import 'package:flutter/material.dart';
import 'package:my_movies/shared/themes/app_colors.dart';

class FilmeDetails extends StatelessWidget {
  final Map _filmeData;

  FilmeDetails(this._filmeData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120),
        child: Container(
          height: 120,
          color: AppColors.primary,
          child: Center(child: Text(_filmeData["title"])),
        ),
      ),
      body: Image.network("https://image.tmdb.org/t/p/w500" +
          _filmeData["results"]["backdrop_path"]),
    );
  }
}
