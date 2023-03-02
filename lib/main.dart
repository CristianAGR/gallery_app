import 'package:flutter/material.dart';
import 'package:gallery_app/screens/album_screen.dart';
import 'package:gallery_app/screens/albums_screen.dart';
import 'package:gallery_app/screens/gallery_screen.dart';
import 'package:gallery_app/screens/photo_screen.dart';
import 'package:gallery_app/screens/photos_screen.dart';
import 'package:gallery_app/themes/app_Theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gallery',
      initialRoute: 'gallery',
      routes: {
        'photos': ( _ ) => const PhotosScreen(),
        'photo': ( _ ) => const PhotoScreen(),
        'albums': ( _ ) => const AlbumsScreen(),
        'album': ( _ ) => const AlbumScreen(),
        'gallery': ( _ ) => const GalleryScreen()
      },
      theme: AppTheme.lightTheme,
    );
  }
}