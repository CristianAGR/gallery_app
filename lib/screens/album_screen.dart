import 'package:flutter/material.dart';
import 'package:gallery_app/widgets/image_widget.dart';
import 'package:photo_manager/photo_manager.dart';

class AlbumScreen extends StatefulWidget {
   
  const AlbumScreen({Key? key}) : super(key: key);
  

  @override
  State<AlbumScreen> createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> {

/// Customize your own filter options.
  final FilterOptionGroup _filterOptionGroup = FilterOptionGroup(
    imageOption: const FilterOption(
      sizeConstraint: SizeConstraint(ignoreSize: true),
    ),
  );
  final int _sizePerPage = 50;

  AssetPathEntity? _path;
  AssetPathEntity? path;
  List<AssetEntity>? _entities;
  int _totalEntitiesCount = 0;

  int _page = 0;
  bool _isLoading = false;
  bool _isLoadingMore = false;
  bool _hasMoreToLoad = true;

    // gets assets
  Future<void> _requestAssets() async {

    path = ModalRoute.of(context)!.settings.arguments as AssetPathEntity;
    setState(() {
      _isLoading = true;
    });
    print("Cargando: $_isLoading" );
    if (!mounted) {
      return;
    }

    setState(() {
      _path = path;
    });
    _totalEntitiesCount = await _path!.assetCountAsync;
    print("Paths encontrados: $_totalEntitiesCount");
    final List<AssetEntity> entities = await _path!.getAssetListPaged(
      page: 0,
      size: _sizePerPage,
    );
    if (!mounted) {
      return;
    }
    setState(() {
      _entities = entities;
      _isLoading = false;
      _hasMoreToLoad = _entities!.length < _totalEntitiesCount;
    });
  }



    Widget _buildBody(BuildContext context) {
    //services.assetVerification(_isLoading, _path, _entities);
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator.adaptive());
    }
    if (_path == null) {
      return const Center(child: Text('Request paths first.'));
    }
    if (_entities?.isNotEmpty != true) {
      return const Center(child: Text('No assets found on this device.'));
    }
    

    // builds the gridView of images with the found entities
    return GridView.builder(
                padding: const EdgeInsets.only(right: 50),
                shrinkWrap: false,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 0.85),
                itemCount: _totalEntitiesCount,
                itemBuilder: (_, int index) => ImageWidget(
                  entity: _entities![index],
                  option: const ThumbnailOption(size: ThumbnailSize.square(200)),
                  //image: "https://cdn.pixabay.com/photo/2012/08/27/14/19/mountains-55067__340.png",
                  ));
                  
  }

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }

  @override
void didChangeDependencies() {
  super.didChangeDependencies();
  // recibes the path from the arguments
  _requestAssets();
}
  @override
  Widget build(BuildContext context) {
            
   // receives the path from the arguments
    //_requestAssets(path);
    
    //final String album = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black,)),
            Text("${_path!.name}", style: TextStyle(color: Colors.black),)
            ],
        ),
        backgroundColor: const Color.fromARGB(0, 53, 51, 51),
        shadowColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Column(
           children: [Expanded(
              child: _buildBody(context)
            ),
            ]
        ),
      ),
    );
  }
}