import 'package:emirhanarslantascom/view/content/model/content_model.dart';

abstract class IContentService {
  Future<Content> fetchContent(String query);
}
