import 'package:e_commerce/models/home_carousel_item_model.dart';
import 'package:e_commerce/models/product_item_model.dart';
import 'package:e_commerce/utils/app_colors.dart';
import 'package:e_commerce/view_models/home_cubit/home_cubit.dart';
import 'package:e_commerce/views/widgets/category_tab_view.dart';
import 'package:e_commerce/views/widgets/home_tab_view.dart';
import 'package:e_commerce/views/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController _tabController;

  initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = HomeCubit();
        cubit.getHomeData();
        return cubit;
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage(
                            'https://tse3.mm.bing.net/th/id/OIP.xGAXVKjGAk2ITkuZTlJbKgHaLH?rs=1&pid=ImgDetMain&o=7&rm=3',
                          ),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hi Sarah",
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            Text(
                              "Lets go shopping",
                              style: Theme.of(context).textTheme.labelSmall!
                                  .copyWith(color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        IconButton(onPressed: () {}, icon: Icon(Icons.search)),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.notifications),
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: 20),

                TabBar(
                  controller: _tabController,
                  unselectedLabelColor: AppColors.grey,
                  tabs: [
                    Tab(child: Text("Home")),
                    Tab(child: Text("Category")),
                  ],
                ),

                SizedBox(height: 20),

                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: const [HomeTabView(), CategoryTabView()],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
