import 'package:flutter/material.dart';

import '../home/header_button.dart';
import '../home/social_button.dart';

class HeaderButtons extends StatelessWidget {
  const HeaderButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            SocialButton(
              path: "images/github.svg",
            ),
            SizedBox(width: 18),
            SocialButton(
              path: "images/linkedin.svg",
            ),
            SizedBox(width: 18),
            SocialButton(
              path: "images/instagram.svg",
            ),
          ],
        ),
        Row(
          children: [
            HeaderButton(buttonText: 'Hakkımda'),
            HeaderButton(buttonText: 'İletişim'),
          ],
        ),
      ],
    );
  }
}
