import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({
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

  int activePage = 1;

  List<String> images = [
    'assets/images/capa-001.jpg',
    'assets/images/capa-002.jpg',
    'assets/images/capa-003.jpg',
    'assets/images/capa-004.jpg',
    'assets/images/capa-005.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.8, initialPage: 1);
    activePage = 1;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 150,
          flexibleSpace: const Image(
            image: AssetImage('assets/images/banner_topo.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        body: contentBody(),
      ),
    );
  }

  Widget contentBody() {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 400,
          child: PageView.builder(
            itemCount: images.length,
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
                child: slider(images[index], active),
                onTap: (){
                  Navigator.restorablePushNamed(context, "/details");
                }
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: indicators(images.length, activePage),
        )
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
          BoxDecoration(image: DecorationImage(image: AssetImage(image))),
      );
  }
}
