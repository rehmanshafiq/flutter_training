import 'package:flutter/material.dart';
import 'package:flutter_training/state_management/bottom_routing_provier.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomRoutingProvider>(
      builder:
      ((context, provider, child) => Scaffold(
        bottomNavigationBar: bottomNavBar(context),
        body: provider.pages[provider.pageIndex],
      )),
    );
  }

  Consumer<BottomRoutingProvider> bottomNavBar(BuildContext context) {
    return Consumer<BottomRoutingProvider>(
      builder:
      ((context, provider, child) => SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                provider.changePageIndex(0);
              },
              icon: Icon(Icons.home_filled),
            ),

            IconButton(
              onPressed: () {
                provider.changePageIndex(1);
              },
              icon: Icon(Icons.search),
            ),

            IconButton(
              onPressed: () {
                provider.changePageIndex(2);
              },
              icon: Icon(Icons.shopping_bag_outlined),
            ),

            IconButton(
              onPressed: () {
                provider.changePageIndex(3);
              },
              icon: Icon(Icons.person),
            ),
          ],
        ),
      )),
    );
  }
}
