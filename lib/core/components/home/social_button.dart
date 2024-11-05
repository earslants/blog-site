import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialButton extends StatelessWidget {
  final String path;
  const SocialButton({
    super.key,
    required this.path,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      width: 30,
      child: SvgPicture.asset(
        path,
        fit: BoxFit.contain,
      ),
    );
  }
}
