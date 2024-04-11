import 'dart:async';

import 'package:atelieoliveira/src/data/model/magazine_model.dart';
import 'package:atelieoliveira/src/data/repository/repository.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  final Repository repository;
  const HomeView({
    required this.repository,
    super.key,
  });

  static const routeName = '/';

  @override
  State<StatefulWidget> createState() {
    return _HomeViewState();
  }
}

class _HomeViewState extends State<HomeView> {
  late PageController _pageController;
  late Future<MagazineModel> data;
  int activePage = 1;

  @override
  void initState() {
    super.initState();
    data = widget.repository.fetchData();
    _pageController = PageController(viewportFraction: 0.8, initialPage: 1);
    activePage = 1;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/banner_topo.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            toolbarHeight: MediaQuery.of(context).size.height * 0.1,
          ),
          body: Stack(
            children: [
              const Image(
                image: AssetImage("assets/images/background.jpg"),
                fit: BoxFit.cover,
              ),
              FutureBuilder(
                  future: data,
                  builder: (context, future) {
                    if (future.connectionState == ConnectionState.done) {
                      var magazine = future.data;
                      if (magazine != null) {
                        return contentBody(magazine);
                      } else {
                        return const CircularProgressIndicator();
                      }
                    } else {
                      return const CircularProgressIndicator();
                    }
                  }),
            ],
          )),
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
                    Navigator.restorablePushNamed(context, "/details");
                  });
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
}
