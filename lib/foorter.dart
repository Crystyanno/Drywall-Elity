import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CustomFooter extends StatelessWidget {
  const CustomFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF2C3E50),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildGradientDivider()
              .animate()
              .fadeIn(duration: 600.ms)
              .slideX(begin: -0.2, end: 0),
          const SizedBox(height: 16),
          _buildMainContent(),
          const SizedBox(height: 16),
          _buildGradientDivider()
              .animate()
              .fadeIn(duration: 600.ms)
              .slideX(begin: 0.2, end: 0),
          const SizedBox(height: 8),
          _buildCopyright(),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [_buildContactSection(), _buildSocialButtons()],
    );
  }

  Widget _buildContactSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildContactRow(
          Icons.location_on_outlined,
          'Rua Exemplo, 123',
          Colors.orangeAccent,
          200,
        ),
        const SizedBox(height: 8),
        _buildContactRow(
          Icons.phone_outlined,
          '(11) 99999-9999',
          Colors.greenAccent,
          400,
        ),
        const SizedBox(height: 8),
        _buildContactRow(
          Icons.email_outlined,
          'contato@empresa.com',
          Colors.blueAccent,
          600,
        ),
      ],
    );
  }

  Widget _buildContactRow(
    IconData icon,
    String text,
    Color color,
    int delayMs,
  ) {
    return Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white24, width: 1),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 16, color: color)
                  .animate(onPlay: (controller) => controller.repeat())
                  .shimmer(delay: 2000.ms, duration: 1800.ms)
                  .shake(hz: 2, curve: Curves.easeInOut),
              const SizedBox(width: 8),
              Text(
                text,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 13,
                ),
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(delay: delayMs.ms, duration: 500.ms)
        .slideX(begin: -0.2, end: 0, delay: delayMs.ms, duration: 500.ms)
        .animate(onPlay: (controller) => controller.repeat())
        .scaleXY(
          begin: 1,
          end: 1.02,
          duration: 2000.ms,
          curve: Curves.easeInOut,
        )
        .then()
        .scaleXY(
          begin: 1.02,
          end: 1,
          duration: 2000.ms,
          curve: Curves.easeInOut,
        );
  }

  Widget _buildSocialButtons() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildSocialButton(
          Icons.facebook,
          'Facebook',
          const Color(0xFF1877F2),
          0,
        ),
        const SizedBox(width: 12),
        _buildSocialButton(
          Icons.photo_camera,
          'Instagram',
          const Color(0xFFE4405F),
          200,
        ),
        const SizedBox(width: 12),
        _buildSocialButton(
          Icons.message,
          'WhatsApp',
          const Color(0xFF25D366),
          400,
        ),
      ],
    );
  }

  Widget _buildSocialButton(
    IconData icon,
    String tooltip,
    Color color,
    int delayMs,
  ) {
    return Tooltip(
          message: tooltip,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: color.withOpacity(0.5), width: 1),
            ),
            child: IconButton(
              icon: Icon(icon, size: 18),
              color: color,
              onPressed: () {},
              constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
            ),
          ),
        )
        .animate()
        .fadeIn(delay: delayMs.ms, duration: 600.ms)
        .scale(delay: delayMs.ms, duration: 600.ms)
        .animate(onPlay: (controller) => controller.repeat())
        .shimmer(delay: 2000.ms, duration: 1800.ms);
  }

  Widget _buildGradientDivider() {
    return Container(
      height: 1,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.transparent,
            Colors.white.withOpacity(0.3),
            Colors.transparent,
          ],
        ),
      ),
    );
  }

  Widget _buildCopyright() {
    return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.copyright_outlined,
              size: 12,
              color: Colors.white.withOpacity(0.6),
            ),
            const SizedBox(width: 4),
            Text(
              '2025 Minha Empresa',
              style: TextStyle(
                color: Colors.white.withOpacity(0.6),
                fontSize: 12,
              ),
            ),
          ],
        )
        .animate()
        .fadeIn(duration: 800.ms)
        .slideY(begin: 0.2, end: 0, duration: 800.ms);
  }
}
