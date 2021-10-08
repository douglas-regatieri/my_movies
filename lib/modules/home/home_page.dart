import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_movies/modules/filme_details/filme_details.dart';

import 'package:my_movies/shared/models/user_model.dart';
import 'package:my_movies/shared/themes/app_colors.dart';
import 'package:my_movies/shared/themes/app_text_styles.dart';

class HomePage extends StatefulWidget {
  final UserModel user;
  const HomePage({Key? key, required this.user}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _search;
  int page = 1;
  String API_KEY = 'a6cdc67360309a1b55509d7480d2d14c';

  Future<Map> _getSearch() async {
    http.Response response;

    // ignore: unnecessary_null_comparison
    if (_search == null) {
      response = await http.get(Uri.parse(
          "https://api.themoviedb.org/3/movie/popular?api_key=$API_KEY&language=pt-BR&page=$page"));
    } else {
      response = await http.get(Uri.parse(
          "https://api.themoviedb.org/3/search/movie?api_key=$API_KEY&query=$_search"));
    }
    return json.decode(response.body);
  }

  @override
  void initState() {
    super.initState();
    _getSearch().then((map) {
      print(map);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(152),
        child: Container(
          height: 152,
          color: AppColors.primary,
          child: Center(
            child: ListTile(
                title: Text.rich(
                  TextSpan(
                    text: "Olá, ",
                    style: TextStyles.titleRegular,
                    children: [
                      TextSpan(
                        text: "${widget.user.name}",
                        style: TextStyles.titleBoldBackground,
                      ),
                    ],
                  ),
                ),
                subtitle: Text(
                  "Mantenha suas contas em dia",
                  style: TextStyles.captionShape,
                ),
                trailing: Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                      image: NetworkImage(widget.user.photoURL!),
                    ),
                  ),
                )),
          ),
        ),
      ),
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: "Pesquise",
                labelStyle: TextStyle(color: AppColors.grey),
                border: OutlineInputBorder(),
              ),
              style: TextStyle(color: Colors.black, fontSize: 18.0),
              textAlign: TextAlign.left,
              onSubmitted: (text) {
                setState(() {
                  _search = text;
                });
              },
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: _getSearch(),
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
                      return Container(child: Text("Faça uma pesquisa!"));
                    else
                      return _createPopList(context, snapshot);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _createPopList(BuildContext context, AsyncSnapshot snapshot) {
    return GridView.builder(
      padding: EdgeInsets.all(20.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
      ),
      itemCount: snapshot.data["results"].length,
      itemBuilder: (context, index) {
        return GestureDetector(
          child: Column(
            children: [
              Image.network(
                "https://image.tmdb.org/t/p/w500" +
                    snapshot.data["results"][index]["poster_path"],
                height: 300,
                fit: BoxFit.contain,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  bottom: 20,
                ),
                child: Text(
                  snapshot.data["results"][index]["title"],
                  style: TextStyles.buttonBoldHeading,
                ),
              ),
            ],
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        FilmeDetails(snapshot.data["results"][index])));
          },
        );
      },
    );
  }
}
