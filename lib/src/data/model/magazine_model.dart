class MagazineModel{
  final List<EditionModel> magazineList;

  const MagazineModel({
    required this.magazineList
  });

  factory MagazineModel.fromJson(Map<String, dynamic> json){
    final List<dynamic> jsonPdf = json['revista'];

    return MagazineModel(magazineList: jsonPdf.map((e){
        return EditionModel.fromJson(e);
    }).toList()
    );
    
  }
}

class EditionModel{
  final String title;
  final String image;
  final String pdf;

  const EditionModel({
    required this.title,
    required this.image,
    required this.pdf,
  });

  factory EditionModel.fromJson(Map<String, dynamic> data){
    final jsonTitle = data['titulo'];
    final jsonImg = data['imagem'];
    final jsonPdf = data['pdf'];

    return EditionModel(title: jsonTitle, image: jsonImg, pdf: jsonPdf);
  }
}