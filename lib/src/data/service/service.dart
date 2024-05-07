import 'dart:convert';
import 'dart:io';

import 'package:atelieoliveira/src/data/model/about_model.dart';
import 'package:atelieoliveira/src/data/model/articles_model.dart';
import 'package:atelieoliveira/src/data/model/magazine_model.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

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

  Future<File> getPDF(String url, String fileName) async{
    final response = await http
        .get(Uri.parse(url));
    if (response.statusCode == 200) {
      var bytes = response.bodyBytes;
      var dir = await getFile();
      File file = File("${dir.path}/$fileName.pdf");
      File urlFile = await file.writeAsBytes(bytes);
      return urlFile;
    } else {
      throw Exception('Falha ao chamar status code: ${response.statusCode}');
    }
  }

  getFile() async {
    return getApplicationDocumentsDirectory();
  }
}
