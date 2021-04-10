import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:youtubeproject/api.dart';
import 'package:youtubeproject/blocs/favorite_bloc.dart';
import 'package:youtubeproject/blocs/videos_bloc.dart';
import 'package:youtubeproject/screens/home.dart';

void main() {
  Api api = Api();
  api.search('eletro');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [
        Bloc((i) => VideosBloc()),
        Bloc((i) => FavoriteBloc()),
      ],
      child: MaterialApp(
        title: 'FlutterTube',
        home: Home(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
