import 'package:atelieoliveira/src/common/app_bar.dart';
import 'package:atelieoliveira/src/data/model/magazine_model.dart';
import 'package:atelieoliveira/src/data/repository/repository.dart';
import 'package:flutter/material.dart';

class MagazineListView extends StatefulWidget {
  final Repository repository;
  const MagazineListView({
    required this.repository,
    super.key,
  });

  static const routeName = '/articles';

  @override
  State<StatefulWidget> createState() {
    return _ArticleViewState();
  }
}

class _ArticleViewState extends State<MagazineListView> {
  late PageController _pageController;
  late Future<MagazineModel> data;
  int activePage = 0;

   @override
  void initState() {
    super.initState();
    data = widget.repository.fetchData();
    _pageController = PageController(viewportFraction: 0.8, initialPage: 0);
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
                            MagazineModel? data = future.data;
                            if (data != null) {
                              return contentBody(data);
                            } else {
                              return const Text(
                                  "Erro ao carregar suas revistas");
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

  List<Widget> indicators(imagesLength, currentIndex) {
    return List<Widget>.generate(imagesLength, (index) {
      return Container(
        margin: const EdgeInsets.all(3),
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: currentIndex == index ? Colors.black : Colors.black26,
            shape: BoxShape.circle),
      );
    });
  }

  AnimatedContainer slider(image, active) {
    double margin = active ? 2 : 15;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOutCubic,
      margin: EdgeInsets.all(margin),
      decoration:
          BoxDecoration(image: DecorationImage(image: NetworkImage(image))),
    );
  }

  Widget contentBody(MagazineModel magazines) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: indicators(magazines.magazineList.length, activePage),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 400,
          child: PageView.builder(
            itemCount: magazines.magazineList.length,
            pageSnapping: true,
            controller: _pageController,
            onPageChanged: (page) {
              setState(() {
                activePage = page;
              });
            },
            itemBuilder: (context, index) {
              bool active = index == activePage;
              return GestureDetector(
                  child: slider(magazines.magazineList[index].image, active),
                  onTap: () {
                    Navigator.restorablePushNamed(context, "/details",
                        arguments: magazines.magazineList[index].toJson());
                  });
            },
          ),
        ),
      ],
    );
  }
}