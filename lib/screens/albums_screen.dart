import 'package:flutter/material.dart';
import 'package:gallery_app/widgets/album_widget.dart';

class AlbumsScreen extends StatelessWidget {
   
  const AlbumsScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const Text("Albums", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
          IconButton(onPressed: addAlbum, icon: const Icon(Icons.post_add_rounded), alignment: Alignment.topRight,),
          Row(
            children:const[
              AlbumWidget(),
              AlbumWidget(),
              AlbumWidget()
            ],
          ),
          Row(
            children:const[
              AlbumWidget(),
              AlbumWidget(),
              AlbumWidget()
            ],
          ),
          Row(
            children:const[
              AlbumWidget(),
              AlbumWidget(),
              AlbumWidget()
            ],
          )
        ],
      )
    );
  }

  void addAlbum() {
  }
}