import 'package:flutter/material.dart';

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
        // Determine number of columns based on screen width
        int crossAxisCount = _calculateCrossAxisCount(constraints.maxWidth);

        return Padding(
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
