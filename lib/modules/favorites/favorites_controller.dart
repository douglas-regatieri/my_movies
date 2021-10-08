import 'package:flutter/material.dart';
import 'package:my_movies/shared/models/filmes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteController {
  FilmeModel? _filmeData;

  Future<void> saveFavorites(FilmeModel filme) async {
    final instance = await SharedPreferences.getInstance();
    await instance.setString("favorites", filme.toJson());
    return;
  }

  void getFavorites() async {
    try {
      final instance = await SharedPreferences.getInstance();
      final response = instance.getStringList("favorites");
      final filmes = response!.map((e) => FilmeModel.fromJson(e)).toList();
      return;
    } catch (e) {}
  }

  // Future<void> allFavorites() async {
  //   final instance = await SharedPreferences.getInstance();
  //   if (instance.containsKey("favorites")) {
  //     final json = instance.get("favorites") as String;
  //     await instance.setString("favorites", json);
  //     return;
  //   }
  // }
}
