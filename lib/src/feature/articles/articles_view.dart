import 'package:atelieoliveira/src/common/app_bar.dart';
import 'package:atelieoliveira/src/data/model/articles_model.dart';
import 'package:atelieoliveira/src/data/repository/repository.dart';
import 'package:atelieoliveira/src/feature/articles/article_webview.dart';
import 'package:flutter/material.dart';

class ArticlesView extends StatefulWidget {
  final Repository repository;
  const ArticlesView({
    required this.repository,
    super.key,
  });

  static const routeName = '/articles';

  @override
  State<StatefulWidget> createState() {
    return _ArticleViewState();
  }
}

class _ArticleViewState extends State<ArticlesView> {
  late Future<ArticlesModel> data;

  @override
  void initState() {
    data = widget.repository.fetchAricles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        const AppBarView(image: "assets/images/banner_topo.jpg"),
        FutureBuilder(
          future: data,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              ArticlesModel? article = snapshot.data;
              if (article != null) {
                return sliverWidget(article);
              } else {
                return const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(top: 64, left: 32, right: 32),
                    child: Center(
                      child: Column(
                        children: [
                          Icon(Icons.error_outline),
                          Text("Erro ao carregar notícias, por favor tente mais tarde.", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),)
                        ],
                      )
                    ),
                  ),
                );
              }
            } else {
              return const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(32),
                  child: Center(
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ],
    );
  }

  SliverList sliverWidget(ArticlesModel article) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: article.list.length,
        (context, index) {
          return articleItem(article.list[index]);
        },
      ),
    );
  }

  Widget articleItem(ArticleData article) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GestureDetector(
        child: Card(
          child: Row(
            children: [
              Image(
                height: 150,
                image: NetworkImage(article.image),
                fit: BoxFit.scaleDown,
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: Column(
                    children: [
                      Text(
                        article.title,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(article.description)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ArticlesWebView(
                url: article.site,
              ),
            ),
          );
        },
      ),
    );
  }
}
