import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterblocapi/bloc/article_bloc.dart';
import 'package:flutterblocapi/bloc/article_state.dart';
import 'package:flutterblocapi/data/model/api_result_model.dart';
import 'package:flutterblocapi/ui/pages/about_us_page.dart';
import 'package:flutterblocapi/ui/pages/article_detail_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ArticleBloc articleBloc;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (context) {
          return Material(
            child: Scaffold(
              appBar: AppBar(
                title: Text("Health"),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: () {
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.info),
                    onPressed: () {
                      navigateToArticleAboutPage(context);
                    },
                  ),
                ],
              ),
              body: Container(
                child: BlocBuilder<ArticleBloc, ArticleState>(
                  builder: (context, state) {
                    if (state is ArticleInitialState) {
                      return buildLoading();
                    } else if (state is ArticleLoadedState) {
                      return buildArticleList(state.articlesList);
                    } else if (state is ArticleErrorState) {
                      return buildErrorUi(state.message);
                    } else if (state is ArticleLoadingState) {
                      return buildLoading();
                    }
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildErrorUi(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          message,
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  Widget buildArticleList(List<Articles> articles) {
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (ctx, pos) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            child: ListTile(
              leading: ClipOval(
                child: Hero(
                  tag: articles[pos].urlToImage,
                  child: articles[pos].urlToImage != null
                      ? Image.network(
                          articles[pos].urlToImage,
                          fit: BoxFit.cover,
                          height: 70.0,
                          width: 70.0,
                        )
                      : Container(),
                ),
              ),
              title: Text(articles[pos].title),
              subtitle: Text(articles[pos].publishedAt),
            ),
            onTap: () {
              navigateToArticleDetailPage(context, articles[pos]);
            },
          ),
        );
      },
    );
  }

  void navigateToArticleDetailPage(BuildContext context, Articles articles) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ArticleDetailPage(articles);
    }));
  }

  void navigateToArticleAboutPage(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AboutPage();
    }));
  }
}
