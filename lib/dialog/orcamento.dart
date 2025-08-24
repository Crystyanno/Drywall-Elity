import 'package:flutter/material.dart';

class OrcamentoDialog extends StatelessWidget {
  const OrcamentoDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Solicitar Orçamento'),
      content: const Text(
        'Formulário de solicitação de orçamento será exibido em breve!',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('OK'),
        ),
      ],
    );
  }
}
