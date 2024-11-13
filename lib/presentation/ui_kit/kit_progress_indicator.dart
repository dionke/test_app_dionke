import 'package:flutter/material.dart';

class KitProgressIndicator extends StatelessWidget {
  const KitProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        strokeWidth: 2,
      ),
    );
  }
}
