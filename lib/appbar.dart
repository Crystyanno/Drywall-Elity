import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 6,
      color: Colors.white,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 32),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade200, width: 1),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Logo + Nome
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.construction,
                    color: Colors.blue.shade700,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  'Drywall Solução',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,
                    letterSpacing: 1.1,
                  ),
                ),
              ],
            ),

            // Navegação
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
        ),
      ),
    );
  }
}

/// Botão de navegação moderno com animação underline
/// veras que animação é feita com AnimatedContainer ajudar quando passa o mouse em cima
/// trazendo um efeito de transição suave
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
        margin: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min, // 👈 evita overflow
          children: [
            TextButton(
              style: TextButton.styleFrom(
                minimumSize: Size.zero, // 👈 remove altura mínima padrão
                padding: EdgeInsets.zero, // 👈 tira padding extra
                foregroundColor: _isHovered
                    ? Colors.blue.shade700
                    : Colors.blueGrey,
                textStyle: const TextStyle(fontSize: 16),
              ),
              onPressed: widget.onPressed,
              child: Text(widget.label),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              height: 2,
              width: _isHovered ? 24 : 0,
              color: Colors.blue.shade700,
            ),
          ],
        ),
      ),
    );
  }
}
