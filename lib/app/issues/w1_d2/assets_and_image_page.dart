import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class AssetsAndImagePage extends StatefulWidget {
  static const String routeName = '/assetsAndImage';
  final String title;

  static Route route({required String title}) {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => AssetsAndImagePage(title: title),
    );
  }

  const AssetsAndImagePage({Key? key, required this.title}) : super(key: key);

  @override
  State<AssetsAndImagePage> createState() => _AssetsAndImagePageState();
}

class _AssetsAndImagePageState extends State<AssetsAndImagePage> {
  final urlImage =
      "https://firebasestorage.googleapis.com/v0/b/shopfee-12b03.appspot.com/o/market.jpg?alt=media&token=3355e83a-dc01-4f0e-8a5f-79d22c28d48c";
  final cachedNetworkImage =
      "https://firebasestorage.googleapis.com/v0/b/shopfee-12b03.appspot.com/o/market_3.jpg?alt=media&token=dc06d2bb-38a6-404c-920d-e39e841bd8be";

  File? selectedImage;

  Future _pickImageFromGallery() async {
    final resultImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (resultImage != null) {
      setState(() {
        selectedImage = File(resultImage.path);
      });
    }
  }

  Future _pickImageFromCamera() async {
    final resultImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (resultImage != null) {
      setState(() {
        selectedImage = File(resultImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(fontSize: 14),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            const Text(
              "Assets Image",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Image.asset(
              "assets/images/market_2.jpg", width: 274,
              // Adjust the image size as needed
              height: 202,
            ),
            const Text(
              "Svg Image",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SvgPicture.asset(
              "assets/images/Marketplace-bro.svg", width: 274,
              // Adjust the image size as needed
              height: 202,
            ),
            const Text(
              "Url Image",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Image.network(
              urlImage,
              errorBuilder: (context, error, stackTrace) =>
                  SvgPicture.network(urlImage),
            ),
            const Text(
              "Cached Network Image",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            CachedNetworkImage(
              imageUrl: cachedNetworkImage,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            ElevatedButton.icon(
              onPressed: () {
                _pickImageFromGallery();
              },
              label: const Text("Pick Image From Gallery"),
              icon: const Icon(Icons.image),
            ),
            ElevatedButton.icon(
              onPressed: () {
                _pickImageFromCamera();
              },
              label: const Text("Pick Image From Camera"),
              icon: const Icon(Icons.camera_alt),
            ),
            selectedImage != null
                ? Image.file(selectedImage!)
                : Text("No Image Uploaded")
          ],
        ),
      ),
    );
  }
}
