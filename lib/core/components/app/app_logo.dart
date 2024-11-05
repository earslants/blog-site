import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 60,
          width: 60,
          child: SvgPicture.asset(
            "images/logo.svg",
            fit: BoxFit.contain,
          ),
        ),
        Text(
          "Arslantaş",
          style: GoogleFonts.robotoSlab(
            color: const Color(0xFF0F3877),
            fontSize: 30,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
