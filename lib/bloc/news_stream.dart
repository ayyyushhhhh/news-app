import 'dart:async';

import 'package:news_app/model/news_model.dart';
import 'package:news_app/persistence/api_provider.dart';

class NewsBloc {
  final StreamController<List<Article>> _newsStreamController =
      StreamController<List<Article>>();

  Stream getNewsStream() {
    return _newsStreamController.stream;
  }

  Future fetchAllNews() async {
    final APIProvider apiProvider = APIProvider();
    final newsList = await apiProvider.fetchNews();
    _newsStreamController.add(newsList);
  }

  void dispose() {
    _newsStreamController.close();
  }
}
