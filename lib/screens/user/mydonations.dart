import 'package:com/models/donation.dart';
import 'package:com/models/user.dart';
import 'package:com/services/donationsdatabase.dart';
import 'package:com/widgets/user/mydonationslist.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyDonations extends StatelessWidget {
  final User user;
  MyDonations(this.user);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Donation>>.value(
      value: DonationDatabaseService(uid: user.uid).mydonations,
      child: Scaffold(
        appBar: AppBar(
          title: Text('My Donations'),
        ),
        //body: CollapsingList(),
        body: MyDonationList(),
      ),
    );
  }
}
/*
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });
  final double minHeight;
  final double maxHeight;
  final Widget child;
  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => math.max(maxHeight, minHeight);
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

class CollapsingList extends StatelessWidget {
  SliverPersistentHeader makeHeader(String headerText) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverAppBarDelegate(
        minHeight: 60.0,
        maxHeight: 60.0,
        child: Container(
            color: Colors.white,
            child: Center(
                child: Text(
              headerText,
              style: TextStyle(fontSize: 18),
            ))),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        makeHeader('Active'),
        Activel(),
        makeHeader('Pending'),
        SliverFixedExtentList(
          itemExtent: 80.0,
          delegate: SliverChildListDelegate(
            [
              Container(color: Colors.red),
              Container(color: Colors.purple),
              Container(color: Colors.green),
              Container(color: Colors.orange),
              Container(color: Colors.yellow),
            ],
          ),
        ),
        makeHeader('Inactive'),
        SliverFixedExtentList(
          itemExtent: 80.0,
          delegate: SliverChildListDelegate(
            [
              Container(color: Colors.red),
              Container(color: Colors.purple),
              Container(color: Colors.green),
              Container(color: Colors.orange),
              Container(color: Colors.yellow),
            ],
          ),
        ),
      ],
    );
  }
}

class Activel extends StatelessWidget {
  const Activel({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverFixedExtentList(
      itemExtent: 80.0,
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          // To convert this infinite list to a list with three items,
          // uncomment the following line:
          // if (index > 3) return null;
          return Container(color: Colors.grey, height: 80.0);
        },
        // Or, uncomment the following line:
        childCount: 3,
      ),
    );
  }
}
*/