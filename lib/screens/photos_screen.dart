import 'package:flutter/material.dart';
import 'package:gallery_app/providers/images_services.dart';
import 'package:gallery_app/widgets/image_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';

class PhotosScreen extends StatefulWidget {
   
  const PhotosScreen({Key? key}) : super(key: key);

  @override
  State<PhotosScreen> createState() => _PhotosScreenState();
}

class _PhotosScreenState extends State<PhotosScreen> {

  var services = ImagesServices();

  
  /// Customize your own filter options.
  final FilterOptionGroup _filterOptionGroup = FilterOptionGroup(
    imageOption: const FilterOption(
      sizeConstraint: SizeConstraint(ignoreSize: true),
    ),
  );
  final int _sizePerPage = 50;

  AssetPathEntity? _path;
  List<AssetEntity>? _entities;
  int _totalEntitiesCount = 0;

  int _page = 0;
  bool _isLoading = false;
  bool _isLoadingMore = false;
  bool _hasMoreToLoad = true;


  // gets assets
  Future<void> _requestAssets() async {
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
      onlyAll: true,
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
    setState(() {
      _path = paths.first;
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

  Future<void> _loadMoreAsset() async {
    final List<AssetEntity> entities = await _path!.getAssetListPaged(
      page: _page + 1,
      size: _sizePerPage,
    );
    if (!mounted) {
      return;
    }
    setState(() {
      _entities!.addAll(entities);
      _page++;
      _hasMoreToLoad = _entities!.length < _totalEntitiesCount;
      _isLoadingMore = false;
    });
  }

  // builds the response of device paths
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
    

    //final AssetEntity entity = _entities![index];
    // builds the gridView of images with the found entities
    return GridView.builder(
                padding: const EdgeInsets.only(right: 50),
                shrinkWrap: false,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 0.85),
                itemCount: _totalEntitiesCount,
                itemBuilder: (_, int index) => ImageWidget(
                  path: _path!,
                  entity: _entities![index],
                  option: const ThumbnailOption(size: ThumbnailSize.square(200)),
                  //image: "https://cdn.pixabay.com/photo/2012/08/27/14/19/mountains-55067__340.png",
                  ));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _requestAssets();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Photos", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                IconButton(onPressed: options, icon: const Icon(Icons.menu), padding: const EdgeInsets.only(left: 20),),
              ],
            ),
            Expanded(
              child: _buildBody(context)
            ),
            FloatingActionButton(onPressed: () => services.takePhoto(context), child: const Icon(Icons.camera_alt),)
          ],
        ),
      )
    );
  }

  void options() {
  }
  
}
