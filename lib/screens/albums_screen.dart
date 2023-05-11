import 'package:flutter/material.dart';
import 'package:gallery_app/widgets/album_widget.dart';
import 'package:photo_manager/photo_manager.dart';

class AlbumsScreen extends StatefulWidget {
   
  const AlbumsScreen({Key? key}) : super(key: key);

  @override
  State<AlbumsScreen> createState() => _AlbumsScreenState();
}

class _AlbumsScreenState extends State<AlbumsScreen> {

/// Customize your own filter options.
  final FilterOptionGroup _filterOptionGroup = FilterOptionGroup(
    imageOption: const FilterOption(
      sizeConstraint: SizeConstraint(ignoreSize: true),
    ),
  );

  List<AssetPathEntity>? paths;
  List<AssetPathEntity>? _paths;

  bool _isLoading = false;

    // gets assets
  Future<void> _requestPaths() async {
    setState(() {
      _isLoading = true;
    });
    // Request permissions.
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    if (!mounted) {
      return;
    }
    // Further requests can be only proceed with authorized or limited.
    if (!ps.hasAccess) {
      setState(() {
        _isLoading = false;
      });
      //showToast('Permission is not accessible.');
      print('Permission is not accessible.');
      return;
    }
    print("Cargando: $_isLoading" );
    // Obtain assets using the path entity.

    final List<AssetPathEntity> paths = await PhotoManager.getAssetPathList(
      // onlyAll returns only the album/path with all the assets
      onlyAll: false,
      filterOption: _filterOptionGroup,
    );
    if (!mounted) {
      return;
    }
    // Return if not paths found.
    if (paths.isEmpty) {
      setState(() {
        _isLoading = false;
      });
      //showToast('No paths found.');
      print('No paths found.');
      return;
    }
    // changes the state of the received paths
    setState(() {
      _paths = paths;
    });
    print("Paths encontrados: ${paths.length}");
    if (!mounted) {
      return;
    }
    setState(() {
      _isLoading = false;
    });
  }

    //widget that displays the album list
    Widget _buildAlbums(BuildContext context) {
    //services.assetVerification(_isLoading, _path, _entities);
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator.adaptive());
    }
    // if (_path == null) {
    //   return const Center(child: Text('Request paths first.'));
    // }
    // if (_entities?.isNotEmpty != true) {
    //   return const Center(child: Text('No assets found on this device.'));
    // }

    if (_paths?.isNotEmpty != true) {
       return const Center(child: Text('No paths found on this device.'));
     }
    

    //final AssetEntity entity = _entities![index];
    // builds the gridView of albums with the found paths
    return GridView.builder(
                padding: const EdgeInsets.only(right: 50, bottom: 12),
                shrinkWrap: false,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 0.5),
                itemCount: _paths!.length,
                itemBuilder: (_,  int index) => AlbumWidget(
                  albumPath: _paths![index],
                  //image: "https://cdn.pixabay.com/photo/2012/08/27/14/19/mountains-55067__340.png",
                  ));
  }

  @override
  void initState() {
    super.initState();
    _requestPaths();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Albums", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
          IconButton(onPressed: addAlbum, icon: const Icon(Icons.post_add_rounded), alignment: Alignment.topRight,),
            ],
          ),
          Expanded(
            child: _buildAlbums(context)
            )
        ],
      )
    );
  }

  void addAlbum() {
  }
}