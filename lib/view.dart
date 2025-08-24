import 'package:flutter/material.dart';
import 'package:meu_app/comentarios.dart';
import 'package:meu_app/produtos.dart';
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
        child: CustomAppBar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            ConteudoWidget(),
            ServicoWidget(),
            ProdutosWidget(),
            ComentariosWidget(),
            CustomFooter(), // Agora o footer só aparece no final
          ],
        ),
      ),
    );
  }
}
