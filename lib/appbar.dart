import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    // Determina se estamos em uma tela pequena (mobile)
    final bool isMobile = MediaQuery.of(context).size.width < 800;

    return Material(
      elevation: isMobile ? 2 : 4,
      shadowColor: Colors.black.withOpacity(0.1),
      color: Colors.white,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: isMobile ? 12 : 16,
          horizontal: isMobile ? 16 : 32,
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade100, width: 1),
          ),
        ),
        child: isMobile
            ? _buildMobileAppBar(context)
            : _buildDesktopAppBar(context),
      ),
    );
  }

  // AppBar para dispositivos móveis com layout mais moderno
  Widget _buildMobileAppBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Logo + Nome em uma disposição mais compacta
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade600, Colors.blue.shade700],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.shade200.withOpacity(0.3),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(8),
              child: const Icon(
                Icons.home_work_rounded,
                color: Colors.white,
                size: 22,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Elity Drywall',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),

        // Botões de acesso rápido + menu
        Row(
          children: [
            // Menu hamburger modernizado
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: _ModernMobileMenu(),
            ),
          ],
        ),
      ],
    );
  }

  // AppBar para desktop mantendo o design original
  Widget _buildDesktopAppBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Logo + Nome
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.construction,
                color: Colors.blue.shade700,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Elity Drywall',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
                letterSpacing: 1,
              ),
            ),
          ],
        ),

        // Navegação horizontal para web
        Row(
          children: [
            _NavButton('Início', onPressed: () {}),
            _NavButton('Sobre', onPressed: () {}),
            _NavButton('Serviços', onPressed: () {}),
            _NavButton('Produtos', onPressed: () {}),
            _NavButton('Depoimentos', onPressed: () {}),
            _NavButton('Contato', onPressed: () {}),
          ],
        ),
      ],
    );
  }
}

/// Botão de navegação moderno com animação underline
class _NavButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;

  const _NavButton(this.label, {required this.onPressed});

  @override
  State<_NavButton> createState() => _NavButtonState();
}

class _NavButtonState extends State<_NavButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              style: TextButton.styleFrom(
                minimumSize: Size.zero,
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                foregroundColor: _isHovered
                    ? Colors.blue.shade700
                    : Colors.blueGrey,
                textStyle: const TextStyle(fontSize: 15),
              ),
              onPressed: widget.onPressed,
              child: Text(widget.label),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              height: 2,
              width: _isHovered ? 24 : 0,
              margin: const EdgeInsets.only(top: 2),
              decoration: BoxDecoration(
                color: Colors.blue.shade700,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Menu hamburger modernizado para mobile
class _ModernMobileMenu extends StatefulWidget {
  @override
  State<_ModernMobileMenu> createState() => _ModernMobileMenuState();
}

class _ModernMobileMenuState extends State<_ModernMobileMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isMenuOpen = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleMenu() {
    setState(() {
      _isMenuOpen = !_isMenuOpen;
      if (_isMenuOpen) {
        _animationController.forward();
        _showMobileMenu();
      } else {
        _animationController.reverse();
      }
    });
  }

  void _showMobileMenu() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildMobileMenuContent(),
    ).then((_) {
      setState(() {
        _isMenuOpen = false;
        _animationController.reverse();
      });
    });
  }

  Widget _buildMobileMenuContent() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 15,
            spreadRadius: 0,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Indicador de arraste mais moderno
          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 8),
            child: Container(
              width: 40,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(20),
              ),
            ).animate().fadeIn(duration: 300.ms),
          ),

          // Cabeçalho do menu com logo
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue.shade600, Colors.blue.shade700],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: const Icon(
                    Icons.home_work_rounded,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Text(
                    'Elity Drywall',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close_rounded),
                  onPressed: () => Navigator.pop(context),
                  color: Colors.grey.shade600,
                ),
              ],
            ),
          ),

          const Divider(height: 1, thickness: 1),

          // Itens de menu com animações
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildAnimatedMenuItem('Início', Icons.home_rounded, 0),
                _buildAnimatedMenuItem('Sobre', Icons.info_rounded, 100),
                _buildAnimatedMenuItem(
                  'Serviços',
                  Icons.construction_rounded,
                  200,
                ),
                _buildAnimatedMenuItem('Produtos', Icons.category_rounded, 300),
                _buildAnimatedMenuItem('Depoimentos', Icons.chat_rounded, 400),
                _buildAnimatedMenuItem(
                  'Contato',
                  Icons.contact_mail_rounded,
                  500,
                ),
              ],
            ),
          ),

          // Botões de ação e contato
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // Botão principal
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade600,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 2,
                    ),
                    child: const Text(
                      'Solicitar Orçamento',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.2),

                // Informações de contato
                Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildContactIcon(Icons.message, Colors.green.shade600),
                      const SizedBox(width: 24),
                      _buildContactIcon(Icons.phone, Colors.blue.shade600),
                      const SizedBox(width: 24),
                      _buildContactIcon(
                        Icons.email_rounded,
                        Colors.orange.shade600,
                      ),
                      const SizedBox(width: 24),
                      _buildContactIcon(Icons.location_on, Colors.red.shade600),
                    ],
                  ),
                ).animate().fadeIn(delay: 800.ms),

                // Copyright
                Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: Text(
                    '© 2025 Elity Drywall',
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedMenuItem(String label, IconData icon, int delay) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        // Adicione aqui a navegação para a seção correspondente
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, size: 22, color: Colors.blue.shade600),
            ),
            const SizedBox(width: 20),
            Text(
              label,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: delay.ms).slideX(begin: -0.1, duration: 400.ms);
  }

  Widget _buildContactIcon(IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: 20, color: color),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.menu_rounded, size: 22),
      onPressed: _toggleMenu,
      padding: const EdgeInsets.all(8),
      constraints: const BoxConstraints(),
      splashRadius: 24,
    );
  }
}
