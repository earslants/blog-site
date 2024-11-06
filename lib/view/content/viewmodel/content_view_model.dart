import 'package:carousel_slider/carousel_slider.dart';
import 'package:emirhanarslantascom/core/constants/enums/network_route.dart';
import 'package:emirhanarslantascom/view/content/model/content_model.dart';
import 'package:emirhanarslantascom/view/content/service/IContentService.dart';
import 'package:emirhanarslantascom/view/content/service/content_service.dart';
import 'package:flutter/material.dart';

import '../../../core/base/viewmodel/base_view_model.dart';

class ContentViewModel extends BaseViewModel with ChangeNotifier {
  Content? content;
  IContentService? contentService;
  final CarouselSliderController sliderController = CarouselSliderController();

  @override
  void init() {
    contentService = ContentService(context: myContext);
  }

  @override
  void setContext(BuildContext context) => myContext = context;

  void fetchContent(String id) async {
    try {
      content = await contentService!
          .fetchContent(NetworkRoutes.CONTENT.rawValue.replaceAll("{id}", id));
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }
}
