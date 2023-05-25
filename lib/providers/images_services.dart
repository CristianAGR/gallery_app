
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';

import '../util/log.dart';
import 'images_provider.dart';

class ImagesServices extends ChangeNotifier{
AssetPathProvider readPathProvider(BuildContext c) =>
      c.read<AssetPathProvider>();


  // method to return a formated date
  formatDate(AssetEntity entity) {
    var dayName = [
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday"
    ];
     DateTime date =   entity.modifiedDateTime;
     String formatedDate =  "${dayName[date.weekday - 1]} ${date.day}/${date.month}/${date.year}";
     return formatedDate;
   }
      
  Future<void> deleteCurrent(BuildContext context, AssetEntity entity) async {
    if (Platform.isAndroid) {
      final AlertDialog dialog = AlertDialog(
        title: const Text('Delete the asset'),
        actions: <Widget>[
          TextButton(
            child: const Text(
              'delete',
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () async {
              readPathProvider(context).delete(entity);
              Navigator.pop(context);
              //Navigator.popUntil(context, ModalRoute.withName('gallery'));
            },
          ),
          TextButton(
            child: const Text('cancel'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      );
      showDialog<void>(context: context, builder: (_) => dialog);
    } else {
      readPathProvider(context).delete(entity);
    }
  }

/// blocks rotation; sets orientation to: portrait
void portraitModeOnly() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

void enableRotation() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
}

//Takes a photo or video with the cameras
Future<void> takePhoto(context) async {
  final picker = ImagePicker();
                  final XFile? archivoSeleccionado =
                      await picker.pickImage(source: ImageSource.camera, imageQuality: 100);
                  if (archivoSeleccionado == null) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('No se ha la imagen')));
                    return;
                  }
                  saveImageWithPath(archivoSeleccionado.path);
                  print('La imagen fue capturada con éxito en ${archivoSeleccionado.path}.');
}

// save an image after the photo is taken
Future<void> saveImageWithPath(String path) async {
    final File file = File(path);
    print(file);
      Log.d('write image to file success: $file');
      final AssetEntity? asset = await PhotoManager.editor.saveImageWithPath(
        file.path,
        title: '${DateTime.now().millisecondsSinceEpoch}.jpg',
      );
      Log.d('saved asset: $asset');
  }

// save a video with a path
  Future<void> saveVideo(String path) async {

    final File file = File(path);
    if (file.existsSync()) {
      file.deleteSync();
    }
      Log.d('file path = ${file.lengthSync()}');
      final AssetEntity? asset =
          await PhotoManager.editor.saveVideo(
            file, 
            title: '${DateTime.now().millisecondsSinceEpoch}.jpg'
          );
      Log.d('saved video: $asset');
  }
   addFavorite(IconData favIcon) {
      print("New favorite");
      favIcon = Icons.favorite;
    return favIcon;
    }
  
    // Icon change when is selected
    IconData favIcon = Icons.favorite_border;
  bool iconChange(AssetEntity entity) {
      favIcon = addFavorite(favIcon);
       print("New favorite");
       //favIcon = Icons.favorite;
     return entity.isFavorite;
     }
}



