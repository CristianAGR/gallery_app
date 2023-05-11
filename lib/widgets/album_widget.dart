import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class AlbumWidget extends StatefulWidget {
  const AlbumWidget({super.key, required this.albumPath});

  final AssetPathEntity albumPath;

  @override
  State<AlbumWidget> createState() => _AlbumWidgetState();
}

class _AlbumWidgetState extends State<AlbumWidget> {

    AssetEntity? img1;
    AssetEntity? img2;
    AssetEntity? img3;
    AssetEntity? img4;

/// Customize your own filter options.
  final FilterOptionGroup _filterOptionGroup = FilterOptionGroup(
    imageOption: const FilterOption(
      sizeConstraint: SizeConstraint(ignoreSize: true),
    ),
  );
  final int _sizePerPage = 50;
  List<AssetEntity>? _entities;
  //int _totalEntitiesCount = 0;

  int itemsCount = 0;
  AssetPathEntity? _path;

    Future<void> _getItemsCount() async {
      final List<AssetEntity> entities = await _path!.getAssetListPaged(
       page: 0,
       size: _sizePerPage,
     );
     _entities = entities;
     setState(() {});
      itemsCount = await _path!.assetCountAsync;
      setState(() {
        
      });
    
      
    }

    // final List<AssetEntity> entities = await widget.albumPath.getAssetListPaged(
    //   page: 0,
    //   size: 50,
    // );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _path = widget.albumPath;
    _getItemsCount();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, bottom: 10),
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, 'album', arguments: _path),
        child: Column(
          children: [
            Text(widget.albumPath.name, textAlign: TextAlign.start, style: const TextStyle(fontWeight: FontWeight.bold),),
            Row(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(3)),
                  child: itemsCount > 0 ? AlbumImage(entity: _entities![0]) : const AlbumImageDefault(),
                ),
                ClipRRect(
                  borderRadius: const BorderRadius.only(topRight: Radius.circular(3)),
                  child: itemsCount > 1 ? AlbumImage(entity: _entities![1]) : const AlbumImageDefault(),
                ),
              ],
            ),
            Row(
              children:  [
                ClipRRect(
                  borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(3)),
                  child: itemsCount > 2 ? AlbumImage(entity: _entities![2]) : const AlbumImageDefault(),
                ),
                ClipRRect(
                  borderRadius: const BorderRadius.only(bottomRight: Radius.circular(3)),
                  child: itemsCount > 3 ? AlbumImage(entity: _entities![3]) : const AlbumImageDefault(),
                ),
              ],
            ),
            Text("$itemsCount items", textAlign: TextAlign.start,),
          ],
        ),
      ),
    );
  }
}

class AlbumImage extends StatelessWidget {
  const AlbumImage({
    Key? key,
    required this.entity,
  });

  final AssetEntity entity;

  @override
  Widget build(BuildContext context) {
    return AssetEntityImage( entity, fit: BoxFit.cover, width: 50, height: 52);
  }
}

class AlbumImageDefault extends StatelessWidget {
  const AlbumImageDefault({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image(fit: BoxFit.cover, width: 50, height: 52,image: AssetImage("src/imagen.png"));
  }
}