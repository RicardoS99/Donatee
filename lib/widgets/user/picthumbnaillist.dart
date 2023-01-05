import 'package:com/widgets/user/picthumbnail.dart';
import 'package:flutter/material.dart';

class PicThumbnailList extends StatelessWidget {
  final int nPhotos;
  final List photos;
  final Function deletePic;
  final bool deleteOption;
  PicThumbnailList(this.nPhotos, this.photos, this.deletePic, this.deleteOption);

  @override
  Widget build(BuildContext context) {
    if (nPhotos == 0) {
      return Container();
    } else {
      var pics = new List<Widget>();
      for (var pic in photos) {
        pics.add(PicThumbnail(pic, deletePic, deleteOption));
        pics.add(SizedBox(width: 5.0,));
      }
      return Row(
        children: pics,
      );
    }
  }
}
