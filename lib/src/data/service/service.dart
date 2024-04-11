import 'dart:convert';
import 'package:atelieoliveira/src/data/model/magazine_model.dart';
import 'package:http/http.dart' as http;

class Service {

  Future<MagazineModel> fetchData() async {
    final response = await http.get(Uri.parse("https://scatologika.com.br/app/json.txt"));

    if(response.statusCode == 200){
      return MagazineModel.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Falha ao chamar status code: ${response.statusCode}');
    }
  }

}