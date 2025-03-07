import 'package:flutter/material.dart';
import 'package:flutter_training/screens/profile_screen.dart';
import 'package:flutter_training/widgets/text_widget.dart';
import '../utils/app_colors.dart';
import '../utils/app_strings.dart';
import '../widgets/card_interior.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
   int _currentIndex = 0;

  final List<Widget> _screens = [
    CardInterior(), // Your first screen with "Designer Near You"
    Center(child: MyText(AppStrings.searchScreen, style: TextStyle(fontSize: 24))),
    Center(child: MyText(AppStrings.checkoutScreen, style: TextStyle(fontSize: 24))),
    ProfileScreen(),
  ];

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       body: _screens[_currentIndex], // Display selected screen
       bottomNavigationBar: BottomNavigationBar(
         currentIndex: _currentIndex,
         onTap: (index) {
           setState(() {
             _currentIndex = index;
           });
         },
         items: const [
           BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
           BottomNavigationBarItem(icon: Icon(Icons.search), label: ""),
           BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: ""),
           BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
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
