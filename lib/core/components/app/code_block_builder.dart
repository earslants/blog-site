import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_highlight/themes/atom-one-light.dart';

class CodeBlockBuilder extends MarkdownElementBuilder {
  @override
  Widget visitElementAfter(element, TextStyle? preferredStyle) {
    return CodeBlockWidget(code: element.textContent);
  }
}

class CodeBlockWidget extends StatefulWidget {
  final String code;

  const CodeBlockWidget({super.key, required this.code});

  @override
  _CodeBlockWidgetState createState() => _CodeBlockWidgetState();
}

class _CodeBlockWidgetState extends State<CodeBlockWidget> {
  bool _isCopied = false;

  void _copyToClipboard() {
    Clipboard.setData(ClipboardData(text: widget.code));
    setState(() {
      _isCopied = true;
    });
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isCopied = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: HighlightView(
            widget.code,
            language: 'dart',
            theme: atomOneLightTheme,
            textStyle: const TextStyle(fontFamily: 'monospace', fontSize: 16),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_isCopied)
              const Padding(
                padding: EdgeInsets.only(right: 4.0),
                child: Text(
                  'Panoya Kopyalandı',
                  style: TextStyle(fontSize: 12, color: Colors.green),
                ),
              ),
            IconButton(
              icon: Icon(
                _isCopied ? Icons.check : Icons.copy,
                size: 16,
                color: _isCopied ? Colors.green : null,
              ),
              onPressed: _copyToClipboard,
            ),
          ],
        ),
      ],
    );
  }
}
