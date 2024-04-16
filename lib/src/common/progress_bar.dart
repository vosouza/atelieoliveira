import 'package:flutter/material.dart';

class ModalRoundedProgressBar extends StatelessWidget {
  const ModalRoundedProgressBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
}
