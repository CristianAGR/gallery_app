import 'package:flutter/material.dart';

class AlbumWidget extends StatelessWidget {
  const AlbumWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const album = "https://cdn.pixabay.com/photo/2023/01/05/22/35/flower-7700011_640.jpg";
    return Container(
      margin: const EdgeInsets.only(left: 10, bottom: 10),
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, 'album', arguments: album),
        child: Column(
          children: [
            const Text("Album", textAlign: TextAlign.start, style: TextStyle(fontWeight: FontWeight.bold),),
            Row(
              children: const [
                ClipRRect(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(3)),
                  child: Image(fit: BoxFit.cover, width: 50, height: 52,image: NetworkImage(album)),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(3)),
                  child: Image(fit: BoxFit.cover, width: 50, height: 52,image: NetworkImage(album)),
                ),
              ],
            ),
            Row(
              children: const [
                ClipRRect(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(3)),
                  child: Image(fit: BoxFit.cover, width: 50, height: 52,image: NetworkImage(album)),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(3)),
                  child: Image(fit: BoxFit.cover, width: 50, height: 52,image: NetworkImage(album)),
                ),
              ],
            ),
            const Text("10 items", textAlign: TextAlign.start,),
          ],
        ),
      ),
    );
  }
}