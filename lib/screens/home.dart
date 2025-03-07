import 'package:flutter/material.dart';
import 'package:flutter_training/app_router/route_strings.dart';
import 'package:go_router/go_router.dart';
import '../utils/app_colors.dart';

class Home extends StatefulWidget {
  final Widget child;
  const Home({Key? key, required this.child}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        context.go(AppRouteConstants.home);
        break;
      case 1:
        context.go(AppRouteConstants.search);
        break;
      case 2:
        context.go(AppRouteConstants.checkout);
        break;
      case 3:
        context.go(AppRouteConstants.profile);
        break;
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
        backgroundColor: AppColors.whiteColor,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        iconSize: 28,
        selectedItemColor: AppColors.blackLabelColor,
        unselectedItemColor: AppColors.cartCounterButtonColor,
      ),
    );
  }
}
