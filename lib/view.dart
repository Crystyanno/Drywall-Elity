import 'package:flutter/material.dart';
import 'appbar.dart';
import 'conteudo.dart';
import 'foorter.dart';
import 'serviço.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child:
            CustomAppBar(), // Supondo que você crie um CustomAppBar em appbar.dart
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            ConteudoWidget(), // Supondo que você crie um ConteudoWidget em conteudo.dart
            ServicoWidget(), // Supondo que você crie um ServicoWidget em serviço.dart
          ],
        ),
      ),
      bottomNavigationBar:
          CustomFooter(), // Supondo que você crie um CustomFooter em foorter.dart
    );
  }
}
