import 'package:atelieoliveira/src/common/app_bar.dart';
import 'package:atelieoliveira/src/data/model/about_model.dart';
import 'package:atelieoliveira/src/data/repository/repository.dart';
import 'package:atelieoliveira/src/feature/articles/article_webview.dart';
import 'package:flutter/material.dart';

class AboutView extends StatefulWidget {
  final Repository repository;

  const AboutView({
    required this.repository,
    super.key,
  });

  static const routeName = '/aboutViewState';

  @override
  State<StatefulWidget> createState() {
    return _AboutViewState();
  }
}

class _AboutViewState extends State<AboutView> {
  late Future<AboutModel> data;

  @override
  void initState() {
    data = widget.repository.fetchAbout();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        const AppBarView(image: "assets/images/banner_topo.jpg"),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: 1,
            (context, index) {
              return FutureBuilder(
                future: data,
                builder: (conxt, future) {
                  if (future.connectionState == ConnectionState.done) {
                    AboutModel? data = future.data;
                    if (data != null) {
                      return contentBody(data);
                    } else {
                      return const Text("Erro ao carregar suas revistas");
                    }
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget contentBody(AboutModel data) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          child: Flexible(
            child: Column(
              children: [
                Text(data.title),
                const Text("Contado:"),
                Text(data.address),
                Text(data.cep),
                Text(data.number),
                GestureDetector(
                  child: const Text("Termos de serviço"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ArticlesWebView(
                          url: data.termsUrl,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
