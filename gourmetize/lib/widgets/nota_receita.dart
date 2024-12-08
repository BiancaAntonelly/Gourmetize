import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:gourmetize/model/receita.dart';

class NotaReceita extends StatelessWidget {
  final Receita receita;

  NotaReceita({super.key, required this.receita});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RatingStars(
          value: receita.mediaAvaliacao ?? 0,
          onValueChanged: null,
          starBuilder: (index, color) => Icon(
            Icons.star,
            color: color,
            size: 25,
            shadows: [
              Shadow(
                blurRadius: 6.0,
                color: Colors.white,
              ),
            ],
          ),
          starSize: 25,
          starCount: 5,
          maxValue: 5,
          starSpacing: 0,
          valueLabelVisibility: false,
          starColor: Theme.of(context).colorScheme.secondary,
          starOffColor: Theme.of(context).colorScheme.primary,
        ),
        SizedBox(
          width: 8,
        ),
        Text(
          receita.mediaAvaliacao?.toStringAsFixed(1) ?? '-',
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
            shadows: [
              Shadow(
                blurRadius: 6.0,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
