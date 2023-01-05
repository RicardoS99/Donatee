import 'package:com/models/orginfo.dart';
import 'package:flutter/material.dart';

class OrgInfoPageHeader extends StatelessWidget implements PreferredSizeWidget {
  final double height = 220;
  final OrgInfo orgInfo;
  OrgInfoPageHeader(this.orgInfo);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        orgInfo.logoUrl != ""
            ? Container(
                height: height - 40,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(orgInfo.logoUrl),
                        fit: BoxFit.cover)),
              )
            : Container(
                height: height - 40,
                color: Colors.cyan[300],
              ), //Header Background -> Organization Logo
        Container(
          height: height,
          decoration: BoxDecoration(
              color: Colors.white,
              gradient: LinearGradient(
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  colors: [
                    Colors.white.withOpacity(0.0),
                    Colors.white,
                  ],
                  stops: [
                    0.5,
                    0.8
                  ])), // Gradient that fades out Organization Logo
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 40.0, 0.0, 0.0),
                child: Row(children: [
                  CircleButton(
                    onTap: () => Navigator.pop(context),
                    iconData: Icons.arrow_back,
                  )
                ]),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 40.0,
                    width: 0.8 *
                        MediaQuery.of(context)
                            .size
                            .width, //Gets screensize width
                    child: Material(
                      borderRadius: BorderRadius.circular(20.0),
                      elevation: 4.0,
                      color: Colors.cyan[800],
                      child: Container(
                        width: 0.8 *
                        MediaQuery.of(context)
                            .size
                            .width,
                            padding: EdgeInsets.symmetric(horizontal:15),
                        child: Center(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(orgInfo.name,
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 30.0,
                                    color: Colors.white)), //Organization Name
                          ),
                        ),
                      ),
                    ),
                  ), // Rounded Box for Organization Name
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

//Custom Return Button
class CircleButton extends StatelessWidget {
  final GestureTapCallback onTap;
  final IconData iconData;

  const CircleButton({Key key, this.onTap, this.iconData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double size = 40.0;

    return new InkResponse(
      onTap: onTap,
      child: new Container(
        width: size,
        height: size,
        decoration: new BoxDecoration(
          color: Colors.cyan[800],
          shape: BoxShape.circle,
        ),
        child: new Icon(
          iconData,
          color: Colors.white,
        ),
      ),
    );
  }
}
