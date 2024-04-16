import 'package:atelieoliveira/src/data/repository/repository.dart';
import 'package:atelieoliveira/src/feature/about/about_view.dart';
import 'package:atelieoliveira/src/feature/articles/articles_view.dart';
import 'package:atelieoliveira/src/feature/magazine_list/magazine_list_view.dart';
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
  List<String> backgroundList = [
    "assets/images/background.jpg",
    "assets/images/capa-002.jpg"
  ];

  late List<Widget> pages;
  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    pages = [
      ArticlesView(repository: widget.repository),
      MagazineListView(repository: widget.repository),
      AboutView(repository: widget.repository)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: NavigationBar(
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.article),
              label: 'Materias',
            ),
            NavigationDestination(
              icon: Icon(Icons.menu_book_outlined),
              label: 'Revistas',
            ),
            NavigationDestination(
              icon: Icon(Icons.settings),
              label: 'Sobre',
            ),
          ],
          onDestinationSelected: (index){
            setState(() {
              pageIndex = index;
            });
          },
        ),
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(backgroundList[0]), fit: BoxFit.cover),
              ),
            ),
            pages[pageIndex],
          ],
        ),
      ),
    );
  }  
}
