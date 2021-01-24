import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class ImageComponent extends StatefulWidget {
  ImageComponent({this.imageControler});
  TextEditingController imageControler = TextEditingController();

  @override
  _ImageComponentState createState() => _ImageComponentState();
}

class _ImageComponentState extends State<ImageComponent> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        children: [
          Container(
            width: 190,
            height: 190,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: widget.imageControler.text.toString() == "image/people.png" || widget.imageControler.text == ''
                ? AssetImage("image/people.png")
                : FileImage(File(widget.imageControler.text.toString())),
              ),
            ),
          ),
          SizedBox(height: 15),
          Text(
            "Tirar Foto",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      onTap: () async {
        final picker = ImagePicker();
        await picker.getImage(source: ImageSource.camera).then((file) {
          if (file == null) {
            return;
          } else {
            setState(() {
              widget.imageControler.text = file.path;
            });
          }
        });
      },
    );
  }
}
