import 'package:emirhanarslantascom/core/constants/enums/network_route.dart';
import 'package:emirhanarslantascom/view/home/model/all_contents_model.dart';
import 'package:emirhanarslantascom/view/home/service/IHomeService.dart';
import 'package:emirhanarslantascom/view/home/service/home_service.dart';
import 'package:flutter/material.dart';

import '../../../core/base/viewmodel/base_view_model.dart';

class HomeViewModel extends BaseViewModel with ChangeNotifier {
  List<AllContentsModel>? allContents;
  IHomeService? homeService;

  @override
  void init() {
    homeService = HomeService(context: myContext);
    fetchAllContents();
  }

  @override
  void setContext(BuildContext context) => myContext = context;

  void fetchAllContents() async {
    try {
      allContents =
          await homeService!.fetchAllContents(NetworkRoutes.HOME.rawValue);
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }
}
