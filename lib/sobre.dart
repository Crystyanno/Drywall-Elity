import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';

class SobreWidget extends StatelessWidget {
  const SobreWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: Column(
        children: [
          const Text(
            'Sobre',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 40),

          // Card principal
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade50, Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 15,
                  spreadRadius: 5,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                // Parte superior com imagem
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                  child: Container(
                    height: 180,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blue.shade700, Colors.blue.shade500],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Padrão decorativo
                        Positioned.fill(
                          child: CustomPaint(painter: PatternPainter()),
                        ),

                        // Avatar
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 4),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 15,
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.grey.shade200,
                            backgroundImage: const AssetImage(
                              'assets/sua_foto.jpg',
                            ),
                            onBackgroundImageError: (_, __) {},
                            child: Icon(
                              Icons.person,
                              size: 60,
                              color: Colors.blue.shade300,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Conteúdo
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      // Nome e função
                      const Text(
                        'Guilherme Oliveira',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.3),

                      const SizedBox(height: 4),
                      Text(
                            'Especialistas em Drywall',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade600,
                              fontStyle: FontStyle.italic,
                            ),
                          )
                          .animate()
                          .fadeIn(duration: 600.ms, delay: 200.ms)
                          .slideY(begin: 0.3),

                      const SizedBox(height: 20),

                      // Sobre
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: const Text(
                          'Com anos de experiência no mercado, oferecemos soluções completas em gesso acartonado com foco na qualidade, praticidade e satisfação do cliente.',
                          //Profissionais qualificados e experientes
                          //Materiais de primeira qualidade
                          //Projetos personalizados
                          //Prazos cumpridos rigorosamente
                          //Garantia em todos os serviços
                          style: TextStyle(
                            fontSize: 15,
                            height: 1.5,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ).animate().fadeIn(duration: 800.ms, delay: 400.ms),

                      const SizedBox(height: 24),

                      // Estatísticas
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildStatItem('+300', 'Projetos'),
                          _buildDivider(),
                          _buildStatItem('98%', 'Satisfação'),
                          _buildDivider(),
                          _buildStatItem('10+', 'Anos'),
                        ],
                      ).animate().fadeIn(duration: 800.ms, delay: 600.ms),

                      const SizedBox(height: 24),

                      // Botões de contato
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildContactButton(
                            Icons.phone,
                            Colors.green.shade600,
                            'Ligar',
                          ),
                          const SizedBox(width: 16),
                          _buildContactButton(
                            Icons.message,
                            Colors.blue.shade600,
                            'Mensagem',
                          ),
                          const SizedBox(width: 16),
                          _buildContactButton(
                            Icons.email,
                            Colors.red.shade600,
                            'Email',
                          ),
                        ],
                      ).animate().fadeIn(duration: 800.ms, delay: 800.ms),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade700,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(height: 30, width: 1, color: Colors.grey.shade300);
  }

  Widget _buildContactButton(IconData icon, Color color, String label) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          padding: const EdgeInsets.all(12),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
      ],
    );
  }
}

// Painter para criar um padrão decorativo no fundo
class PatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.05)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    // Cria um padrão de linhas diagonais
    for (int i = -20; i < size.width + size.height; i += 20) {
      canvas.drawLine(Offset(i.toDouble(), 0), Offset(0, i.toDouble()), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
