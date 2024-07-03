import 'package:flutter/material.dart';

class CustomAppButton extends StatelessWidget {
  final Color color;
  final Color textColor;
  final String text;
  final VoidCallback buttonTapped;
  final double font_size;

  const CustomAppButton({
    Key? key,
    required this.color,
    required this.textColor,
    required this.text,
    required this.buttonTapped,
    required this.font_size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onTap: buttonTapped,
      child: LayoutBuilder(
        builder: (context, constraints) {

          return Container(
            margin: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  color: textColor,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
