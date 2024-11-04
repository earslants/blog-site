import 'package:emirhanarslantascom/core/constants/app/application_constants.dart';
import 'package:emirhanarslantascom/core/constants/navigation/navigation_constants.dart';
import 'package:emirhanarslantascom/core/init/navigation/navigation_service.dart';
import 'package:emirhanarslantascom/view/home/viewmodel/home_view_model.dart';
import 'package:flutter/material.dart';
import '../../../core/base/view/base_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
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
    body: SizedBox(
      height: 400,
      width: 300,
      child: ListView.builder(
        itemCount: viewModel.allContents?.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              NavigationService.instance.navigateToPage(
                path: NavigationConstants.CONTENT,
                data: viewModel.allContents?[index].id.toString(),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                border: Border.all(width: .4),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text("${viewModel.allContents?[index].id}"),
                  Text("${viewModel.allContents?[index].category}"),
                  Text("${viewModel.allContents?[index].title}"),
                  Text(ApplicationConstants
                      .MONTHS[viewModel.allContents![index].time!.month - 1]),
                ],
              ),
            ),
          );
        },
      ),
    ),
  );
}
