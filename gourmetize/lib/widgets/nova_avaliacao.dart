import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:gourmetize/model/avaliacao.dart';
import 'package:gourmetize/model/usuario.dart';
import 'package:gourmetize/provider/avaliacao_provider.dart';
import 'package:gourmetize/widgets/app_button.dart';
import 'package:provider/provider.dart';

class NovaAvaliacao extends StatefulWidget {
  final Usuario usuarioLogado;
  final void Function(Avaliacao avaliacao) onSubmit;

  const NovaAvaliacao({
    super.key,
    required this.onSubmit,
    required this.usuarioLogado,
  });

  @override
  State<StatefulWidget> createState() => _NovaAvaliacaoState();
}

class _NovaAvaliacaoState extends State<NovaAvaliacao> {
  double _notaAvaliacao = 0;
  final TextEditingController _descricaoController = TextEditingController();
  void _onSubmit() async {
    // Valida se a nota foi preenchida
    if (_notaAvaliacao == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Por favor, insira uma nota para a avaliação')),
      );
      return;
    }

    // Valida se a descrição foi preenchida (opcional)
    if (_descricaoController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, insira um comentário')),
      );
      return;
    }

    try {
      // Tenta criar a avaliação
      await Provider.of<AvaliacaoProvider>(context, listen: false)
          .createAvaliacaoParaReceita(
        Avaliacao(
          nota: _notaAvaliacao.toInt(),
          comentario: _descricaoController.text,
          usuario: widget
              .usuarioLogado, // Certifique-se de que `usuarioLogado` está disponível
        ),
      );

      // Mensagem de sucesso
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Avaliação enviada com sucesso!')),
      );

      print('ok');

      // Navega ou reseta a tela após o envio
      Navigator.pop(context);
    } catch (e) {
      // Mensagem de erro
      print(e);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao enviar a avaliação')),
      );
    }
  }

  void _onNotaChange(double nota) {
    setState(() {
      _notaAvaliacao = nota;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      child: Column(
        children: [
          RatingStars(
            value: _notaAvaliacao,
            onValueChanged: _onNotaChange,
            starBuilder: (index, color) => Icon(
              Icons.star,
              color: color,
              size: 50,
            ),
            starSize: 50,
            starCount: 5,
            maxValue: 5,
            starSpacing: 10,
            valueLabelVisibility: false,
            starColor: Theme.of(context).colorScheme.secondary,
            starOffColor: Colors.white,
          ),
          const SizedBox(
            height: 32,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Avaliação:",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                maxLines: 8,
                controller: _descricaoController,
                decoration: InputDecoration(
                  hintText: 'Digite sua avaliação',
                  hintStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  fillColor: Theme.of(context).colorScheme.primary,
                  filled: true,
                ),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AppButton(
                    label: 'Enviar',
                    onPressed: _onSubmit,
                    variant: AppButtonVariant.secondary,
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
