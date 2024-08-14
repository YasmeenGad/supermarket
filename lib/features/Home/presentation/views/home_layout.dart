import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supermarket/core/constants/app_colors.dart';
import 'package:supermarket/features/Home/presentation/widgets/home_widget.dart';
import 'package:supermarket/features/cart/presentation/views/cart_view.dart';
import 'package:supermarket/features/explore/presentation/views/all_categories_view.dart';
import 'package:supermarket/features/favorite/presentation/views/fav_view.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key, required this.userName});
  final String userName;

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout>
    with SingleTickerProviderStateMixin {
  int selectedIndex = 0;
  late List<Widget> widgetOptions;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    widgetOptions = <Widget>[
      HomeWidget(userName: widget.userName),
      AllCategoriesView(),
      CartView(),
      FavView(),
      Container(),
    ];
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
      _controller.forward(from: 0.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgetOptions.elementAt(selectedIndex),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 3,
              blurRadius: 10,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          child: BottomNavigationBar(
            elevation: 2,
            type: BottomNavigationBarType.fixed,
            iconSize: 18,
            backgroundColor: Colors.white,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: AnimatedIconItem(
                  icon: Icons.shopping_bag,
                  selectedIndex: selectedIndex,
                  itemIndex: 0,
                  animationController: _controller,
                ),
                label: 'Shop',
              ),
              BottomNavigationBarItem(
                icon: AnimatedIconItem(
                  icon: CupertinoIcons.search,
                  selectedIndex: selectedIndex,
                  itemIndex: 1,
                  animationController: _controller,
                ),
                label: 'Explore',
              ),
              BottomNavigationBarItem(
                icon: AnimatedIconItem(
                  icon: CupertinoIcons.shopping_cart,
                  selectedIndex: selectedIndex,
                  itemIndex: 2,
                  animationController: _controller,
                ),
                label: 'Cart',
              ),
              BottomNavigationBarItem(
                icon: AnimatedIconItem(
                  icon: CupertinoIcons.heart,
                  selectedIndex: selectedIndex,
                  itemIndex: 3,
                  animationController: _controller,
                ),
                label: 'Favorite',
              ),
              BottomNavigationBarItem(
                icon: AnimatedIconItem(
                  icon: CupertinoIcons.person,
                  selectedIndex: selectedIndex,
                  itemIndex: 4,
                  animationController: _controller,
                ),
                label: 'Account',
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class AnimatedIconItem extends StatelessWidget {
  const AnimatedIconItem({
    Key? key,
    required this.icon,
    required this.selectedIndex,
    required this.itemIndex,
    required this.animationController,
  }) : super(key: key);

  final IconData icon;
  final int selectedIndex;
  final int itemIndex;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: Tween(begin: 0.8, end: 1.2).animate(CurvedAnimation(
          parent: animationController, curve: Curves.easeInOut)),
      child: Icon(
        icon,
        color: selectedIndex == itemIndex ? primaryColor : blackColor,
      ),
    );
  }
}
