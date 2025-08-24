import 'package:flutter/material.dart';
import 'package:meu_app/dialog/orcamento.dart';
import 'package:meu_app/dialog/servico.dart';

class ConteudoWidget extends StatelessWidget {
  const ConteudoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Text(
            'Soluções em Drywall',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Text(
            'Transformamos espaços com qualidade, agilidade e acabamento profissional. \n'
            'Especialistas em gesso acartonado para projetos residenciais e comerciais.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),

          // Botão Solicitar Orçamento (Principal)
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Ação para solicitar orçamento
                _verOrcamento(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Solicitar Orçamento',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Botão Nossos Serviços (Secundário)
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                // Ação para ver serviços
                _verNossosServicos(context);
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.blue,
                side: const BorderSide(color: Colors.blue),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Nossos Serviços',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Método para ação do botão Solicitar Orçamento
  // sua construção segue dentro de uma pasta dialog
  void _verOrcamento(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const OrcamentoDialog();
      },
    );
  }

  // Método para ação do botão Nossos Serviços
  // sua construção segue dentro de uma pasta dialog
  void _verNossosServicos(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const ServicoDialog();
      },
    );
  }
}
