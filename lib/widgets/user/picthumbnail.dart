import 'dart:io';
import 'package:flutter/material.dart';

class PicThumbnail extends StatelessWidget {
  final File pic;
  final Function deletePic;
  final bool deleteOption;
  PicThumbnail(this.pic, this.deletePic, this.deleteOption);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: Image.file(
              pic,
              fit: BoxFit.cover,
              width: 40,
              height: 40,
            ),
          ),
        ),
        deleteOption ? Container(
          width: 50,
          alignment: Alignment.topRight,
          child: Container(
            width: 20,
            height: 20,
            child: FittedBox(
              child: FloatingActionButton(
                heroTag: pic.path,
                child: Icon(
                  Icons.delete,
                  size: 40,
                  color: Colors.grey[600],
                ),
                backgroundColor: Colors.white,
                onPressed: () => deletePic(pic.path),
              ),
            ),
          ),
        ) : Container(),
      ],
    );
  }
}
