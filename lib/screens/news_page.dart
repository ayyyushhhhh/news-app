import 'package:flutter/material.dart';
import 'package:news_app/bloc/news_stream.dart';
import 'package:news_app/model/news_model.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final NewsBloc _newsBloc = NewsBloc();

  @override
  void dispose() {
    super.dispose();
    _newsBloc.dispose();
  }

  Container _buildNewsContainer(
      {required int index, required List<Article> articles}) {
    return Container(
      //margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
        //borderRadius: BorderRadius.circular(10),
        color: Colors.black54,
      ),
      child: Column(
        children: [
          Image.network(articles[index].urlToImage.toString()),
          SizedBox(
            height: 10,
          ),
          Text(
            articles[index].title.toString(),
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.w600, color: Colors.white),
          ),
          Divider(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _newsBloc.fetchAllNews();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Your News"),
      ),
      body: StreamBuilder(
        stream: _newsBloc.getNewsStream(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            List<Article> articles = snapshot.data;
            return ListView.builder(
              itemCount: articles.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildNewsContainer(index: index, articles: articles);
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
