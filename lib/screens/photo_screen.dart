import 'package:flutter/material.dart';
import 'package:gallery_app/providers/images_services.dart';
import 'package:gallery_app/widgets/image_widget.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';
import '../providers/images_provider.dart';

class PhotoScreen extends StatelessWidget {
   
  PhotoScreen({Key? key}) : super(key: key);
  var services = ImagesServices(); 
    // Icon change when is selected
    IconData favIcon = Icons.favorite_border;

  @override
  Widget build(BuildContext context) {
    // recibes the entity argument
    final ScreenArguments screenArguments = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    final AssetEntity entity = screenArguments.entity;
    final AssetPathEntity path = screenArguments.path;

      return ChangeNotifierProvider<AssetPathProvider>(
      create: (_) => AssetPathProvider(path),
      builder: (BuildContext context, _) => Scaffold(
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
        body: _buildItem(context, entity,favIcon),
      ),
    );

  }

  Widget _buildItem(BuildContext context, entity,favIcon) {
    return Center(
       child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //https://cdn.pixabay.com/photo/2023/01/05/22/35/flower-7700011_640.jpg
          // recibe la imagen seleccionada y la muestra
          AssetEntityImage(entity),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(onPressed: () => services.deleteCurrent(context, entity), icon: const Icon(Icons.delete)),
              IconButton(onPressed: () => services.iconChange(entity), icon: Icon(favIcon)),
              IconButton(onPressed: () => services.iconChange(entity), icon: const Icon(Icons.menu))
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
    );
   }

}