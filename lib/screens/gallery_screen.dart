import 'package:flutter/material.dart';
import 'package:gallery_app/screens/albums_screen.dart';
import 'package:gallery_app/screens/photos_screen.dart';
import 'package:provider/provider.dart';

class GalleryScreen extends StatelessWidget {
   
  const GalleryScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            shadowColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            title: const TabBar(
              labelColor: Colors.black,
              tabs: [
                Tab(text: "Photos",),
                Tab(text: "Albums",),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              PhotosScreen(),
              AlbumsScreen()
            ],
          ),
        ),
      );
  }
}
