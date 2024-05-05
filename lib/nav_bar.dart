import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:get/get.dart';
import 'package:prueba_flutter_2/home_page.dart';
import 'package:prueba_flutter_2/profile_page.dart';
import 'package:prueba_flutter_2/widget/pallete.dart';

class CustomBottomNavigationBarController extends GetxController {
  void updateIndex(int index) {
    switch (index) {
      case 0:
        Get.to(HomePage(), transition: Transition.noTransition);
        break;
      case 1:
        Get.to(ProfilePage(), transition: Transition.noTransition);
        break;
      default:
        break;
    }
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  final CustomBottomNavigationBarController controller =
      Get.put(CustomBottomNavigationBarController());

  final int currentIndex;

  CustomBottomNavigationBar({Key? key, required this.currentIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomBottomNavigationBarController>(
      builder: (controller) {
        return SafeArea(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(
            height: 1,
            color: Color(0xFFFFFCEA),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 140, vertical: 8),
            child: GNav(
              rippleColor: Color(0xFFFFFCEA),
              gap: 4,
              activeColor: Color(0xFFFFFCEA),
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              tabBackgroundColor: Pallete.secondary,
              color: Color(0xFFFFFCEA),
              tabs: [
                GButton(
                  icon: LineIcons.home,
                  text: "Inicio",
                ),
                GButton(
                  icon: LineIcons.user,
                  text: "Perfil",
                ),
              ],
              selectedIndex: currentIndex,
              onTabChange: controller.updateIndex,
            ),
          ),
        ]));
      },
    );
  }
}
