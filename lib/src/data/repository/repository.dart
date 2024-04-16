import 'package:atelieoliveira/src/data/model/about_model.dart';
import 'package:atelieoliveira/src/data/model/articles_model.dart';
import 'package:atelieoliveira/src/data/model/magazine_model.dart';
import 'package:atelieoliveira/src/data/service/service.dart';
import 'dart:developer';

class Repository{
  final  Service service;

  const Repository({
    required this.service
  });

  Future<MagazineModel> fetchData(){
    try{
      return service.fetchData();
    }catch(e){
      log(e.toString());
      rethrow;
    }
  }

  Future<ArticlesModel> fetchAricles(){
    try{
      return service.fetchArticles();
    }catch(e){
      log(e.toString());
      rethrow;
    }
  }

  Future<AboutModel> fetchAbout(){
    try{
      return service.fetchAbout();
    }catch(e){
      log(e.toString());
      rethrow;
    }
  }
}