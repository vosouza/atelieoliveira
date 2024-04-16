class ArticlesModel{
  final List<ArticleData> list;

  ArticlesModel({
    required this.list
  });

  factory ArticlesModel.fromJson(Iterable data){
    final jsonList = data.map((e) {
      return ArticleData.fromJson(e);
    },);

    return ArticlesModel(list: jsonList.toList());
  }

}

class ArticleData{
  final String title;
  final String image;
  final String description;
  final String site;

  const ArticleData({
    required this.title,
    required this.image,
    required this.description,
    required this.site,
  });

  factory ArticleData.fromJson(Map<String, dynamic> data){
    final jsonTitle = data['titulo'];
    final jsonImg = data['imagem'];
    final jsonDesciption = data['descricao'];
    final jsonSite = data['site'];

    return ArticleData(title: jsonTitle, image: jsonImg, description: jsonDesciption,site: jsonSite);
  }
}