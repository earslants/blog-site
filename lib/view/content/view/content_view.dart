import 'package:emirhanarslantascom/view/content/viewmodel/content_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../../../core/base/view/base_view.dart';

class ContentView extends StatefulWidget {
  final String id;

  const ContentView({super.key, required this.id});

  @override
  State<ContentView> createState() => _ContentViewState();
}

class _ContentViewState extends State<ContentView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<ContentViewModel>(
      viewModel: ContentViewModel(),
      onModelReady: (ContentViewModel model) {
        model.setContext(context);
        model.init();
        model.fetchContent(widget.id);
      },
      onPageBuilder: (BuildContext context, ContentViewModel viewModel) =>
          buildPage(context, viewModel, widget.id),
    );
  }
}

Widget buildPage(BuildContext context, ContentViewModel viewModel, String? id) {
  if (viewModel.content == null) {
    return const Center(
      child: SizedBox(
        height: 50,
        width: 50,
        child: CircularProgressIndicator(),
      ),
    );
  }
  return Scaffold(
    backgroundColor: Colors.white,
    body: GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SafeArea(
        child: SingleChildScrollView(
          child: MarkdownBody(
            data: viewModel.content!.text!,
            selectable: true,
            builders: {
              'code': CodeBlockBuilder(),
            },
          ),
        ),
      ),
    ),
  );
}

class CodeBlockBuilder extends MarkdownElementBuilder {
  @override
  Widget visitElementAfter(element, TextStyle? preferredStyle) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
          height: 200,
          width: double.infinity,
          padding: const EdgeInsets.all(8.0),
          color: Colors.grey[200],
          child: Text(
            element.textContent,
            style: const TextStyle(fontFamily: 'monospace'),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.copy, size: 16),
          onPressed: () {
            Clipboard.setData(ClipboardData(text: element.textContent));
          },
        ),
      ],
    );
  }
}
