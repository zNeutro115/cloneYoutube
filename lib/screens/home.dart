import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:youtubeproject/blocs/favorite_bloc.dart';
import 'package:youtubeproject/blocs/videos_bloc.dart';
import 'package:youtubeproject/delegates/data_search.dart';
import 'package:youtubeproject/models/video.dart';
import 'package:youtubeproject/screens/favorites.dart';
import 'package:youtubeproject/widgets/videotile.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.getBloc<VideosBloc>();
    return Scaffold(
      appBar: AppBar(
        title: Container(
            height: 25, child: Image.asset('images/youtube_logo.png')),
        backgroundColor: Colors.white,
        actions: <Widget>[
          Align(
            alignment: Alignment.center,
            child: StreamBuilder<Map<String, Video>>(
              stream: BlocProvider.getBloc<FavoriteBloc>().outFav,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    '${snapshot.data.length}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.star,
              color: Colors.black87,
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => Favorites()),
              );
            },
          ),
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.black87,
            ),
            onPressed: () async {
              String result =
                  await showSearch(context: context, delegate: DataSearch());
              if (result != null) {
                bloc.inSearch.add(result);
              }
            },
          ),
        ],
      ),
      body: StreamBuilder(
        initialData: [],
        stream: bloc.outVideos,
        builder: (context, snapshot) {
          if (snapshot.hasData)
            return ListView.builder(
              itemCount: snapshot.data.length + 1,
              itemBuilder: (context, index) {
                if (index < snapshot.data.length) {
                  return VideoTile(snapshot.data[index]);
                } else if (index > 1) {
                  bloc.inSearch.add(null);
                  return Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.redAccent[700]),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            );
          else {
            return Container();
          }
        },
      ),
    );
  }
}
