import 'package:emirhanarslantascom/view/home/model/all_contents_model.dart';

abstract class IHomeService {
  Future<List<AllContentsModel>> fetchAllContents(String query);
}
