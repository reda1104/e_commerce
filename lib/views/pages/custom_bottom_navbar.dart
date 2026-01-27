import 'package:e_commerce/views/pages/cart_page.dart';
import 'package:e_commerce/views/pages/favourite_page.dart';
import 'package:e_commerce/views/pages/home_page.dart';
import 'package:e_commerce/views/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class CustomBottomNavbar extends StatefulWidget {
  const CustomBottomNavbar({super.key});

  @override
  State<CustomBottomNavbar> createState() => _CustomBottomNavbarState();
}

class _CustomBottomNavbarState extends State<CustomBottomNavbar> {
  late final PersistentTabController _controller;
  List<PersistentTabConfig> persistentTabs = [
    PersistentTabConfig(
      screen: HomePage(),
      item: ItemConfig(icon: Icon(Icons.home), title: "Home"),
    ),
    PersistentTabConfig(
      screen: CartPage(),
      item: ItemConfig(icon: Icon(Icons.shopping_cart), title: "Orders"),
    ),
    PersistentTabConfig(
      screen: FavouritePage(),
      item: ItemConfig(icon: Icon(Icons.favorite), title: "Favourites"),
    ),
    PersistentTabConfig(
      screen: ProfilePage(),
      item: ItemConfig(icon: Icon(Icons.person), title: "Profile"),
    ),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = PersistentTabController();
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      tabs: persistentTabs,
      controller: _controller,
      navBarBuilder: (navBarConfig) => Style6BottomNavBar(
        navBarConfig: navBarConfig,
        navBarDecoration: NavBarDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
        ),
        itemAnimationProperties: ItemAnimation(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        ),
      ),
    );
  }
}
