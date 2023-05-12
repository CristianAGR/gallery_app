import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class ScreenArguments {
  final AssetPathEntity path;
  final AssetEntity entity;
  ScreenArguments(this.path, this.entity);
}

class ImageWidget extends StatelessWidget {
  
  
  const ImageWidget({super.key, this.image, required this.path, required this.entity,
    required this.option,
    this.onTap,
    });
  final AssetPathEntity path;
  final String? image;
  final AssetEntity entity;
  final ThumbnailOption option;
  final GestureTapCallback? onTap;

  


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, bottom: 10),
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, 'photo', arguments: ScreenArguments(path, entity)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(3),
          child: AssetEntityImage(
            entity
            )
          //Image(fit: BoxFit.cover, width: 80, height: 90,image: NetworkImage(image)),
        ),
      ),
    );
  }
}