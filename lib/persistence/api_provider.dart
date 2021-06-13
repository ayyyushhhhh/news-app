import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/api_key.dart';
import 'package:news_app/model/news_model.dart';

class APIProvider {
  List<Article> _newsArticles = [];
  Future fetchNews() async {
    final String _apiKey = APIkey.key;
    final _url =
        "https://newsapi.org/v2/everything?q=Apple&from=2021-06-08&sortBy=popularity&apiKey=$_apiKey";
    http.Response response = await http.get(
      Uri.parse(_url),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      jsonData["articles"].forEach((article) {
        Article newsModel = Article.fromJson(article);
        _newsArticles.add(newsModel);
      });
      return _newsArticles;
    } else {
      throw Exception('Failed to load News');
    }
  }
}
