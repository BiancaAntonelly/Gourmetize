import 'package:flutter/material.dart'; 

class StyledText extends StatelessWidget {

  final String _title;

  const StyledText({
    super.key, 
    required String title,
  }) : _title = title;  

  @override
  Widget build(BuildContext context) {

    return Row(
      children: <Widget>[
         Container(
          width: 5,
          height: 25,
          margin: const EdgeInsets.only(right: 5),
          foregroundDecoration: const BoxDecoration(
            color: Colors.red,
          ),
        ),
         Text(
          _title,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
