import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:gourmetize/config/app_config.dart';
import 'package:gourmetize/model/avaliacao.dart';
import 'package:gourmetize/model/receita.dart';
import 'package:gourmetize/provider/auth_provider.dart';
import 'package:gourmetize/provider/avaliacao_provider.dart';
import 'package:gourmetize/provider/receita_provider.dart';
import 'package:gourmetize/service/upload_service.dart';
import 'package:gourmetize/widgets/app_button.dart';
import 'package:gourmetize/widgets/image_input.dart';
import 'package:gourmetize/widgets/styled_text.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class NovaAvaliacao extends StatefulWidget {
  final Receita receita;
  final Avaliacao? avaliacao;

  const NovaAvaliacao({
    super.key,
    required this.receita,
    this.avaliacao,
  });

  @override
  State<StatefulWidget> createState() => _NovaAvaliacaoState();
}

class _NovaAvaliacaoState extends State<NovaAvaliacao> {
  File? _image;
  late double _notaAvaliacao;
  late final TextEditingController _descricaoController;

  @override
  void initState() {
    super.initState();

    _notaAvaliacao = widget.avaliacao?.nota.toDouble() ?? 0;
    _descricaoController =
        TextEditingController(text: widget.avaliacao?.comentario);
  }

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
      final usuarioLogado =
          Provider.of<AuthProvider>(context, listen: false).usuarioLogado!;
      String? imageUrl;

      if (_image != null) {
        final appDir = await syspaths.getApplicationDocumentsDirectory();
        String fileName = path.basename(_image!.path);

        final savedImage = await _image!.copy(
          '${appDir.path}/$fileName',
        );

        File imageFile = File(savedImage.path);
        final uploadService = UploadService();
        imageUrl = await uploadService.uploadImage(imageFile, usuarioLogado.id);
      }

      print(imageUrl);

      if (widget.avaliacao == null) {
        await Provider.of<AvaliacaoProvider>(context, listen: false)
            .createAvaliacao(
          Avaliacao(
            nota: _notaAvaliacao.toInt(),
            comentario: _descricaoController.text,
            usuario: usuarioLogado,
            receita: widget.receita,
            imageUrl: imageUrl,
          ),
        );
      } else {
        await Provider.of<AvaliacaoProvider>(context, listen: false)
            .updateAvaliacao(
          Avaliacao(
            id: widget.avaliacao!.id,
            nota: _notaAvaliacao.toInt(),
            comentario: _descricaoController.text,
            usuario: usuarioLogado,
            receita: widget.receita,
            imageUrl: imageUrl ?? widget.avaliacao?.imageUrl,
          ),
        );
      }

      final avaliacoes =
          Provider.of<AvaliacaoProvider>(context, listen: false).avaliacoes;
      final soma = avaliacoes.fold(0.0, (v, e) => v + e.nota);
      Provider.of<ReceitaProvider>(context, listen: false)
          .atualizarNota(widget.receita, soma / avaliacoes.length);

      // Mensagem de sucesso
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Avaliação enviada com sucesso!')),
      );

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
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 8,
            ),
            StyledText(title: 'Avaliação de Receita'),
            const SizedBox(
              height: 16,
            ),
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
              starOffColor: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(
              height: 16,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Avaliação:",
                  style: TextStyle(
                    fontSize: 14,
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
                      fontSize: 14,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  ),
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 32,
            ),
            ImageInput(
              value: _image,
              onChange: (value) {
                setState(() {
                  _image = value;
                });
              },
              initialUrl: widget.avaliacao?.imageUrl != null
                  ? AppConfig.minioUrl + widget.avaliacao!.imageUrl!
                  : null,
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
                      variant: AppButtonVariant.primary,
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
