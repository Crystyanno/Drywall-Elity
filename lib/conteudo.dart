import 'package:flutter/material.dart';

class ConteudoWidget extends StatelessWidget {
  const ConteudoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: const [
          Text(
            'Bem-vindo à nossa landing page!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Text('Aqui você encontra informações sobre nossos serviços.'),
        ],
      ),
    );
  }
}
