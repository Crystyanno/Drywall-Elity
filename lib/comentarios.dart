import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ComentariosWidget extends StatelessWidget {
  const ComentariosWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final comentarios = [
      Comentario(
        nome: "Rafael Silva",
        avaliacao: 5,
        data: "2 semanas atrás",
        comentario:
            "Trabalho impecável! Transformaram meu escritório com divisórias de drywall.",
        avatar: "RS",
      ),
      Comentario(
        nome: "Carla Mendes",
        avaliacao: 4,
        data: "1 mês atrás",
        comentario:
            "Ótimo serviço de instalação de forro. Equipe pontual e profissional!",
        avatar: "CM",
      ),
      Comentario(
        nome: "Pedro Almeida",
        avaliacao: 5,
        data: "3 meses atrás",
        comentario:
            "Rebaixamento do teto da sala ficou melhor do que eu esperava. Preço justo!",
        avatar: "PA",
      ),
    ];

    final mediaAvaliacoes =
        comentarios.map((c) => c.avaliacao).reduce((a, b) => a + b) /
        comentarios.length;
    // Container com rasgado no top com automotico
    return Center(
      child: ClipPath(
        clipper: RasgoClipper(),
        child: Container(
          padding: const EdgeInsets.only(
            top: 32,
            bottom: 24,
            left: 16,
            right: 16,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple.shade700, Colors.orange.shade600],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "VOZES DOS NOSSOS CLIENTES",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                "Depoimentos que Inspiram",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Container(
                    width: 280,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.95),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.orange.shade500,
                                Colors.red.shade500,
                              ],
                            ),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.orange.shade300.withOpacity(0.4),
                                blurRadius: 8,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            mediaAvaliacoes.toStringAsFixed(1),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Média de Avaliações",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: Colors.grey.shade900,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Row(
                              children: List.generate(5, (index) {
                                return Icon(
                                  index < mediaAvaliacoes.floor()
                                      ? Icons.star
                                      : (index < mediaAvaliacoes
                                            ? Icons.star_half
                                            : Icons.star_border),
                                  color: Colors.orange.shade500,
                                  size: 18,
                                );
                              }),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              "${comentarios.length} avaliações",
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                  .animate()
                  .fadeIn(duration: 600.ms)
                  .scale(
                    begin: const Offset(0.9, 0.9),
                    end: const Offset(1, 1),
                  ),
              const SizedBox(height: 20),
              Text(
                "Comentários em Destaque",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 220,
                child: _ComentariosCarousel(comentarios: comentarios),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// classe de cards com depoimentos
class _ComentariosCarousel extends StatefulWidget {
  final List<Comentario> comentarios;
  const _ComentariosCarousel({required this.comentarios});

  @override
  State<_ComentariosCarousel> createState() => _ComentariosCarouselState();
}

class _ComentariosCarouselState extends State<_ComentariosCarousel> {
  int _page = 0;
  late final PageController _controller;
  Timer? _timer;
  bool _isPaused = false;
  bool _autoScrollStarted = false;

  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: 1.0, initialPage: 0);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_autoScrollStarted) {
      _startAutoScroll();
      _autoScrollStarted = true;
    }
  }

  void _startAutoScroll() {
    final isWeb = MediaQuery.of(context).size.width > 600;
    if (isWeb) return; // Não iniciar auto scroll no web
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (!_isPaused && mounted) {
        if (_page < widget.comentarios.length - 1) {
          _page++;
        } else {
          _page = 0;
        }
        _controller.animateToPage(
          _page,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        setState(() {});
      }
    });
  }

  void _pauseAutoScroll() {
    setState(() => _isPaused = true);
  }

  void _resumeAutoScroll() {
    setState(() => _isPaused = false);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  // automatico
  @override
  Widget build(BuildContext context) {
    final isWeb = MediaQuery.of(context).size.width > 600;
    return GestureDetector(
      onPanDown: (_) => _pauseAutoScroll(),
      onPanEnd: (_) => _resumeAutoScroll(),
      child: PageView.builder(
        controller: _controller,
        itemCount: isWeb ? 1 : widget.comentarios.length,
        onPageChanged: (i) => setState(() => _page = i),
        itemBuilder: (context, i) {
          if (isWeb) {
            return Row(
              children: widget.comentarios
                  .map(
                    (c) => Expanded(
                      child: ComentarioItem(
                        comentario: c,
                        index: widget.comentarios.indexOf(c),
                      ),
                    ),
                  )
                  .toList(),
            );
          } else {
            return Opacity(
              opacity: i == _page ? 1.0 : 0.7,
              child: ComentarioItem(
                comentario: widget.comentarios[i],
                index: i,
              ),
            );
          }
        },
      ),
    );
  }
}

class ComentarioItem extends StatelessWidget {
  final Comentario comentario;
  final int index;

  const ComentarioItem({
    super.key,
    required this.comentario,
    required this.index,
  });
  /////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Container(
          margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.purple.shade300.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          Colors.purple.shade400,
                          Colors.orange.shade400,
                        ],
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.transparent,
                      child: Text(
                        comentario.avatar,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ).animate().scale(
                    delay: 200.ms,
                    duration: 500.ms,
                    curve: Curves.easeOutBack,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          comentario.nome,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                            color: Colors.grey.shade900,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.event,
                              size: 14,
                              color: Colors.grey.shade500,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              comentario.data,
                              style: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (index == 0)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.green.shade400,
                            Colors.green.shade600,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.check_circle,
                            size: 14,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "Verificados",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(5, (i) {
                    return Icon(
                      i < comentario.avaliacao ? Icons.star : Icons.star_border,
                      color: Colors.orange.shade600,
                      size: 18,
                    );
                  }),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                comentario.comentario,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.5,
                  color: Colors.grey.shade800,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.thumb_up, size: 14, color: Colors.white),
                    label: Text(
                      "Útil",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple.shade500,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0,
                    ),
                  ).animate().scale(delay: 300.ms, duration: 400.ms),
                  const SizedBox(width: 8),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.share, size: 14, color: Colors.white),
                    label: Text(
                      "Compartilhar",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange.shade500,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0,
                    ),
                  ).animate().scale(delay: 400.ms, duration: 400.ms),
                ],
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(delay: (index * 150).ms, duration: 500.ms)
        .slideX(
          begin: 0.1,
          end: 0,
          delay: (index * 150).ms,
          duration: 500.ms,
          curve: Curves.easeOutSine,
        );
  }
}

class Comentario {
  final String nome;
  final int avaliacao;
  final String data;
  final String comentario;
  final String avatar;

  Comentario({
    required this.nome,
    required this.avaliacao,
    required this.data,
    required this.comentario,
    required this.avatar,
  });
}

class RasgoClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    // Definir quantos "dentes" terá o rasgado
    const int waves = 15;
    const double amplitude = 12.0;

    // Iniciar no canto inferior esquerdo
    path.moveTo(0, amplitude);

    // Criar o efeito rasgado na parte superior
    for (int i = 0; i < waves; i++) {
      final waveWidth = size.width / waves;
      final x2 = (i + 0.5) * waveWidth;
      final x3 = (i + 1) * waveWidth;

      // Altura aleatória para cada ponto da onda para parecer rasgado
      final y1 = amplitude * (i.isEven ? 0.5 : 1.0);
      final y2 = amplitude * (i.isEven ? 1.0 : 0.3);

      // Desenhar segmentos da curva
      path.quadraticBezierTo(x2, y2, x3, y1);
    }

    // Completar o retângulo
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
