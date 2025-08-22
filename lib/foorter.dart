import 'package:flutter/material.dart';

class CustomFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Coluna Esquerda
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 16,
                          color: Colors.grey[700],
                        ),
                        SizedBox(width: 6),
                        Flexible(
                          child: Text(
                            'Rua Exemplo, 123 - Centro, Cidade/UF',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[800],
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.phone, size: 16, color: Colors.grey[700]),
                        SizedBox(width: 6),
                        Text(
                          '(11) 99999-9999',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[800],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.email, size: 16, color: Colors.grey[700]),
                        SizedBox(width: 6),
                        Flexible(
                          child: Text(
                            'contato@minhaempresa.com',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[800],
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Coluna Direita
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.facebook, size: 18, color: Colors.blue[800]),
                        SizedBox(width: 8),
                        Icon(
                          Icons.meeting_room_sharp,
                          size: 18,
                          color: Colors.pink[400],
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.message, size: 18, color: Colors.green[600]),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 6),
          Divider(),
          SizedBox(height: 2),
          Text(
            '© 2025 Minha Empresa. Todos os direitos reservados.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}
