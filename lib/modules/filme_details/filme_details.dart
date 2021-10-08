import 'package:flutter/material.dart';
import 'package:my_movies/shared/themes/app_colors.dart';
import 'package:my_movies/shared/themes/app_text_styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FilmeDetails extends StatelessWidget {
  final Map _filmeData;

  FilmeDetails(this._filmeData);

  void favoritos(_filmeData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("id", _filmeData["id"]);

    final ids = prefs.getInt("ids") ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(130),
        child: Container(
          height: 130,
          color: AppColors.primary,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Text(
                _filmeData["title"],
                style: TextStyles.titleSinopse,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
      backgroundColor: AppColors.delete,
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.network(
                "https://image.tmdb.org/t/p/w500" + _filmeData["backdrop_path"],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20),
                child: Text(
                  "Sinopse",
                  style: TextStyles.trailingBold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  _filmeData["overview"],
                  style: TextStyles.trailingRegular,
                  textAlign: TextAlign.justify,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 50, left: 60, right: 60, bottom: 60),
                child: Container(
                  height: 50,
                  width: 100,
                  color: AppColors.primary,
                  child: TextButton(
                      onPressed: () {
                        favoritos(_filmeData);
                      },
                      child: Text("Adicionar aos Favoritos",
                          style: TextStyles.buttonBackground)),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
