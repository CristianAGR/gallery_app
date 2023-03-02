import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  
  final String image;
  const ImageWidget({super.key, required this.image});


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, bottom: 10),
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, 'photo', arguments: image),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(3),
          child: Image(fit: BoxFit.cover, width: 80, height: 90,image: NetworkImage(image)),
        ),
      ),
    );
  }
}