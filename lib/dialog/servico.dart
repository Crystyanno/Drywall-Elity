import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ServicoDialog extends StatefulWidget {
  const ServicoDialog({super.key, required Map<String, String> produto});

  @override
  State<ServicoDialog> createState() => _ServicoDialogState();
}

class _ServicoDialogState extends State<ServicoDialog> {
  // Mapa com serviços e seus respectivos ícones
  final Map<String, IconData> servicosComIcones = {
    'Forro de Drywall': Icons.roofing,
    'Divisórias': Icons.padding_outlined,
    'Sancas': Icons.light,
    'Rebaixamento de teto': Icons.vertical_align_bottom,
    'Isolamento acústico': Icons.volume_off,
    'Paredes de gesso': Icons.dry,
  };

  final Set<String> selecionados = {};

  // Contador para os itens selecionados
  int get totalSelecionados => selecionados.length;

  void _enviarParaWhatsApp() async {
    if (selecionados.isEmpty) return;
    final numero =
        '5599999999999'; // Substitua pelo número desejado com DDI e DDD
    final mensagem = Uri.encodeComponent(
      'Olá! Gostaria de solicitar orçamento para os seguintes serviços:\n- ${selecionados.join('\n- ')}',
    );
    final url = 'https://wa.me/$numero?text=$mensagem';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 5,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      // Tornando o diálogo mais estreito
      insetPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 400,
        ), // Limita a largura máxima
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header com animação - mais compacto
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.home_repair_service_rounded,
                      color: Colors.blue.shade700,
                      size: 24,
                    ).animate().scale(
                      duration: 400.ms,
                      curve: Curves.elasticOut,
                    ),
                    const SizedBox(width: 8),
                    Text(
                          'Nossos Serviços',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade700,
                          ),
                        )
                        .animate()
                        .fadeIn(duration: 500.ms)
                        .slideX(begin: 0.2, end: 0),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Subtítulo com contador
              Text(
                'Selecione os serviços desejados ${totalSelecionados > 0 ? "($totalSelecionados)" : ""}',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                  fontWeight: totalSelecionados > 0
                      ? FontWeight.w500
                      : FontWeight.normal,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 12),

              // Lista de serviços como cards
              Flexible(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 220),
                  child: ListView(
                    shrinkWrap: true,
                    children: servicosComIcones.entries
                        .toList()
                        .asMap()
                        .entries
                        .map((entry) {
                          final index = entry.key;
                          final servico = entry.value.key;
                          final icone = entry.value.value;
                          final isSelected = selecionados.contains(servico);

                          return Card(
                                margin: const EdgeInsets.only(bottom: 6),
                                elevation: isSelected ? 2 : 0,
                                color: isSelected
                                    ? Colors.blue.shade50
                                    : Colors.grey.shade50,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(
                                    color: isSelected
                                        ? Colors.blue.shade300
                                        : Colors.grey.shade300,
                                    width: 1,
                                  ),
                                ),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(10),
                                  onTap: () {
                                    setState(() {
                                      if (isSelected) {
                                        selecionados.remove(servico);
                                      } else {
                                        selecionados.add(servico);
                                      }
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 6,
                                      horizontal: 10,
                                    ),
                                    child: Row(
                                      children: [
                                        // Ícone do serviço
                                        CircleAvatar(
                                          radius: 14,
                                          backgroundColor: isSelected
                                              ? Colors.blue.shade100
                                              : Colors.grey.shade200,
                                          child: Icon(
                                            icone,
                                            size: 14,
                                            color: isSelected
                                                ? Colors.blue.shade700
                                                : Colors.grey.shade700,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        // Nome do serviço
                                        Expanded(
                                          child: Text(
                                            servico,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: isSelected
                                                  ? FontWeight.w500
                                                  : FontWeight.normal,
                                              color: isSelected
                                                  ? Colors.blue.shade700
                                                  : Colors.black87,
                                            ),
                                          ),
                                        ),
                                        // Checkbox
                                        SizedBox(
                                          width: 28,
                                          height: 28,
                                          child: Checkbox(
                                            value: isSelected,
                                            activeColor: Colors.blue.shade600,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            onChanged: (value) {
                                              setState(() {
                                                if (value == true) {
                                                  selecionados.add(servico);
                                                } else {
                                                  selecionados.remove(servico);
                                                }
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                              .animate()
                              .fade(duration: 300.ms, delay: (index * 60).ms)
                              .slideY(
                                begin: 0.1,
                                end: 0,
                                duration: 300.ms,
                                delay: (index * 60).ms,
                              );
                        })
                        .toList(),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Botões - mais compactos
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.arrow_back, size: 14),
                      label: const Text(
                        'Voltar',
                        style: TextStyle(fontSize: 14),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.grey.shade700,
                        side: BorderSide(color: Colors.grey.shade300),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: selecionados.isEmpty
                          ? null
                          : _enviarParaWhatsApp,
                      icon: const Icon(Icons.message, size: 16),
                      label: const Text(
                        'WhatsApp',
                        style: TextStyle(fontSize: 14),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade600,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 2,
                        disabledBackgroundColor: Colors.green.shade200,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ).animate().scale(
      begin: const Offset(0.9, 0.9),
      end: const Offset(1.0, 1.0),
      duration: 300.ms,
      curve: Curves.easeOutQuad,
    );
  }
}
