  import 'package:flutter/material.dart';
  import 'package:flutter_svg/flutter_svg.dart';
import 'package:pharmed_app/views/dic/dic_view.dart';
import 'package:pharmed_app/views/home/home_view.dart';
import 'package:pharmed_app/views/my_medical_history/my_medical_history_view.dart';
import 'package:pharmed_app/views/notification/notification_view.dart';

  class BottomNavigation extends StatefulWidget {
    // Accept index as an optional parameter
    final int? initialIndex;

    const BottomNavigation({super.key, this.initialIndex});

    @override
    State<BottomNavigation> createState() => _BottomNavigationState();
  }

  class _BottomNavigationState extends State<BottomNavigation> {
    // Screens
    List<Widget> screens = [
      HomeView(),
      DicView(),
      MyMedicalHistoryView(),
      NotificationView()
    ];

    // Variables
    int currentIndex = 0;

    @override
    void initState() {
      super.initState();
      // If an initial index is provided, use it, otherwise, default to 0
      if (widget.initialIndex != null) {
        currentIndex = widget.initialIndex!;
      }
    }

    void onItemTapped(int index) {
      setState(() {
        currentIndex = index;
      });
    }

    @override
    Widget build(BuildContext context) {
      double screenHeight = MediaQuery.of(context).size.height;
      double bottomNavHeight =
          screenHeight < 600 ? 60 : 77;

      return Scaffold(
        body: screens[currentIndex],
        bottomNavigationBar: SafeArea(
          child: Container(
            height: bottomNavHeight, // Dynamically set height
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 5.0,
                  offset: Offset(0, -3),
                ),
              ],
            ),
            child: BottomAppBar(
              color: Colors.white,
              elevation: 1,
              shape: const CircularNotchedRectangle(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildBottomNavItem(
                    index: 0,
                    iconPath: 'assets/svg/home.svg',
                    label: 'Home',
                    showPolicy: false,
                    onPressed: () {
                      onItemTapped(0);
                    },
                  ),
                  _buildBottomNavItem(
                    index: 1,
                    iconPath: 'assets/svg/dic.svg',
                    label: 'DIC',
                    showPolicy: false,
                    onPressed: () {
                      onItemTapped(1);
                    },
                  ),
                  _buildBottomNavItem(
                    index: 2,
                    iconPath: 'assets/svg/medicine.svg',
                    label: 'Medicines',
                    showPolicy: true,
                    iconWidth: 15,
                    onPressed: () {
                      onItemTapped(2);
                    },
                  ),
                  _buildBottomNavItem(
                    index: 3,
                    iconPath: 'assets/svg/notification.svg',
                    label: 'Notification',
                    showPolicy: true,
                    onPressed: () {
                      onItemTapped(3);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    Widget _buildBottomNavItem({
      required int index,
      required String iconPath,
      required String label,
      required VoidCallback onPressed,
      required bool showPolicy,
      double iconWidth = 17,
    }) {
      return IconButton(
        onPressed: onPressed,
        icon: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconPath,
              width: iconWidth,
              color: currentIndex == index
                  ? const Color(0xff52A8B0)
                  : Colors.grey[500],
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                color: currentIndex == index
                    ? const Color(0xff52A8B0)
                    : Colors.grey[500],
                fontSize: 9,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    }
  }
    