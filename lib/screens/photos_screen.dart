import 'package:flutter/material.dart';
import 'package:gallery_app/widgets/image_widget.dart';

class PhotosScreen extends StatelessWidget {
   
  const PhotosScreen({Key? key}) : super(key: key);
  
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
                IconButton(onPressed: options, icon: const Icon(Icons.menu), padding: EdgeInsets.only(left: 20),),
              ],
            ),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.only(right: 50),
                shrinkWrap: false,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 0.85),
                itemCount: 20,
                itemBuilder: (_, int index) => ImageWidget(image: "https://cdn.pixabay.com/photo/2012/08/27/14/19/mountains-55067__340.png",))
              // ListView.builder(
              //   scrollDirection: Axis.vertical,
              //   itemCount: 8,
              //   itemBuilder: (_, int index) => RowImages()
              //   ),
            ),
            FloatingActionButton(onPressed: addPhoto, child: Icon(Icons.camera_alt),)
          ],
        ),
      )
    );
  }

  void options() {
  }

  void addPhoto() {
  }
  
}
