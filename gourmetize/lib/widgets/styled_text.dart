import 'package:flutter/material.dart'; 

class StyledText extends StatelessWidget {

  final String _title;

  const StyledText({
    super.key, 
    required String title,
  }) : _title = title;  

  @override
  Widget build(BuildContext context) {

    return Text(
      _title
    );
  }
}
