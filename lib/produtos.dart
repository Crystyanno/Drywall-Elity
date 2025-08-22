import 'package:flutter/material.dart';

class ProdutosWidget extends StatelessWidget {
  const ProdutosWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: _getHorizontalPadding(context),
        vertical: 24.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section title
          Center(
            child: Column(
              children: [
                Text(
                  'Nossos Produtos',
                  style: _getTitleStyle(context),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Soluções em drywall para todos os ambientes',
                  style: _getSubtitleStyle(context),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
          // Products grid
          LayoutBuilder(
            builder: (context, constraints) {
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: _getCrossAxisCount(constraints.maxWidth),
                  childAspectRatio: _getAspectRatio(constraints.maxWidth),
                  crossAxisSpacing: _getGridSpacing(context),
                  mainAxisSpacing: _getGridSpacing(context),
                ),
                itemCount: _produtos.length,
                itemBuilder: (context, index) {
                  return ProductCard(produto: _produtos[index]);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  // Responsive padding based on screen width
  double _getHorizontalPadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 600) return 16.0;
    if (width < 900) return 24.0;
    return 32.0;
  }

  // Responsive grid columns
  int _getCrossAxisCount(double width) {
    if (width < 600) return 1; // Mobile: 1 column
    if (width < 900) return 2; // Tablet: 2 columns
    return 3; // Desktop: 3 columns
  }

  // Responsive aspect ratio
  double _getAspectRatio(double width) {
    if (width < 600) return 1.2; // Mobile: taller cards
    if (width < 900) return 1.1; // Tablet: medium cards
    return 1.0; // Desktop: square-ish cards
  }

  // Responsive grid spacing
  double _getGridSpacing(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 600) return 12.0;
    if (width < 900) return 16.0;
    return 20.0;
  }

  // Responsive title style
  TextStyle _getTitleStyle(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return TextStyle(
      fontSize: width < 600 ? 24 : width < 900 ? 28 : 32,
      fontWeight: FontWeight.bold,
      color: Colors.grey[800],
    );
  }

  // Responsive subtitle style
  TextStyle _getSubtitleStyle(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return TextStyle(
      fontSize: width < 600 ? 14 : width < 900 ? 16 : 18,
      color: Colors.grey[600],
    );
  }

  // Sample product data
  static final List<Produto> _produtos = [
    Produto(
      nome: 'Parede Drywall Residencial',
      descricao: 'Divisórias internas para ambientes residenciais com excelente isolamento acústico.',
      preco: 'R\$ 45,00/m²',
      imagemUrl: 'https://via.placeholder.com/300x200?text=Parede+Residencial',
    ),
    Produto(
      nome: 'Forro Drywall Decorativo',
      descricao: 'Forros rebaixados com design moderno e acabamento perfeito.',
      preco: 'R\$ 35,00/m²',
      imagemUrl: 'https://via.placeholder.com/300x200?text=Forro+Decorativo',
    ),
    Produto(
      nome: 'Parede Drywall Comercial',
      descricao: 'Soluções corporativas com alta resistência e durabilidade.',
      preco: 'R\$ 55,00/m²',
      imagemUrl: 'https://via.placeholder.com/300x200?text=Parede+Comercial',
    ),
    Produto(
      nome: 'Nicho Drywall',
      descricao: 'Nichos personalizados para decoração e funcionalidade.',
      preco: 'R\$ 80,00/un',
      imagemUrl: 'https://via.placeholder.com/300x200?text=Nicho+Decorativo',
    ),
    Produto(
      nome: 'Estante Drywall',
      descricao: 'Estantes integradas com design sob medida.',
      preco: 'R\$ 120,00/m²',
      imagemUrl: 'https://via.placeholder.com/300x200?text=Estante+Integrada',
    ),
    Produto(
      nome: 'Painel TV Drywall',
      descricao: 'Painéis modernos para TVs com acabamento sofisticado.',
      preco: 'R\$ 200,00/un',
      imagemUrl: 'https://via.placeholder.com/300x200?text=Painel+TV',
    ),
  ];
}

class Produto {
  final String nome;
  final String descricao;
  final String preco;
  final String imagemUrl;

  Produto({
    required this.nome,
    required this.descricao,
    required this.preco,
    required this.imagemUrl,
  });
}

class ProductCard extends StatefulWidget {
  final Produto produto;

  const ProductCard({Key? key, required this.produto}) : super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.02,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(_isHovered ? 0.15 : 0.08),
                    blurRadius: _isHovered ? 16 : 8,
                    offset: Offset(0, _isHovered ? 8 : 4),
                  ),
                ],
              ),
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product image with loading state
                    Expanded(
                      flex: 3,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(12),
                        ),
                        child: ProductImage(
                          imageUrl: widget.produto.imagemUrl,
                        ),
                      ),
                    ),
                    // Product info
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.all(_getCardPadding(context)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.produto.nome,
                              style: _getProductTitleStyle(context),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Expanded(
                              child: Text(
                                widget.produto.descricao,
                                style: _getProductDescriptionStyle(context),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              widget.produto.preco,
                              style: _getProductPriceStyle(context),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _onHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });
    if (isHovered) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  // Responsive card padding
  double _getCardPadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 600) return 12.0;
    return 16.0;
  }

  // Responsive text styles
  TextStyle _getProductTitleStyle(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return TextStyle(
      fontSize: width < 600 ? 14 : 16,
      fontWeight: FontWeight.bold,
      color: Colors.grey[800],
    );
  }

  TextStyle _getProductDescriptionStyle(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return TextStyle(
      fontSize: width < 600 ? 12 : 14,
      color: Colors.grey[600],
    );
  }

  TextStyle _getProductPriceStyle(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return TextStyle(
      fontSize: width < 600 ? 14 : 16,
      fontWeight: FontWeight.bold,
      color: Colors.deepPurple,
    );
  }
}

class ProductImage extends StatefulWidget {
  final String imageUrl;

  const ProductImage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  State<ProductImage> createState() => _ProductImageState();
}

class _ProductImageState extends State<ProductImage> {
  bool _isLoading = true;
  bool _hasError = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.grey[100],
      child: _hasError
          ? _buildErrorWidget()
          : Stack(
              children: [
                Image.network(
                  widget.imageUrl,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      _isLoading = false;
                      return child;
                    }
                    return _buildLoadingWidget(loadingProgress);
                  },
                  errorBuilder: (context, error, stackTrace) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (mounted) {
                        setState(() {
                          _hasError = true;
                          _isLoading = false;
                        });
                      }
                    });
                    return _buildErrorWidget();
                  },
                ),
              ],
            ),
    );
  }

  Widget _buildLoadingWidget(ImageChunkEvent loadingProgress) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
            strokeWidth: 2,
            color: Colors.deepPurple,
          ),
          const SizedBox(height: 8),
          Text(
            'Carregando...',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.image_not_supported,
            size: 48,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 8),
          Text(
            'Imagem não disponível',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}