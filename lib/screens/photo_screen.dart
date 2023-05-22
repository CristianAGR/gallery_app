import 'package:flutter/material.dart';
import 'package:gallery_app/providers/images_services.dart';
import 'package:gallery_app/widgets/image_widget.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';
import '../providers/images_provider.dart';

class PhotoScreen extends StatefulWidget {
  PhotoScreen({Key? key}) : super(key: key);

  @override
  State<PhotoScreen> createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
  var services = ImagesServices();

  // Icon change when is selected
  IconData favIcon = Icons.favorite_border;

  @override
  Widget build(BuildContext context) {
    services.enableRotation();
    // recibes the entity argument
    final ScreenArguments screenArguments =
        ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    final AssetEntity entity = screenArguments.entity;
    final AssetPathEntity path = screenArguments.path;

    return ChangeNotifierProvider<AssetPathProvider>(
      create: (_) => AssetPathProvider(path),
      builder: (BuildContext context, _) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.black,
                  )),
              Text(
                services.formatDate(entity),
                style: const TextStyle(color: Colors.black),
              )
            ],
          ),
          backgroundColor: const Color.fromARGB(0, 53, 51, 51),
          shadowColor: Colors.transparent,
        ),
        body: _buildItem(context, entity, favIcon),
        bottomNavigationBar: CustomBottomBar(services: services, entity: entity, favIcon: favIcon),
      ),
    );
  }
  

  @override
  void dispose() {
    services.portraitModeOnly();
    super.dispose();
  }

  Widget _buildItem(BuildContext context, entity, favIcon) {
    return OrientationBuilder(builder: (context, orientation) {
      return Center(
          child: ListView(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // recibe la imagen seleccionada y la muestra
            InteractiveViewer(
        boundaryMargin: EdgeInsets.all(0.0),
        minScale: 0.1,
        maxScale: 2.5,
        child: AssetEntityImage(
              entity,
              height: orientation == Orientation.portrait ? 650 : 230,
            ),
      ),
            
          ],
        ),
      ]));
    });
  }
}

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({
    Key? key,
    required this.services,
    required this.entity,
    required this.favIcon,
  }) : super(key: key);

  final ImagesServices services;
  final AssetEntity entity;
  final IconData favIcon;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.transparent,
      elevation: 0,
      child: IconTheme(
    data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
    child: 
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  tooltip: 'Delete',
                    onPressed: () =>
                        services.deleteCurrent(context, entity),
                    icon: const Icon(Icons.delete, color: Colors.black,)),
                IconButton(
                  tooltip: 'Favorite',
                    onPressed: () => services.iconChange(entity),
                    icon: Icon(favIcon, color: Colors.black)),
                IconButton(
                  tooltip: 'Details',
                    onPressed: () => services.iconChange(entity),
                    icon: const Icon(Icons.menu, color: Colors.black))
              ],
            ),

      ),
    );
  }
}
