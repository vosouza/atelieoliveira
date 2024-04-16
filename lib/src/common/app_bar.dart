import 'package:flutter/material.dart';

class AppBarView extends StatelessWidget {
  final String image;

  const AppBarView({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 90,
      flexibleSpace: FlexibleSpaceBar(
        background: Image(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
