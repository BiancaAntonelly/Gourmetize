import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:gourmetize/widgets/app_button.dart';

class NovaAvaliacao extends StatefulWidget {
  const NovaAvaliacao({super.key});

  @override
  State<StatefulWidget> createState() => _NovaAvaliacaoState();
}

class _NovaAvaliacaoState extends State<NovaAvaliacao> {
  double _notaAvaliacao = 0;

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
        color: Theme.of(context).colorScheme.secondary,
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
            starColor: Theme.of(context).colorScheme.primary,
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
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                maxLines: 8,
                decoration: InputDecoration(
                  hintText: 'Digite sua avaliação',
                  hintStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
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
                  fillColor: Theme.of(context).colorScheme.secondary,
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
                    onPressed: () {},
                    variant: AppButtonVariant.primary,
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
