import 'package:flutter/material.dart';
import 'package:meu_app/dialog/servico.dart';

class ConteudoWidget extends StatelessWidget {
  const ConteudoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Fundo azul com curva
        Positioned.fill(
          child: Column(
            children: [
              // Parte azul (40% da altura)
              Expanded(flex: 4, child: Container(color: Colors.blue.shade600)),
              // Parte branca (60% da altura)
              Expanded(flex: 6, child: Container(color: Colors.white)),
            ],
          ),
        ),

        // Curva de transição entre azul e branco
        Positioned(
          top: MediaQuery.of(context).size.height * 0.2,
          left: 0,
          right: 0,
          child: SizedBox(
            height: 120,
            width: double.infinity,
            child: CustomPaint(painter: CurvePainter()),
          ),
        ),

        // Conteúdo principal
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 60),

            // Título no topo com fundo transparente e estrelas
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 0,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Soluções em Drywall',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.star, color: Colors.amber, size: 20),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // Card principal
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(
                        0.15,
                      ), // Aumentado a opacidade para uma sombra mais visível
                      blurRadius:
                          30, // Aumentado o blur para uma sombra mais suave
                      spreadRadius:
                          2, // Adicionado spread para expandir a sombra
                      offset: const Offset(
                        0,
                        6,
                      ), // Aumentado o offset para uma sombra mais elevada
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Ícone da casa
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.home_rounded,
                        size: 40,
                        color: Colors.blue.shade600,
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Texto principal
                    Text(
                      'Transformamos espaços com qualidade, agilidade e um acabamento impecável',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                        height: 1.3,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 16),

                    // Texto secundário
                    Text(
                      'Soluções personalizadas para residências e comércios',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey.shade600,
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 30),

                    // Botão
                    Center(
                      child: SizedBox(
                        width: 220,
                        child: ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => ServicoDialog(produto: {}),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade600,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Solicitar Orçamento',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// Painter para criar a curva suave entre o azul e o branco
class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(0, size.height);
    path.lineTo(0, size.height * 0.5);
    path.quadraticBezierTo(size.width * 0.5, 0, size.width, size.height * 0.5);
    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
