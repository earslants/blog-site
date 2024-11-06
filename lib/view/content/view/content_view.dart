import 'package:carousel_slider/carousel_slider.dart';
import 'package:emirhanarslantascom/core/base/state/base_state.dart';
import 'package:emirhanarslantascom/core/components/app/app_logo.dart';
import 'package:emirhanarslantascom/core/components/app/header_buttons.dart';
import 'package:emirhanarslantascom/view/content/viewmodel/content_view_model.dart';
import 'package:emirhanarslantascom/view/home/viewmodel/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../core/base/view/base_view.dart';
import '../../../core/components/app/code_block_builder.dart';
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
                padding: MediaQuery.of(context).size.width < 800
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
              child: Padding(
                padding: MediaQuery.of(context).size.width < 720
                    ? EdgeInsets.symmetric(horizontal: dynamicWidth(.04))
                    : EdgeInsets.zero,
                child: Column(
                  children: [
                    SizedBox(
                      width: 700,
                      child: Column(
                        children: [
                          SizedBox(height: dynamicHeight(.06)),
                          buildTopInfo(viewModel),
                          SizedBox(height: dynamicHeight(.06)),
                          buildMarkdownBody(viewModel),
                        ],
                      ),
                    ),
                    // buildCarousel(viewModel),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column buildCarousel(ContentViewModel viewModel) {
    return Column(
      children: [
        SizedBox(height: dynamicHeight(.06)),
        const Text(
          "Diğer Yazılar",
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 22,
          ),
        ),
        SizedBox(height: dynamicHeight(.02)),
        SizedBox(
          width: 700,
          child: Divider(color: Colors.grey.shade300, thickness: .6),
        ),
        SizedBox(
          height: 400,
          width: 700,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Consumer<HomeViewModel>(builder: (context, model, child) {
                return CarouselSlider(
                  carouselController: viewModel.sliderController,
                  options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: true,
                    height: 200.0,
                    viewportFraction: 0.5,
                  ),
                  items: model.allContents?.map((i) {
                    return Container(
                      width: 350,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: const BoxDecoration(
                        color: Colors.amber,
                      ),
                      child: const Text(
                        'text',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    );
                  }).toList(),
                );
              }),
              Positioned(
                left: 0,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios,
                      color: Colors.white, size: 30),
                  onPressed: () => viewModel.sliderController.previousPage(),
                ),
              ),
              Positioned(
                right: 0,
                child: IconButton(
                  icon: const Icon(Icons.arrow_forward_ios,
                      color: Colors.white, size: 30),
                  onPressed: () => viewModel.sliderController.nextPage(),
                ),
              ),
            ],
          ),
        ),
      ],
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
        h1Padding: const EdgeInsets.only(bottom: 24),
        h2Padding: const EdgeInsets.symmetric(vertical: 12),
        p: const TextStyle(fontSize: 18),
        h1: GoogleFonts.rowdies(fontSize: 32, fontWeight: FontWeight.w900),
        h2: GoogleFonts.rowdies(fontSize: 20, fontWeight: FontWeight.w800),
        a: const TextStyle(
            fontSize: 18, color: Color.fromARGB(255, 20, 20, 20)),
        listBullet: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
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
