import 'dart:io';

import 'package:atelieoliveira/src/data/database/shared_preferences_interface.dart';
import 'package:atelieoliveira/src/data/model/about_model.dart';
import 'package:atelieoliveira/src/data/model/articles_model.dart';
import 'package:atelieoliveira/src/data/model/magazine_model.dart';
import 'package:atelieoliveira/src/data/service/service.dart';
import 'dart:developer';

class Repository {
  final Service service;
  final IsharedPreferencs sharedPrefs;

  const Repository({required this.service, required this.sharedPrefs});

  Future<MagazineModel> fetchData() {
    try {
      return service.fetchData();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<ArticlesModel> fetchAricles() {
    try {
      return service.fetchArticles();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<AboutModel> fetchAbout() {
    try {
      return service.fetchAbout();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<File> getPDFfromURL(String url, String name) async {
    try {
      String? pathPdf = await sharedPrefs.getString(name);
      if (pathPdf != null) {
        return Future.value(File(pathPdf));
      } else {
        var pathDefault = await service.getFile();
        sharedPrefs.saveString(name, "${pathDefault.path}/$name.pdf");
        return service.getPDF(url, name);
      }
    } catch (e) {
      sharedPrefs.deleteString(name);
      throw Exception(e);
    }
  }
}
