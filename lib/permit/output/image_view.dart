import 'package:flutter/material.dart';

class ImageView extends StatefulWidget {
  final String image;
  const ImageView({Key? key, required this.image}) : super(key: key);

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Permit',
          style: TextStyle(
            color: Colors.blue,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.blue,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.download,
              color: Colors.blue,
            ),
          ),
        ],
      ),
      body: Card(
        margin: const EdgeInsets.all(20),
        elevation: 10,
        child: Image.asset(widget.image),
      ),
      backgroundColor: Colors.white,
    );
  }
}
