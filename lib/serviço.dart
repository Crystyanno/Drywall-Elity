import 'package:flutter/material.dart';

class ServicoWidget extends StatelessWidget {
  const ServicoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Nossos Serviços',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text('- Serviço 1'),
          Text('- Serviço 2'),
          Text('- Serviço 3'),
        ],
      ),
    );
  }
}
