import 'package:flutter/material.dart';

class CustomFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.location_on, size: 18, color: Colors.grey[700]),
              SizedBox(width: 8),
              Text(
                'Rua Exemplo, 123 - Centro, Cidade/UF',
                style: TextStyle(fontSize: 14, color: Colors.grey[800]),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.phone, size: 18, color: Colors.grey[700]),
              SizedBox(width: 8),
              Text(
                '(11) 99999-9999',
                style: TextStyle(fontSize: 14, color: Colors.grey[800]),
              ),
              SizedBox(width: 16),
              Icon(Icons.email, size: 18, color: Colors.grey[700]),
              SizedBox(width: 8),
              Text(
                'contato@minhaempresa.com',
                style: TextStyle(fontSize: 14, color: Colors.grey[800]),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.facebook, size: 20, color: Colors.blue[800]),
              SizedBox(width: 8),
              Icon(Icons.meeting_room_sharp, size: 20, color: Colors.pink[400]),
              SizedBox(width: 8),
              Icon(Icons.message, size: 20, color: Colors.green[600]),
            ],
          ),
          SizedBox(height: 16),
          Divider(),
          SizedBox(height: 8),
          Text(
            '© 2025 Minha Empresa. Todos os direitos reservados.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}
