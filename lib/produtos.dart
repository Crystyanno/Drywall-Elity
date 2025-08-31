import 'package:flutter/material.dart';
import 'package:meu_app/dialog/servico.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProdutosWidget extends StatefulWidget {
  const ProdutosWidget({Key? key}) : super(key: key);

  @override
  State<ProdutosWidget> createState() => _ProdutosWidgetState();
}

class _ProdutosWidgetState extends State<ProdutosWidget> {
  final PageController _pageController = PageController(viewportFraction: 0.85);
  int _currentIndex = 0;

  final List<Map<String, String>> produtos = [
    {'nome': 'Ferragens para Drywall', 'img': 'assets/ferragem.png'},
    {
      'nome': 'Chapa de Drywall Standard 1,8x1,2mx1,25cm Branca',
      'img': 'assets/Gypsun-branca.jpeg',
    },
    {
      'nome': 'Chapa de Drywall Resistente a Úmidade 1,8x1,2mx1,25cm Verde',
      'img': 'assets/Gypsun-verde.jpeg',
    },
    {
      'nome': 'Chapa de Drywall Resistente ao Fogo 1,80x1,20m Rosa ',
      'img': 'assets/Gypsun-repsa.jpeg',
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _previousPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: _getHorizontalPadding(constraints.maxWidth),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Conheça nossos produtos',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.5,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Deslize para ver mais produtos',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                height: 320,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: produtos.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return _buildProductCard(produtos[index], context);
                  },
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: _previousPage,
                    icon: const Icon(Icons.arrow_back_ios),
                    color: Colors.grey[700],
                  ),
                  const SizedBox(width: 16),
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: produtos.length,
                    effect: ExpandingDotsEffect(
                      activeDotColor: Colors.blue[700]!,
                      dotColor: Colors.grey[300]!,
                      dotHeight: 8,
                      dotWidth: 8,
                      spacing: 8,
                    ),
                  ),
                  const SizedBox(width: 16),
                  IconButton(
                    onPressed: _nextPage,
                    icon: const Icon(Icons.arrow_forward_ios),
                    color: Colors.grey[700],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProductCard(Map<String, String> produto, BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.white, Colors.grey.shade50],
            ),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              // Adicione a ação desejada aqui
            },
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.all(20),
                      child: Center(
                        child: FutureBuilder<bool>(
                          future: _checkImageExists(produto['img']!),
                          builder: (context, snapshot) {
                            if (snapshot.data == true) {
                              return Image.asset(
                                produto['img']!,
                                fit: BoxFit.contain,
                              );
                            }
                            return Icon(
                              Icons.image_outlined,
                              size: 48,
                              color: Colors.grey[400],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    produto['nome']!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => ServicoDialog(produto: produto),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[700],
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                    child: const Text('Saiba mais'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  double _getHorizontalPadding(double width) {
    if (width > 1200) return 64.0;
    if (width > 900) return 48.0;
    if (width > 600) return 32.0;
    return 24.0;
  }

  Future<bool> _checkImageExists(String imagePath) async {
    try {
      await DefaultAssetBundle.of(context).load(imagePath);
      return true;
    } catch (_) {
      return false;
    }
  }
}
