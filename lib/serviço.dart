import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ServicoWidget extends StatefulWidget {
  const ServicoWidget({Key? key}) : super(key: key);

  @override
  State<ServicoWidget> createState() => _ServicoWidgetState();
}

class _ServicoWidgetState extends State<ServicoWidget> {
  final PageController _pageController = PageController(viewportFraction: 0.95);
  int _currentIndex = 0;

  final int _cardsPerPage = 3;

  final List<Map<String, String>> produtos = [
    {
      'nome': 'Forro com Cortineiro ',
      'img': 'assets/images/forro-com-cortineiro.jpeg',
    },
    {'nome': 'Forro de Gesso ', 'img': 'assets/forro-de-gesso.jpeg'},
    {'nome': 'Forro Tabicado', 'img': 'assets/forro-tabicado.jpeg'},
    {
      'nome': 'Forro com Sanca Invertida',
      'img': 'assets/forro-com-sanca-invertida.jpeg',
    },
    {
      'nome': 'Parede com Isolamento Acustico ',
      'img': 'assets/isolamento-acustico.jpeg',
    },
    {'nome': 'Paredes em Drywall', 'img': 'assets/paredes-em-drywall.jpeg'},
    {'nome': 'Scanca Aberta ', 'img': 'assets/sanca-aberta.jpeg'},
    {'nome': 'Sanca em Ilha', 'img': 'assets/sanca-em-ilha.jpeg'},
    {'nome': 'Sanca Fechada', 'img': 'assets/sanca-fechada.jpeg'},
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentIndex < _pageCount() - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  int _pageCount() {
    return (produtos.length / _cardsPerPage).ceil();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 24.0),
          child: Text(
            'Conheça nossos Serviços',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
          ),
        ),
        SizedBox(
          height: 280,
          child: Stack(
            alignment: Alignment.center,
            children: [
              PageView.builder(
                controller: _pageController,
                itemCount: _pageCount(),
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemBuilder: (context, pageIndex) {
                  final start = pageIndex * _cardsPerPage;
                  final end = (start + _cardsPerPage) > produtos.length
                      ? produtos.length
                      : (start + _cardsPerPage);
                  final pageProdutos = produtos.sublist(start, end);
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(_cardsPerPage, (i) {
                      if (i < pageProdutos.length) {
                        return Expanded(
                          child: _buildProductCard(pageProdutos[i], context),
                        );
                      } else {
                        // Espaço vazio para alinhar os cards
                        return const Expanded(child: SizedBox());
                      }
                    }),
                  );
                },
              ),
              // Botão voltar
              Positioned(
                left: 0,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios, size: 32),
                  color: _currentIndex > 0 ? Colors.blue : Colors.grey.shade300,
                  onPressed: _currentIndex > 0 ? _previousPage : null,
                ),
              ),
              // Botão avançar
              Positioned(
                right: 0,
                child: IconButton(
                  icon: const Icon(Icons.arrow_forward_ios, size: 32),
                  color: _currentIndex < _pageCount() - 1
                      ? Colors.blue
                      : Colors.grey.shade300,
                  onPressed: _currentIndex < _pageCount() - 1
                      ? _nextPage
                      : null,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SmoothPageIndicator(
          controller: _pageController,
          count: _pageCount(),
          effect: WormEffect(
            dotHeight: 12,
            dotWidth: 12,
            activeDotColor: Colors.blue.shade700,
            dotColor: Colors.grey.shade300,
          ),
        ),
        const SizedBox(height: 24),
        _buildBenefitsSection(),
      ],
    );
  }

  Widget _buildProductCard(Map<String, String> produto, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Card(
        elevation: 4,
        shadowColor: Colors.black.withOpacity(0.2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            // Adicione ação ao clicar no serviço
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.white, Colors.grey.shade50],
              ),
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Center(
                      child: Image.asset(
                        produto['img']!,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) => Icon(
                          Icons.image_outlined,
                          size: 48,
                          color: Colors.grey[400],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  produto['nome']!,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBenefitsSection() {
    return Container(
      width: double.infinity,
      color: Colors.blue.shade700,
      padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 16.0),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1400),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth > 800;
              return Wrap(
                alignment: WrapAlignment.center,
                spacing: 32.0,
                runSpacing: 32.0,
                children: [
                  _buildBenefitItem(
                        Icons.speed,
                        'Rapidez',
                        'Equipe treinada para realizar entregas rápidas.',
                        isWide,
                      )
                      .animate()
                      .fadeIn(duration: 600.ms, delay: 200.ms)
                      .slideX(begin: -0.2, duration: 600.ms),
                  _buildBenefitItem(
                        Icons.check_circle,
                        'Qualidade',
                        'Produtos selecionados para garantir\nexcelência em cada detalhe.',
                        isWide,
                      )
                      .animate()
                      .fadeIn(duration: 600.ms, delay: 400.ms)
                      .slideX(begin: -0.2, duration: 600.ms),
                  _buildBenefitItem(
                        Icons.attach_money,
                        'Custo-benefício',
                        'Menores preços do mercado com\ncondições de pagamento acessíveis.',
                        isWide,
                      )
                      .animate()
                      .fadeIn(duration: 600.ms, delay: 600.ms)
                      .slideX(begin: -0.2, duration: 600.ms),
                  _buildBenefitItem(
                        Icons.favorite,
                        'Relacionamento',
                        'Atendimento próximo e excepcional\npara uma experiência completa.',
                        isWide,
                      )
                      .animate()
                      .fadeIn(duration: 600.ms, delay: 800.ms)
                      .slideX(begin: -0.2, duration: 600.ms),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildBenefitItem(
    IconData icon,
    String title,
    String description,
    bool isWide,
  ) {
    return Container(
      width: isWide ? 280 : double.infinity,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: (0.08 * 255).round().toDouble(),
            ),
            blurRadius: 8,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 48, color: Colors.blue.shade700)
              .animate(onPlay: (controller) => controller.repeat())
              .shimmer(delay: 2000.ms, duration: 1800.ms)
              .shake(hz: 2, curve: Curves.easeInOut),
          const SizedBox(height: 16),
          Text(
            title.toUpperCase(),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(duration: 400.ms).scale(delay: 200.ms),
          const SizedBox(height: 12),
          Text(
                description,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              )
              .animate()
              .fadeIn(duration: 400.ms)
              .slideY(begin: 0.2, delay: 200.ms),
        ],
      ),
    ).animate().scale(
      begin: const Offset(1, 1),
      end: const Offset(1.05, 1.05),
      duration: 200.ms,
      curve: Curves.easeInOut,
    );
  }

  int _calculateCrossAxisCount(double width) {
    if (width > 1200) return 4;
    if (width > 900) return 3;
    if (width > 600) return 2;
    return 1;
  }

  double _calculateChildAspectRatio(double width) {
    if (width > 1200) return 1.1;
    if (width > 900) return 1.0;
    if (width > 600) return 1.2;
    return 0.9;
  }

  double _calculateHorizontalPadding(double width) {
    if (width > 1200) return 64.0;
    if (width > 900) return 48.0;
    if (width > 600) return 32.0;
    return 16.0;
  }

  Future<bool> _checkImageExists(String imagePath) async {
    try {
      await DefaultAssetBundle.of(
        GlobalContext.currentContext!,
      ).load(imagePath);
      return true;
    } catch (_) {
      return false;
    }
  }
}

// Add this to have access to BuildContext globally
class GlobalContext {
  static BuildContext? currentContext;
}
