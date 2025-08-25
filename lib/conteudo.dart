import 'package:flutter/material.dart';

class ConteudoWidget extends StatelessWidget {
  const ConteudoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: DerretidoClipper(),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade900, Colors.blue.shade400],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Text(
              '✨ Soluções em Drywall ✨',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'Transformamos espaços com qualidade, agilidade e\n'
              'um acabamento impecável para residências e comércios.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.white.withOpacity(0.9),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// CustomClipper que cria efeito "derretido" na parte de baixo
class DerretidoClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 40);

    // curva 1
    path.quadraticBezierTo(
      size.width * 0.2,
      size.height,
      size.width * 0.4,
      size.height - 30,
    );

    // curva 2
    path.quadraticBezierTo(
      size.width * 0.6,
      size.height - 60,
      size.width * 0.8,
      size.height - 20,
    );

    // curva 3
    path.quadraticBezierTo(
      size.width * 0.9,
      size.height,
      size.width,
      size.height - 30,
    );

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
