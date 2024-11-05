import 'package:emirhanarslantascom/core/base/state/base_state.dart';
import 'package:emirhanarslantascom/view/home/viewmodel/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/base/view/base_view.dart';
import '../../../core/components/home/header_button.dart';
import '../../../core/components/home/social_button.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends BaseState<HomeView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
      viewModel: HomeViewModel(),
      onModelReady: (HomeViewModel model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder: (BuildContext context, HomeViewModel viewModel) =>
          buildPage(context, viewModel),
    );
  }

  Widget buildPage(BuildContext context, HomeViewModel viewModel) {
    if (viewModel.allContents == null) {
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
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.white,
        shape:
            const Border(bottom: BorderSide(color: Colors.black, width: .15)),
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: dynamicWidth(.18)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
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
              ),
              buildHeaderButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Column buildHeaderButtons() {
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
