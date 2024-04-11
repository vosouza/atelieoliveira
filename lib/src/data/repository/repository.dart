import 'package:atelieoliveira/src/data/model/magazine_model.dart';
import 'package:atelieoliveira/src/data/service/service.dart';

class Repository{
  final  Service service;

  const Repository({
    required this.service
  });

  Future<MagazineModel> fetchData(){
    return service.fetchData();
  }

}