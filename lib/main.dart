import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterblocapi/bloc/article_bloc.dart';
import 'package:flutterblocapi/data/repository/article_repository.dart';
import 'package:flutterblocapi/ui/pages/home_page.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:BlocProvider(create: (context)=>ArticleBloc(repository: ArticleRepositoryImpl()),
        child: HomePage(),
      ),
    );

  }
}
