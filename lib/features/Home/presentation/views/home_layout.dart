import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supermarket/core/constants/app_colors.dart';
import 'package:supermarket/features/Home/presentation/widgets/home_widget.dart';
import 'package:supermarket/features/cart/presentation/views/cart_view.dart';
import 'package:supermarket/features/explore/presentation/views/all_categories_view.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key, required this.userName});
  final String userName;

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int selectedIndex = 0;
late List<Widget> widgetOptions;

  @override
  void initState() {
    super.initState();
    widgetOptions = <Widget>[
      HomeWidget(userName: widget.userName),
      AllCategoriesView(),
      CartView(),
      Container(),
      Container(),
    ];
  }


  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgetOptions.elementAt(selectedIndex),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          child: BottomNavigationBar(
            elevation: 2,
            type: BottomNavigationBarType.fixed,
            // showSelectedLabels: true,
            iconSize: 24,
            backgroundColor: Colors.white,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_bag),
                label: 'Shop',
                backgroundColor: Colors.white,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Explore',
                backgroundColor: Colors.white,
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.cart),
                label: 'Cart',
                backgroundColor: Colors.white,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_outline_outlined),
                label: 'Favorite',
                backgroundColor: Colors.white,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_3_outlined),
                label: 'Account',
                backgroundColor: Colors.white,
              ),
            ],
            currentIndex: selectedIndex,
            selectedItemColor: primaryColor,
            unselectedItemColor: blackColor,
            onTap: onItemTapped,
          ),
        ),
      ),
    );
  }
}
