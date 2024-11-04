import 'package:emirhanarslantascom/core/init/network/network_manager.dart';
import 'package:emirhanarslantascom/view/content/model/content_model.dart';
import 'package:emirhanarslantascom/view/content/service/IContentService.dart';
import 'package:flutter/material.dart';

class ContentService extends IContentService {
  Content contentModel = Content();
  BuildContext? context;

  ContentService({this.context});
  @override
  Future<Content> fetchContent(String query) async {
    final response = await NetworkManager.instance.dioGet(path: query);

    return contentModel.fromJson(response);
  }
}
