import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import "package:http/http.dart" as http;
import '../constants.dart';
import 'CardItem.dart';
import 'articles.dart';

class SportsScreen extends StatefulWidget {
  const SportsScreen({super.key});

  @override
  State<SportsScreen> createState() => _SportsScreenState();
}

class _SportsScreenState extends State<SportsScreen> {
  List<dynamic> articles = [];
  Future getSportsNews() async {
    String key = Constants.key;
    var url = Uri.https('newsapi.org', '/v2/top-headlines',
        {"country": "in", "category": "sports", "apiKey": key});

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var res = json.decode(response.body);
      res = res['articles'];
      articles = res.map((value) => ArticlesData.fromJson(value)).toList();
      print(articles[0].title);
      return res;
    }
  }

  @override
  Widget build(BuildContext context) {
    int len;
    return Container(
      color: Color.fromARGB(255, 238, 235, 235),
      child: FutureBuilder(
        future: getSportsNews(),
        builder: ((context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemBuilder: (context, index) {
                    return CardItem(
                      news: snapshot.data[index],
                    );
                  },
                  itemCount: articles.length,
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        }),
      ),
    );
  }
}
