import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:gourmetize/config/app_config.dart';
import 'package:gourmetize/model/avaliacao.dart';

class AvaliacaoCard extends StatelessWidget {
  final Avaliacao avaliacao;

  const AvaliacaoCard({super.key, required this.avaliacao});

  String _getImageUrl() {
    return AppConfig.minioUrl + avaliacao.imageUrl!;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.only(top: 8, left: 4, right: 4, bottom: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            RatingStars(
              value: avaliacao.nota.toDouble(),
              onValueChanged: null,
              starBuilder: (index, color) => Icon(
                Icons.star,
                color: color,
                size: 32,
              ),
              starSize: 32,
              starCount: 5,
              maxValue: 5,
              starSpacing: 0,
              valueLabelVisibility: false,
              starColor: Theme.of(context).colorScheme.secondary,
              starOffColor: Theme.of(context).colorScheme.primary,
            ),
            SizedBox(height: 8),
            if (avaliacao.imageUrl != null)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                child: SizedBox(
                  height: 172,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image(
                      image: NetworkImage(_getImageUrl()),
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                    ),
                  ),
                ),
              ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 4),
              child: Text(
                avaliacao.comentario,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '• ' + avaliacao.usuario.nome,
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
