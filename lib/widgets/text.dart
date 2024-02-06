import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextSmall extends StatelessWidget {
  const TextSmall(
    this.text, {
    super.key,
    this.size = 16,
    this.color = Colors.black,
  });
  final double size;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: size,
        color: color
      ),
    );
  }
}

class TextMedium extends StatelessWidget {
  const TextMedium(
    this.text, {
    super.key,
    this.size = 18,
    this.color = Colors.black,
  });
  final double size;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(fontSize: size, fontWeight: FontWeight.w500, color: color),
    );
  }
}

class TextLarge extends StatelessWidget {
  const TextLarge(
    this.text, {
    super.key,
    this.size = 20,
    this.color = Colors.black,
  });
  final double size;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(fontSize: size, fontWeight: FontWeight.bold),
    );
  }
}
