import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class ImageWidget extends StatelessWidget {
  
  
  const ImageWidget({super.key, this.image, required this.entity,
    required this.option,
    this.onTap,
    });

  final String? image;
  final AssetEntity entity;
  final ThumbnailOption option;
  final GestureTapCallback? onTap;


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, bottom: 10),
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, 'photo', arguments: entity),
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