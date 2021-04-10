import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:youtubeproject/blocs/favorite_bloc.dart';
import 'package:youtubeproject/models/video.dart';
import 'package:youtubeproject/screens/playeryoutube.dart';

class Favorites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.getBloc<FavoriteBloc>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Favoritos'),
        centerTitle: true,
      ),
      body: StreamBuilder<Map<String, Video>>(
        initialData: {},
        stream: bloc.outFav,
        builder: (context, snapshot) {
          return ListView(
            children: snapshot.data.values.map((videos) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => YouPlayer(videos.id)),
                    );
                  },
                  onLongPress: () {
                    bloc.toggleFavorite(videos);
                  },
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 100,
                        height: 50,
                        child: Image.network(videos.thumb),
                      ),
                      Expanded(
                          child: Text(
                        videos.title,
                        style: TextStyle(color: Colors.black),
                        maxLines: 2,
                      ))
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
