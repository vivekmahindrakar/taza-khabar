import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import "package:flutter/material.dart";
import 'package:url_launcher/url_launcher.dart';
import "package:velocity_x/velocity_x.dart";

class CardItem extends StatefulWidget {
  dynamic news;
  CardItem({super.key, this.news});

  @override
  State<CardItem> createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  Future<void>? _launched;
  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Column(
        children: [
          widget.news["title"] != null
              ? Text(widget.news["title"],
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))
              : Text(
                  "title not available",
                ),
          SizedBox(
            height: 20,
          ),
          widget.news['urlToImage'] != null
              ? Image.network(widget.news['urlToImage'])
              : Image.asset("assets/images/notavailable.png"),
          SizedBox(
            height: 20,
          ),
          widget.news["description"] != null
              ? Text(
                  //textAlign: TextAlign.justify,
                  widget.news["description"],
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      // fontWeight: FontWeight.w800,
                      color: Color.fromARGB(255, 56, 56, 56)),
                )
              : Text("description not available"),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Text("Source : ${widget.news["source"]["name"]}"),

              ElevatedButton.icon(
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      backgroundColor: MaterialStateProperty.all(Colors.white)),
                  onPressed: () {
                    setState(() {
                      _launched =
                          _launchInBrowser(Uri.parse(widget.news["url"]));
                    });
                  },
                  icon: Icon(
                    Icons.link_rounded,
                    color: Color.fromARGB(255, 129, 129, 129),
                  ),
                  label: Text(
                    "Full article",
                    style: TextStyle(color: Colors.blue),
                  ))

              // InkWell(
              //   overlayColor: MaterialStateProperty.all(Colors.amber),
              //   child: Text(
              //     "click here",
              //     style: TextStyle(color: Colors.blue[800]),
              //   ),
              //   onTap: () {
              // setState(() {
              //   _launched = _launchInBrowser(Uri.parse(widget.news["url"]));
              // });
              //   },
              // )
            ],
          )
        ],
      ).p16(),
    );
  }
}
