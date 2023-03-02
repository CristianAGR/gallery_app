import 'package:flutter/material.dart';

class PhotoScreen extends StatelessWidget {
   
  const PhotoScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final String image = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black,)),
            const Text("17/02/23", style: TextStyle(color: Colors.black),)
            ],
        ),
        backgroundColor: Color.fromARGB(0, 53, 51, 51),
        shadowColor: Colors.transparent,
      ),
      body: Center(
         child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //https://cdn.pixabay.com/photo/2023/01/05/22/35/flower-7700011_640.jpg
            Image(image: NetworkImage(image)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(onPressed: addFavorite, icon: Icon(Icons.delete)),
                IconButton(onPressed: addFavorite, icon: Icon(Icons.favorite_border)),
                IconButton(onPressed: addFavorite, icon: Icon(Icons.menu))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const[
                Text("Delete"),
                Text("Favorite"),
                Text("Datails")
              ],
            )
          ],
         )
      ),
    );
  }

  void addFavorite() {
  }
}