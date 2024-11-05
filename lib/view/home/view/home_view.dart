import 'package:emirhanarslantascom/core/base/state/base_state.dart';
import 'package:emirhanarslantascom/core/constants/navigation/navigation_constants.dart';
import 'package:emirhanarslantascom/core/init/navigation/navigation_service.dart';
import 'package:emirhanarslantascom/view/home/viewmodel/home_view_model.dart';
import 'package:flutter/material.dart';
import '../../../core/base/view/base_view.dart';
import '../../../core/components/app/app_logo.dart';
import '../../../core/components/app/header_buttons.dart';
import '../../../core/constants/app/application_constants.dart';

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
      return buildShimmer();
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: dynamicPadding(dynamicHeight(.08), dynamicWidth(.04)),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: viewModel.allContents?.length,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 700,
                crossAxisSpacing: dynamicWidth(.025),
                mainAxisSpacing: dynamicHeight(.04),
              ),
              itemBuilder: (context, i) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: .8, color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: InkWell(
                    onTap: () {
                      NavigationService.instance.navigateToPage(
                        path: NavigationConstants.CONTENT,
                        data: viewModel.allContents?[i].id.toString(),
                      );
                    },
                    child: Column(
                      children: [
                        Expanded(
                          flex: 6,
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(24),
                                topRight: Radius.circular(24),
                              ),
                              image: DecorationImage(
                                image: NetworkImage(
                                  "https://www.simplilearn.com/ice9/free_resources_article_thumb/what_is_image_Processing.jpg",
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: dynamicPadding(15, 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${viewModel.allContents?[i].category}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                    color: Colors.grey.shade500,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  "${viewModel.allContents?[i].title}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  "${ApplicationConstants.MONTHS[viewModel.allContents![i].time!.month - 1]} ${viewModel.allContents?[i].time?.day}, ${viewModel.allContents?[i].time?.year}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    color: Colors.grey.shade400,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Center buildShimmer() {
    return const Center(
      child: SizedBox(
        height: 50,
        width: 50,
        child: CircularProgressIndicator(),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      toolbarHeight: 100,
      backgroundColor: Colors.white,
      shape: const Border(bottom: BorderSide(color: Colors.black, width: .15)),
      title: Padding(
        padding: MediaQuery.of(context).size.width < 700
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
    );
  }
}
