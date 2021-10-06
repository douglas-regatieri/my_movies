import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_movies/shared/models/filmes.dart';

const API_KEY = "a6cdc67360309a1b55509d7480d2d14c";

class Api {
  search(String search) async {
    http.Response response = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/search/movie?api_key=$API_KEY&query=$search"));

    decode(response);
  }

  List<FilmeModel> decode(http.Response response) {
    if (response.statusCode == 200) {
      var decoded = json.decode(response.body);

      List<FilmeModel> filmes = decoded["results"].map<FilmeModel>((map) {
        return FilmeModel.fromJson(map);
      }).toList();
      // print(filmes); Verificando se o retorno da Lista deu certo!! Graças a Deus, deu...
      return filmes;
    } else {
      throw Exception("Faild to load movies");
    }
  }
}
