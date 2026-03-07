import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/utils/app_colors.dart';
import 'package:e_commerce/view_models/cart_cubit/cart_cubit.dart';
import 'package:e_commerce/view_models/home_cubit/home_cubit.dart';
import 'package:e_commerce/views/pages/cart_page.dart';
import 'package:e_commerce/views/pages/favourite_page.dart';
import 'package:e_commerce/views/pages/home_page.dart';
import 'package:e_commerce/views/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class CustomBottomNavbar extends StatefulWidget {
  const CustomBottomNavbar({super.key});

  @override
  State<CustomBottomNavbar> createState() => _CustomBottomNavbarState();
}

class _CustomBottomNavbarState extends State<CustomBottomNavbar> {
  late final PersistentTabController _controller;
  int currentIndex = 0;
  List<PersistentTabConfig> persistentTabs = [
    PersistentTabConfig(
      screen: HomePage(),
      item: ItemConfig(
        icon: Icon(Icons.home),
        title: "Home",
        activeForegroundColor: AppColors.primaryColor,
      ),
    ),
    PersistentTabConfig(
      screen: CartPage(),
      item: ItemConfig(
        icon: Icon(Icons.shopping_cart),
        title: "Cart",
        activeForegroundColor: AppColors.primaryColor,
      ),
    ),
    PersistentTabConfig(
      screen: FavouritePage(),
      item: ItemConfig(
        icon: Icon(Icons.favorite),
        title: "Favourites",
        activeForegroundColor: AppColors.primaryColor,
      ),
    ),
    PersistentTabConfig(
      screen: ProfilePage(),
      item: ItemConfig(
        icon: Icon(Icons.person),
        title: "Profile",
        activeForegroundColor: AppColors.primaryColor,
      ),
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
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(4.0),
          child: CircleAvatar(
            radius: 25,
            backgroundImage: CachedNetworkImageProvider(
              'https://tse3.mm.bing.net/th/id/OIP.xGAXVKjGAk2ITkuZTlJbKgHaLH?rs=1&pid=ImgDetMain&o=7&rm=3',
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Hi Sarah", style: Theme.of(context).textTheme.labelLarge),
            Text(
              "Lets go shopping",
              style: Theme.of(
                context,
              ).textTheme.labelSmall!.copyWith(color: AppColors.grey),
            ),
          ],
        ),

        actions: [
          if (currentIndex == 0) ...[
            Row(
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.search)),
                IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
              ],
            ),
          ] else if (currentIndex == 1) ...[
            IconButton(onPressed: () {}, icon: Icon(Icons.shopping_bag)),
          ],
        ],
      ),
      body: PersistentTabView(
        onTabChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        stateManagement: false,
        tabs: persistentTabs,
        controller: _controller,
        navBarBuilder: (navBarConfig) => Style6BottomNavBar(
          navBarConfig: navBarConfig,
          navBarDecoration: NavBarDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
          ),
          itemAnimationProperties: ItemAnimation(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
          ),
        ),
      ),
    );
  }
}
