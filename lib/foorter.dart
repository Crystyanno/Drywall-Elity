import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CustomFooter extends StatelessWidget {
  const CustomFooter({super.key});

  @override
  Widget build(BuildContext context) {
    // Determina se estamos em uma tela pequena (mobile)
    final bool isMobile = MediaQuery.of(context).size.width < 800;
    final bool isTablet =
        MediaQuery.of(context).size.width < 1100 &&
        MediaQuery.of(context).size.width >= 800;

    return Container(
      width: double.infinity,
      color: const Color(0xFF181C2E),
      padding: EdgeInsets.symmetric(
        vertical: 32,
        horizontal: isMobile ? 20 : 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          isMobile
              ? _buildMobileTopSection(context)
              : isTablet
              ? _buildTabletTopSection(context)
              : _buildDesktopTopSection(context),
          const SizedBox(height: 24),
          const Divider(color: Colors.white24, thickness: 1),
          const SizedBox(height: 12),
          _buildBottomSection(isMobile),
        ],
      ),
    );
  }

  // Desktop layout - 4 columns in a row
  Widget _buildDesktopTopSection(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _buildLogoAndAbout()),
        Expanded(child: _buildLinks()),
        Expanded(child: _buildContact()),
        Expanded(child: _buildNewsletter(context)),
      ],
    );
  }

  // Tablet layout - 2x2 grid
  Widget _buildTabletTopSection(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildLogoAndAbout()),
            Expanded(child: _buildLinks()),
          ],
        ),
        const SizedBox(height: 32),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildContact()),
            Expanded(child: _buildNewsletter(context)),
          ],
        ),
      ],
    );
  }

  // Mobile layout - stacked columns
  Widget _buildMobileTopSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLogoAndAbout(),
        const SizedBox(height: 32),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildLinks()),
            Expanded(child: _buildContact()),
          ],
        ),
        const SizedBox(height: 32),
        _buildNewsletter(context),
      ],
    );
  }

  Widget _buildLogoAndAbout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(8),
              child: const Icon(Icons.home_work, color: Colors.white, size: 24),
            ),
            const SizedBox(width: 12),
            const Text(
              'Elity Drywall',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          'Especialistas em soluções de drywall, gesso e acabamentos para sua obra. Qualidade, agilidade e confiança!',
          style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.5),
        ),
      ],
    );
  }

  Widget _buildLinks() {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Links Rápidos',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 16),
          _footerLink('Início'),
          _footerLink('Produtos'),
          _footerLink('Serviços'),
          _footerLink('Contato'),
        ],
      ),
    );
  }

  Widget _footerLink(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child:
            GestureDetector(
                  onTap: () {},
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.arrow_right_rounded,
                        color: Colors.white38,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        text,
                        style: TextStyle(color: Colors.white70, fontSize: 13),
                      ),
                    ],
                  ),
                )
                .animate()
                .fadeIn(duration: 300.ms)
                .moveX(begin: -8, end: 0, curve: Curves.easeOutQuad),
      ),
    );
  }

  Widget _buildContact() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Contato',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 16),
        _contactRow(
          Icons.location_on,
          'Rua SM 26, Residencial São Marcos - GO',
        ),
        _contactRow(Icons.phone, '(62) 98566*7058'),
        _contactRow(Icons.email, 'contato@elitydrywall.com.br'),
        const SizedBox(height: 16),
        Row(
          children: [
            _socialIcon(Icons.facebook, const Color(0xFF1877F2)),
            const SizedBox(width: 12),
            _socialIcon(Icons.photo_camera, const Color(0xFFE4405F)),
            const SizedBox(width: 12),
            _socialIcon(Icons.message, const Color(0xFF25D366)),
          ],
        ),
      ],
    );
  }

  Widget _contactRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.white54, size: 16),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              text,
              style: const TextStyle(color: Colors.white70, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  Widget _socialIcon(IconData icon, Color color) {
    return Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withOpacity(0.15),
            border: Border.all(color: color.withOpacity(0.3), width: 1),
          ),
          child: IconButton(
            icon: Icon(icon, size: 16),
            color: color,
            onPressed: () {},
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
            padding: EdgeInsets.zero,
            iconSize: 16,
            splashRadius: 20,
          ),
        )
        .animate()
        .scale(duration: 300.ms, curve: Curves.easeOut)
        .then(delay: 100.ms)
        .shimmer(duration: 1200.ms);
  }

  Widget _buildNewsletter(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 800;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Receba novidades',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Cadastre seu e-mail para promoções e novidades:',
          style: TextStyle(color: Colors.white70, fontSize: 13),
        ),
        const SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.white24),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Seu e-mail',
                      border: InputBorder.none,
                      isDense: true,
                      hintStyle: TextStyle(fontSize: 13, color: Colors.white54),
                    ),
                    style: TextStyle(fontSize: 13, color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              height: 40,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade600,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: isMobile ? 12 : 16),
                ),
                onPressed: () {},
                child: const Text(
                  'Enviar',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBottomSection(bool isMobile) {
    return isMobile
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.copyright_outlined,
                    size: 13,
                    color: Colors.white54,
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    '2025 Elity Drywall. Todos os direitos reservados.',
                    style: TextStyle(color: Colors.white54, fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                'Desenvolvido por Ruan Torres',
                style: TextStyle(color: Colors.white54, fontSize: 12),
              ),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.copyright_outlined,
                    size: 13,
                    color: Colors.white54,
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    '2025 Elity Drywall. Todos os direitos reservados.',
                    style: TextStyle(color: Colors.white54, fontSize: 12),
                  ),
                ],
              ),
              const Text(
                'Desenvolvido por Ruan Torres',
                style: TextStyle(color: Colors.white54, fontSize: 12),
              ),
            ],
          );
  }
}
