import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:my_movies/modules/filme_details/filme_details.dart';
import 'package:my_movies/shared/models/filmes.dart';
import 'package:my_movies/shared/themes/app_colors.dart';
import 'package:my_movies/shared/themes/app_text_styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'favorites_controller.dart';

class FavoritesPage extends StatefulWidget {
  String _filmeData;
  FavoritesPage(this._filmeData);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  String? _id;
  String API_KEY = 'a6cdc67360309a1b55509d7480d2d14c';

  void favoritos(_filmeData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("favorites", _filmeData);

    final favorites = prefs.getInt("favorites");
    return;
  }

  Future<Map> _getDetails() async {
    http.Response response;
    try {
      response = await http.get(Uri.parse(
          "https://api.themoviedb.org/3/movie/$_id?api_key=$API_KEY&language=pt-BR"));
      return json.decode(response.body);
    } catch (error) {
      throw Exception("Nenhum favorito encontrado");
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = FavoriteController();
    return Scaffold(
      appBar: AppBar(
        title: Text("Meus Favoritos"),
        backgroundColor: AppColors.primary,
      ),
      body: Column(
        children: [
          FutureBuilder(
            future: _getDetails(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                case ConnectionState.none:
                  return Container(
                    width: 200.0,
                    height: 200.0,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(AppColors.primary),
                      strokeWidth: 5.0,
                    ),
                  );
                default:
                  if (snapshot.hasError)
                    return Container(
                      child: Text("Titulo não encontrado..."),
                    );
                  else
                    return _createFavList(context, snapshot);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _createFavList(BuildContext context, AsyncSnapshot snapshot) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10.0,
        left: 10.0,
        right: 10.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Minha Lista",
            style: TextStyles.titleBoldBackground,
          ),
          Divider(color: AppColors.stroke),
          SizedBox(
            height: 200.0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network(
                            "https://image.tmdb.org/t/p/w500" +
                                snapshot.data["poster_path"],
                            height: 150,
                            fit: BoxFit.cover,
                          )),
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) =>
                        //           FilmeDetails(widget._filmeData.)),
                        // );
                        // print(snapshot.data["results"][index]);
                      });
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
