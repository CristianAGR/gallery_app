
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';

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

}



