import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ServicoWidget extends StatelessWidget {
  const ServicoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final produtos = [
      {'nome': 'Placas de Gesso', 'img': 'assets/placa_gesso.png'},
      {'nome': 'Sacos de Gesso', 'img': 'assets/saco_gesso.png'},
      {'nome': 'Molduras', 'img': 'assets/moldura.png'},
      {'nome': 'Blocos de Gesso', 'img': 'assets/bloco_gesso.png'},
      {'nome': 'Gesso Cola', 'img': 'assets/gesso_cola.png'},
      {'nome': 'Ferragens para Drywall', 'img': 'assets/ferragem.png'},
      {'nome': 'Ferramentas', 'img': 'assets/ferramentas.png'},
      {'nome': 'Placas em 3D', 'img': 'assets/placa_3d.png'},
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = _calculateCrossAxisCount(constraints.maxWidth);

        return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: _calculateHorizontalPadding(constraints.maxWidth),
                vertical: 24.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Conheça nossos Serviços',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 24),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: _calculateChildAspectRatio(
                        constraints.maxWidth,
                      ),
                    ),
                    itemCount: produtos.length,
                    itemBuilder: (context, index) {
                      final produto = produtos[index];
                      return _buildProductCard(produto, context);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _buildBenefitsSection(),
          ],
        );
      },
    );
  }

  Widget _buildProductCard(Map<String, String> produto, BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          // Add onTap functionality here
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
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
                          size: 32,
                          color: Colors.grey[400],
                        );
                      },
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
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                ),
              ),
            ],
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
