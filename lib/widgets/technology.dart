import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:taza_khabar/constants.dart';
import "package:http/http.dart" as http;
import 'package:taza_khabar/widgets/CardItem.dart';
import 'package:taza_khabar/widgets/articles.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';

class TechnologyScreen extends StatefulWidget {
  const TechnologyScreen({super.key});

  @override
  State<TechnologyScreen> createState() => _TechnologyScreenState();
}

class _TechnologyScreenState extends State<TechnologyScreen> {
  List<dynamic> articles = [];
  @override
  void initState() {
    // TODO: implement initState
    getTechnologyNews();
    super.initState();
  }

  Future getTechnologyNews() async {
    String key = Constants.key;
    var url = Uri.https('newsapi.org', '/v2/top-headlines',
        {"country": "in", "category": "technology", "apiKey": key});

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
        future: getTechnologyNews(),
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
