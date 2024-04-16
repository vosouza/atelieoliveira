import 'dart:convert';

import 'package:atelieoliveira/src/data/model/about_model.dart';
import 'package:atelieoliveira/src/data/model/articles_model.dart';
import 'package:atelieoliveira/src/data/model/magazine_model.dart';
import 'package:http/http.dart' as http;

class Service {
  Future<MagazineModel> fetchData() async {
    final response =
        await http.get(Uri.parse("https://scatologika.com.br/app/json.json"));
    if (response.statusCode == 200) {
      return MagazineModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Falha ao chamar status code: ${response.statusCode}');
    }
  }

  Future<ArticlesModel> fetchArticles() async {
    final response = await http
        .get(Uri.parse("https://scatologika.com.br/app/articles.json"));
    if (response.statusCode == 200) {
      return ArticlesModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Falha ao chamar status code: ${response.statusCode}');
    }
  }

  Future<AboutModel> fetchAbout() async {
    final response = await http
        .get(Uri.parse("https://scatologika.com.br/app/contact.json"));
    if (response.statusCode == 200) {
      return AboutModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Falha ao chamar status code: ${response.statusCode}');
    }
  }
}
