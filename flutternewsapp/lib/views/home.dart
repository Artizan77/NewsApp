import 'package:flutter/material.dart';
import 'package:flutternewsapp/helper/data.dart';
import 'package:flutternewsapp/helper/news.dart';
import 'package:flutternewsapp/models/article_model.dart';
import 'package:flutternewsapp/models/category_model.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _loading = true;
  List<CategoryModel> categories = List<CategoryModel>();
  List<ArticleModel> articles = List<ArticleModel>();
  @override
  void initState() {
    super.initState();
    categories = getCategories();
    getNews();
  }

  getNews() async {
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Flutter"),
            Text(
              "News",
              style: TextStyle(color: Colors.blue),
            )
          ],
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: _loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              child: Column(
                children: [
                  ///CATEGORIES
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    height: 70,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return CategroyTile(
                          imageUrl: categories[index].imageUrl,
                          categoryName: categories[index].categoryName,
                        );
                      },
                      itemCount: categories.length,
                    ),
                  ),

                  ///BLOGS
                  Container(
                    height: 70,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return BlogTile(
                            imageUrl: articles[index].articleUrl,
                            title: articles[index].title,
                            desc: articles[index].description);
                      },
                      itemCount: articles.length,
                    ),
                  )
                ],
              ),
            ),
    );
  }
}

class CategroyTile extends StatelessWidget {
  final imageUrl, categoryName;

  CategroyTile({this.categoryName, this.imageUrl});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(right: 14),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(imageUrl,
                  width: 120, height: 60, fit: BoxFit.cover),
            ),
            Container(
              alignment: Alignment.center,
              width: 120,
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.black26),
              child: Text(
                categoryName,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final String imageUrl, title, desc;
  BlogTile(
      {@required this.imageUrl, @required this.title, @required this.desc});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
          Text(title),
          Text(desc)
        ],
      ),
    );
  }
}
