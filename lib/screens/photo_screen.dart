import 'package:flutter/material.dart';
import 'package:gallery_app/providers/images_services.dart';
import 'package:photo_manager/photo_manager.dart';

class PhotoScreen extends StatelessWidget {
   
  const PhotoScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    // recibes the entity argument
    final AssetEntity entity = ModalRoute.of(context)!.settings.arguments as AssetEntity;
    var services = ImagesServices(); 

    // Icon change when is selected
    IconData favIcon = Icons.favorite_border;
     bool iconChange(AssetEntity entity) {
      favIcon = services.addFavorite(favIcon);
       print("New favorite");
       //favIcon = Icons.favorite;
     return entity.isFavorite;
     }
    

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black,)),
            Text(services.formatDate(entity), style: const TextStyle(color: Colors.black),)
            ],
        ),
        backgroundColor: const Color.fromARGB(0, 53, 51, 51),
        shadowColor: Colors.transparent,
      ),
      body: Center(
         child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //https://cdn.pixabay.com/photo/2023/01/05/22/35/flower-7700011_640.jpg
            // recibe la imagen seleccionada y la muestra
            AssetEntityImage(entity),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(onPressed: () => services.deleteEntity(entity), icon: const Icon(Icons.delete)),
                IconButton(onPressed: () => iconChange(entity), icon: Icon(favIcon)),
                IconButton(onPressed: () => iconChange(entity), icon: const Icon(Icons.menu))
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

  
  





}