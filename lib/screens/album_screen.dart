import 'package:flutter/material.dart';
import 'package:gallery_app/widgets/image_widget.dart';

class AlbumScreen extends StatelessWidget {
   
  const AlbumScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final String album = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black,)),
            const Text("Album Prueba", style: TextStyle(color: Colors.black),)
            ],
        ),
        backgroundColor: Color.fromARGB(0, 53, 51, 51),
        shadowColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Center(
           child: GridView.builder(
                  padding: EdgeInsets.only(left: 0, right: 10),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                  itemCount: 40,
                  itemBuilder: (_, int index) => ImageWidget(image: album))
        ),
      ),
    );
  }
}