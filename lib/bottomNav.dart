import 'package:flutter/material.dart';

import 'favouritesList.dart';
import 'listproducts.dart';

class BottomNavigationInterface extends StatefulWidget {
  @override
  _BottomNavigationInterfaceState createState() =>
      _BottomNavigationInterfaceState();
}

class _BottomNavigationInterfaceState extends State<BottomNavigationInterface> {
  int _uiIndex = 0;
  List<Widget> interfaces = [CarsList(),ProductsFavoriteList()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Menus with bottom nav"),
         actions: <Widget>[
    IconButton(
      icon: Icon(
        Icons.logout,
        color: Colors.white,
      ),
      onPressed: () {
       Navigator.pushReplacementNamed(context, "/signin");
      },
    )
  ],
      ),
      // drawer: Drawer(
      //   child: Column(
      //     children: [
      //       AppBar(
      //         automaticallyImplyLeading: false,
      //         title: Text("Choose an option"),
      //       ),
      //       ListTile(
      //         title: Text("Go to tab navigation"),
      //         onTap: () {
      //           Navigator.pushReplacementNamed(context, "/");
      //         },
      //       )
      //     ],
      //   ),
      // ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.list), title: Text("List ")),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border), title: Text(" Favourites"))
        ],
        currentIndex: _uiIndex,
        onTap: (int value) {
          setState(() {
            _uiIndex = value;
          });
        },
      ),
      body: interfaces[_uiIndex],
    );
  }
}
