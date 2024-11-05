import 'package:flutter/material.dart';

class HeaderButton extends StatelessWidget {
  final String buttonText;

  const HeaderButton({
    super.key,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: buttonText == 'İletişim'
          ? const EdgeInsets.only(top: 8, left: 12)
          : const EdgeInsets.only(top: 8),
      child: TextButton(
        onPressed: () {
          // Butonun işlevselliğini buraya ekleyebilirsiniz
        },
        style: ButtonStyle(
          padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          ),
          backgroundColor: WidgetStateProperty.all(Colors.white),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                color: Colors.grey.shade400,
                width: 1.5,
              ),
            ),
          ),
          overlayColor: WidgetStateProperty.all(Colors.grey.shade200),
        ),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade600,
          ),
        ),
      ),
    );
  }
}
