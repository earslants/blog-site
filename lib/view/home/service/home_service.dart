import 'package:emirhanarslantascom/core/init/network/network_manager.dart';
import 'package:emirhanarslantascom/view/home/model/all_contents_model.dart';
import 'package:emirhanarslantascom/view/home/service/IHomeService.dart';
import 'package:flutter/material.dart';

class HomeService extends IHomeService {
  AllContentsModel allContentsModel = AllContentsModel();
  BuildContext? context;
  HomeService({this.context});

  @override
  Future<List<AllContentsModel>> fetchAllContents(String query) async {
    final response = await NetworkManager.instance.dioGet(path: query);

    return (response as List)
        .map((json) => allContentsModel.fromJson(json))
        .toList();
  }
}
