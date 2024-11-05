import 'package:emirhanarslantascom/core/base/state/base_state.dart';
import 'package:emirhanarslantascom/core/components/app/app_logo.dart';
import 'package:emirhanarslantascom/core/components/app/header_buttons.dart';
import 'package:emirhanarslantascom/view/content/viewmodel/content_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../../../core/base/view/base_view.dart';
import '../../../core/constants/app/application_constants.dart';

class ContentView extends StatefulWidget {
  final String id;

  const ContentView({super.key, required this.id});

  @override
  State<ContentView> createState() => _ContentViewState();
}

class _ContentViewState extends BaseState<ContentView> {
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

  Widget buildPage(
      BuildContext context, ContentViewModel viewModel, String? id) {
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
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: false,
              floating: true,
              snap: true,
              surfaceTintColor: Colors.transparent,
              automaticallyImplyLeading: false,
              toolbarHeight: 100,
              backgroundColor: Colors.white,
              shape: const Border(
                  bottom: BorderSide(color: Colors.black, width: .15)),
              title: Padding(
                padding: MediaQuery.of(context).size.width < 850
                    ? EdgeInsets.symmetric(horizontal: dynamicWidth(.02))
                    : EdgeInsets.symmetric(horizontal: dynamicWidth(.18)),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppLogo(),
                    HeaderButtons(),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Center(
                child: MediaQuery.of(context).size.width < 800
                    ? buildContentSmallScreen(viewModel)
                    : buildContentNormalScreen(viewModel),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding buildContentSmallScreen(ContentViewModel viewModel) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: dynamicWidth(.04)),
      child: Column(
        children: [
          SizedBox(height: dynamicHeight(.06)),
          buildTopInfo(viewModel),
          SizedBox(height: dynamicHeight(.06)),
          buildMarkdownBody(viewModel),
        ],
      ),
    );
  }

  SizedBox buildContentNormalScreen(ContentViewModel viewModel) {
    return SizedBox(
      width: 750,
      child: Column(
        children: [
          SizedBox(height: dynamicHeight(.06)),
          buildTopInfo(viewModel),
          SizedBox(height: dynamicHeight(.06)),
          buildMarkdownBody(viewModel),
        ],
      ),
    );
  }

  MarkdownBody buildMarkdownBody(ContentViewModel viewModel) {
    return MarkdownBody(
      data: viewModel.content!.text!,
      selectable: false,
      builders: {
        'code': CodeBlockBuilder(),
      },
      styleSheet: MarkdownStyleSheet(
        blockSpacing: 24,
        p: const TextStyle(fontSize: 18),
        h1: const TextStyle(fontSize: 32, fontWeight: FontWeight.w900),
        h2: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        a: const TextStyle(fontSize: 18, color: Colors.blue),
        code: const TextStyle(fontSize: 16, fontFamily: 'monospace'),
      ),
    );
  }

  Row buildTopInfo(ContentViewModel viewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "${viewModel.content?.category}",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: Colors.grey.shade500,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          "${ApplicationConstants.MONTHS[viewModel.content!.time!.month - 1]} ${viewModel.content?.time?.day}, ${viewModel.content?.time?.year}",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: Colors.grey.shade400,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
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
