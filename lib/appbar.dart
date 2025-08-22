import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(26.0),
      child: Column(
        children: [
          const Text('Minha Landing Page', style: TextStyle(fontSize: 24)),
          const SizedBox(height: 8),
          const Text('Bem-vindo à nossa landing page!'),
        ],
      ),
    );
  }
}
