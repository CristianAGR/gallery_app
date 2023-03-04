
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class ImagesServices extends ChangeNotifier{



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

  deleteEntity(AssetEntity entity) {
    var id = entity.id;
  }

   addFavorite(IconData favIcon) {
      print("New favorite");
      favIcon = Icons.favorite;
    return favIcon;
    }
  
}



