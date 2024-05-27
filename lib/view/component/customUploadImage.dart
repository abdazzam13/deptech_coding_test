import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Event/controller/EventController.dart';

class customUploadImage extends StatelessWidget {
  const customUploadImage({
    super.key,
    required this.controller,
  });

  final EventController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () {
            controller.takePictureWithCamera();
          },
          child: Text("Camera"),
        ),
        ElevatedButton(
          onPressed: () {
            controller.pickImageFromGallery();
          },
          child: Text("Gallery"),
        ),
      ],
    );
  }
}