import 'dart:async';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/news.dart';
import '../utils/widget/drawer_menu.dart';
import '../utils/widget/search_page.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var news;

  @override
  void initState() {
    news = _fetchNews();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/logo.png', width: 150),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SearchPage(imageUrl: 'assets/logo.png'),
              ),
            ),
          )
        ],
      ),
      drawer: DrawerMenu(),
      body: FutureBuilder(
        future: news,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return RefreshIndicator(
              onRefresh: () {
                return _fetchNews();
              },
              child: CustomScrollView(
                slivers: <Widget>[
                  buildCarousel(snapshot),
                  buildListItem(snapshot),
                ],
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  SliverList buildListItem(AsyncSnapshot snapshot) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width / 1.6,
                      child: Text(
                        snapshot.data[index].title,
                        maxLines: 3,
                        softWrap: true,
                      ),
                    ),
                    SizedBox(height: 25),
                    Text(
                      snapshot.data[index].author != null
                          ? snapshot.data[index].author
                          : "No Author",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black26,
                      ),
                    )
                  ],
                ),
                Container(
                  height: 90,
                  width: 90,
                  child: CachedNetworkImage(
                    imageUrl: snapshot.data[index].urlToImage ?? 'null',
                    fit: BoxFit.cover,
                    errorWidget: (context, url, object) {
                      return Image.asset('assets/image_placeholder.jpg');
                    },
                    placeholder: (context, string) =>
                        Image.asset('assets/image_placeholder.jpg'),
                  ),
                ),
              ],
            ),
          );
        },
        childCount: snapshot.data.length,
      ),
    );
  }

  SliverToBoxAdapter buildCarousel(AsyncSnapshot snapshot) {
    return SliverToBoxAdapter(
      child: CarouselSlider.builder(
        autoPlay: true,
        autoPlayCurve: Curves.fastOutSlowIn,
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return Stack(
            children: <Widget>[
              Container(
                height: 200,
                width: 300,
                child: Image.network(
                  snapshot.data[index].urlToImage,
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                bottom: 3,
                child: Container(
                  height: 50,
                  width: 300,
                  color: Colors.black26,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Container(
                      width: 270,
                      child: Text(
                        snapshot.data[index].title,
                        style: TextStyle(color: Colors.white),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Column separatedLabel(String title) {
    return Column(
      children: <Widget>[
        Text(title),
        Divider(),
      ],
    );
  }
}

Future<List<News>> _fetchNews() async {
  final String url =
      "https://newsapi.org/v2/top-headlines?country=id&apiKey=674a9b8a1d504bdb94aee29e74c60bf7";
  final response = await http.get(url);

  return compute(_parseNews, response.body);
}

List<News> _parseNews(String responseBody) {
  final parsed = jsonDecode(responseBody)['articles'];

  return parsed.map<News>((json) => News.fromJson(json)).toList();
}
