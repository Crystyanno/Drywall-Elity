import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ServicoWidget extends StatefulWidget {
  const ServicoWidget({Key? key}) : super(key: key);

  @override
  State<ServicoWidget> createState() => _ServicoWidgetState();
}

class _ServicoWidgetState extends State<ServicoWidget> {
  late PageController _pageController;
  int _currentIndex = 0;

  final List<Map<String, String>> produtos = [
    {
      'nome': 'Forro com Cortineiro',
      'img': 'lib/assets/images/forro-com-cortineiro.jpeg',
    },
    {'nome': 'Forro de Gesso', 'img': 'assets/forro-de-gesso.jpeg'},
    {'nome': 'Forro Tabicado', 'img': 'lib/assets/images/forro-tabicado.jpeg'},
    {
      'nome': 'Forro com Sanca Invertida',
      'img': 'lib/assets/images/forro-com-sanca-invertida.jpeg',
    },
    {
      'nome': 'Parede com Isolamento Acustico',
      'img': 'lib/assets/images/isolamento-acustico.jpeg',
    },
    {'nome': 'Paredes em Drywall', 'img': 'assets/paredes-em-drywall.jpeg'},
    {'nome': 'Scanca Aberta', 'img': 'lib/assets/images/sanca-aberta.jpeg'},
    {'nome': 'Sanca em Ilha', 'img': 'lib/assets/images/sanca-em-ilha.jpeg'},
    {'nome': 'Sanca Fechada', 'img': 'lib/assets/images/sanca-fechada.jpeg'},
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.95);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentIndex < _pageCount(context) - 1) {
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

  // Retorna o número de cartões por página com base na largura da tela
  int _cardsPerPage(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 800) {
      return 3; // Desktop/tablet: 3 cards
    } else {
      return 1; // Mobile: 1 card
    }
  }

  // Calcula o número total de páginas
  int _pageCount(BuildContext context) {
    return (produtos.length / _cardsPerPage(context)).ceil();
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 800;

    // Altura aumentada para modo mobile para mostrar imagens maiores
    final cardHeight = isMobile ? 400.0 : 280.0;

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
          height: cardHeight,
          child: Stack(
            alignment: Alignment.center,
            children: [
              PageView.builder(
                controller: _pageController,
                itemCount: _pageCount(context),
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemBuilder: (context, pageIndex) {
                  return _buildPageContent(context, pageIndex);
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
                  color: _currentIndex < _pageCount(context) - 1
                      ? Colors.blue
                      : Colors.grey.shade300,
                  onPressed: _currentIndex < _pageCount(context) - 1
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
          count: _pageCount(context),
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

  Widget _buildPageContent(BuildContext context, int pageIndex) {
    final cardsPerPage = _cardsPerPage(context);
    final start = pageIndex * cardsPerPage;
    final end = (start + cardsPerPage) > produtos.length
        ? produtos.length
        : (start + cardsPerPage);
    final pageProdutos = produtos.sublist(start, end);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(cardsPerPage, (i) {
        if (i < pageProdutos.length) {
          return Expanded(child: _buildProductCard(pageProdutos[i], context));
        } else {
          // Espaço vazio para alinhar os cards
          return const Expanded(child: SizedBox());
        }
      }),
    );
  }

  Widget _buildProductCard(Map<String, String> produto, BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 800;
    final horizontalPadding = isMobile ? 16.0 : 8.0;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 4),
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
            padding: EdgeInsets.all(isMobile ? 16.0 : 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Container para a imagem - modificado para usar mais espaço vertical no mobile
                Expanded(
                  flex: isMobile
                      ? 7
                      : 5, // Aumenta a proporção da imagem no mobile
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 2,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        produto['img']!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: Colors.grey[100],
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.image_not_supported_outlined,
                            size: 36,
                            color: Colors.grey[400],
                          ),
                        ),
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                  ),
                ),

                // Espaço entre imagem e texto
                SizedBox(height: isMobile ? 16 : 12),

                // Título do produto
                Expanded(
                  flex: isMobile ? 1 : 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        produto['nome']!,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: isMobile ? 18 : 16,
                          fontWeight: FontWeight.w600,
                          height: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),

                // Botão apenas para mobile
                if (isMobile)
                  Padding(
                    padding: const EdgeInsets.only(top: 12, bottom: 8),
                    child: ElevatedButton(
                      onPressed: () {
                        // Ação do botão
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade600,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Ver detalhes',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
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
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 800;

        return Container(
          width: double.infinity,
          color: Colors.blue.shade700,
          padding: EdgeInsets.symmetric(
            vertical: isWide ? 40.0 : 32.0,
            horizontal: isWide ? 16.0 : 20.0,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1400),
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: isWide ? 32.0 : 20.0,
                runSpacing: isWide ? 32.0 : 24.0,
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
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBenefitItem(
    IconData icon,
    String title,
    String description,
    bool isWide,
  ) {
    // Ajustes para mobile
    final double cardPadding = isWide ? 20.0 : 12.0;
    final double iconSize = isWide ? 48 : 32;
    final double titleFontSize = isWide ? 18 : 14;
    final double descFontSize = isWide ? 14 : 12;
    final double spacing1 = isWide ? 16 : 8;
    final double spacing2 = isWide ? 12 : 6;
    final double cardWidth = isWide ? 280 : double.infinity;

    return Container(
      width: cardWidth,
      padding: EdgeInsets.all(cardPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: iconSize, color: Colors.blue.shade700)
              .animate(onPlay: (controller) => controller.repeat())
              .shimmer(delay: 2000.ms, duration: 1800.ms)
              .shake(hz: 2, curve: Curves.easeInOut),
          SizedBox(height: spacing1),
          Text(
            title.toUpperCase(),
            style: TextStyle(
              fontSize: titleFontSize,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(duration: 400.ms).scale(delay: 200.ms),
          SizedBox(height: spacing2),
          Text(
                description,
                style: TextStyle(
                  fontSize: descFontSize,
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
}

// Add this to have access to BuildContext globally
class GlobalContext {
  static BuildContext? currentContext;
}
