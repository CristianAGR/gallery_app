import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class AlbumWidget extends StatefulWidget {
  const AlbumWidget({super.key, required this.albumPath});

  final AssetPathEntity albumPath;

  @override
  State<AlbumWidget> createState() => _AlbumWidgetState();
}

class _AlbumWidgetState extends State<AlbumWidget> {
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
      //itemsCount = await widget.albumPath.assetCountAsync;
      itemsCount = await _path!.assetCountAsync;
      setState(() {
        
      });

      final List<AssetEntity> entities = await _path!.getAssetListPaged(
       page: 0,
       size: _sizePerPage,
     );
     _entities = entities;
      
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
    const album = "https://cdn.pixabay.com/photo/2023/01/05/22/35/flower-7700011_640.jpg";
    
    
    
    return Container(
      margin: const EdgeInsets.only(left: 10, bottom: 10),
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, 'album', arguments: _path),
        child: Column(
          children: [
            Text("${widget.albumPath.name}", textAlign: TextAlign.start, style: TextStyle(fontWeight: FontWeight.bold),),
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
            Text("$itemsCount items", textAlign: TextAlign.start,),
          ],
        ),
      ),
    );
  }
}