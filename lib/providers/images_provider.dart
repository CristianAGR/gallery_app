import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class ImagesServices extends ChangeNotifier{
  
  getImages() async {
  final PermissionState _ps = await PhotoManager.requestPermissionExtend();
if (_ps.isAuth) {
  // Granted.
} else {
  // Limited(iOS) or Rejected, use `==` for more precise judgements.
  // You can call `PhotoManager.openSetting()` to open settings for further steps.
}

//final List<AssetEntity> entities = await path.getAssetListPaged(page: 0, size: 80);
}
  
}



