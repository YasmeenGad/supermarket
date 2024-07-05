import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supermarket/core/constants/app_colors.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {

  int selectedIndex = 0;
  final List<Widget> widgetOptions = <Widget>[
    Container(),
    Container(),
    Container(),
    Container(),
    Container(),
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgetOptions.elementAt(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag,size: 30,),
            label: 'Shop',
            
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search,size: 30,),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.cart,size: 30,),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline_outlined,size: 30,),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_3_outlined,size: 30,),
            label: 'Account',
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: primaryColor,
        unselectedItemColor: blackColor,
        onTap: onItemTapped,
      ),
    );
  }
}