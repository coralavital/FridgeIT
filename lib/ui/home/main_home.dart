// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/services.dart';
import 'package:fridge_it/ui/home/shopping_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fridge_it/theme/theme_colors.dart';
import 'package:fridge_it/ui/home/home.dart';
import 'package:fridge_it/ui/home/products_list.dart';
import 'package:fridge_it/ui/home/account.dart';
import 'package:fridge_it/utils/dimensions.dart';

import '../../services/firebase_message.dart';

class MainHome extends StatefulWidget {
  const MainHome({super.key});

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  FMessaging messaging = FMessaging();
  int currentPage = 0;
  final List _pages = [
    HomePage(),
    ProductsList(),
    ShoppingList(),
    ProfilePage(),
  ];
  void tappedPage(int index) {
    setState(() {
      currentPage = index;
    });
  }

  @override
  void initState() {
    super.initState();
    messaging.requestPermission();
    messaging.getToken();
    messaging.initInfo();
    messaging.getChanges();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            // Status bar color
            systemNavigationBarColor: ThemeColors().background,
            statusBarColor: ThemeColors().background,
          ),
          toolbarHeight: Dimensions.size20,
          backgroundColor: ThemeColors().background),
      backgroundColor: ThemeColors().background,
      body: _pages[currentPage],
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          left: Dimensions.size15,
          right: Dimensions.size15,
          bottom: Dimensions.size20,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(Dimensions.size20),
          child: BottomNavigationBar(
              showSelectedLabels: false,
              showUnselectedLabels: false,
              backgroundColor: ThemeColors().light2,
              currentIndex: currentPage,  
              type: BottomNavigationBarType.fixed,
              onTap: tappedPage,
              items: [
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icons/home.svg',
                    color: ThemeColors().light1,
                    fit: BoxFit.none,
                  ),
                  activeIcon: SvgPicture.asset(
                    'assets/icons/home_active.svg',
                    color: ThemeColors().main,
                    fit: BoxFit.none,
                  ),
                  label: 'H',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.view_list_rounded,
                    color: ThemeColors().light1,
                  ),
                  activeIcon: Icon(
                    Icons.notifications_rounded,
                    color: ThemeColors().main,
                  ),
                  label: 'N',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.history_sharp,
                    color: ThemeColors().light1,
                  ),
                  activeIcon: Icon(
                    Icons.history_sharp,
                    color: ThemeColors().main,
                  ),
                  label: 'P',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                    color: ThemeColors().light1,
                  ),
                  activeIcon: Icon(
                    Icons.person,
                    color: ThemeColors().main,
                  ),
                  label: 'S',
                ),
              ],
            
          ),
        ),
      ),
    );
  }
}
