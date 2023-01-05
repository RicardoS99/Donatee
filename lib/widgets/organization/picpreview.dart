import 'package:com/models/donation.dart';
import 'package:com/widgets/organization/picfullscreen.dart';
import 'package:flutter/material.dart';

class PicPreview extends StatelessWidget {
  final Donation donation;
  PicPreview(this.donation);

  @override
  Widget build(BuildContext context) {
    if (this.donation.nPhotos == 0) {
      return Container();
    } else {
      var thumbnails = new List<Widget>();

      for (var pic in this.donation.pics) {
        thumbnails.add(ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: GestureDetector(
            onTap: () {
              Route route = MaterialPageRoute(
                  builder: (context) => PicFullScreen(pic));
              Navigator.push(context, route);
            },
            child: Image.file(
              pic,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.width * 0.3,
            ),
          ),
        ));
      }
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: thumbnails,
      );
    }
  }
}
