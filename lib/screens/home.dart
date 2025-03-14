import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../screens/checkout_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/search_screen.dart';
import '../state_management/bottom_routing_cubit.dart';
import '../widgets/card_interior.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomRoutingCubit(),
      child: Scaffold(
        bottomNavigationBar: bottomNavBar(context),
        body: BlocBuilder<BottomRoutingCubit, int>(
          builder: (context, pageIndex) {
            final pages = [
              CardInterior(),
              SearchScreen(),
              CheckoutScreen(),
              ProfileScreen(),
            ];
            return pages[pageIndex];
          },
        ),
      ),
    );
  }

  Widget bottomNavBar(BuildContext context) {
    return BlocBuilder<BottomRoutingCubit, int>(
      builder: (context, pageIndex) {
        return BottomNavigationBar(
          backgroundColor: Colors.white,
          currentIndex: pageIndex,
          onTap: (index) {
            context.read<BottomRoutingCubit>().changePageIndex(index);
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_outlined),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: '',
            ),
          ],
        );
      },
    );
  }
}