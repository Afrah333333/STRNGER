import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multiple_images_picker/multiple_images_picker.dart';

import '../widgets/dart/burn_widget.dart';


class MultipleImageSelector extends StatefulWidget {
  const MultipleImageSelector({super.key});

  @override
  State<MultipleImageSelector> createState() => _MultipleImageSelectorState();
}

class _MultipleImageSelectorState extends State<MultipleImageSelector> {
  List<Asset> images = <Asset>[];
  String _error = 'No Error Dectected';
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    // display image selected from gallery
    return Scaffold(
      appBar: AppBar(
        title: const Text('Multiple Images Select'),
        backgroundColor: Colors.deepPurple.shade200,

      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Colors.deepPurple.shade200)),
              child: const Text('Select Image from Gallery and Camera'),
              onPressed: () {
                getImages();
              },
            ),
            Expanded(
              child: SizedBox(
                  width: 300.0,
                  child: images.isEmpty
                      ? const Center(child: Text('Sorry nothing selected!!'))
                      : GridView.count(
                    crossAxisCount: 3,
                    children: List.generate(images.length, (index) {
                      Asset asset = images[index];
                      return Stack(
                        children: [
                          AssetThumb(
                            asset: asset,
                            width: 300,
                            height: 300,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: IconButton(
                              icon: Icon(
                                  Icons.delete,
                              color: Colors.red.shade900,),
                              onPressed: () {
                                int indexToDelete = index;
                                deleteImageWithBurningEffect(indexToDelete);
                              },
                            ),
                          ),
                        ],
                      );
                    }),
                  )



              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getImages() async {
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';

    try {
      resultList = await MultipleImagesPicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Example App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    if (!mounted) return;

    setState(() {
      images = resultList;
      // _error = error;
    });
  }

  void deleteImage(int index) {
    setState(() {
      images.removeAt(index);
    });
  }

  Future<void> deleteImageWithBurningEffect(int index) async {
    // Simulate the burning animation
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => BurningEffect(text: "Burning..."),
      ),
    );

    await Future.delayed(Duration(seconds: 5)); // Adjust the delay as needed.

    // Perform the actual deletion here
    deleteImage(index); // Call your deleteImage function here

    // Close the burning screen
    Navigator.of(context).pop();
  }

}


