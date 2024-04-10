import 'dart:async';
import 'dart:io';

import 'package:bottom_bar/bottom_bar.dart';
import 'package:employee_clock_in/res/utils/theme/color_palette.dart';
import 'package:employee_clock_in/views/history_screen.dart';
import 'package:employee_clock_in/views/home_screen.dart';
import 'package:employee_clock_in/views/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _currentPage = 0;
  final _pageController = PageController();


  @override
  initState() {
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_currentPage == 0) {
         return showCloseDialog();
        } else {
          _currentPage = 0;
          _pageController.jumpToPage(_currentPage);
          setState(() {});
          return false;
        }
      },
      child: Container(
        color: Colors.white,
        child: SafeArea(
            child: Scaffold(
          body: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              const HomeScreen(),
              const HistoryScreen(),
              SettingsScreen(),
            ],
            onPageChanged: (index) {
              setState(() => _currentPage = index);
            },
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30.r),
              child: BottomBar(
                backgroundColor: ColorPalette.appPrimaryColor,
                selectedIndex: _currentPage,
                onTap: (int index) {
                  _pageController.jumpToPage(index);
                  setState(() => _currentPage = index);
                },
                items: <BottomBarItem>[
                  BottomBarItem(
                    icon: Icon(Icons.home, color: Colors.white, size: 24.w),
                    title: const Text('Home'),
                    activeColor: ColorPalette.appSecondaryColor,
                    activeIconColor: Colors.white,
                    activeTitleColor: Colors.white,
                    inactiveColor: Colors.white,
                    // backgroundColorOpacity: 0.8
                  ),
                  BottomBarItem(
                    icon: Icon(Icons.list, color: Colors.white, size: 24.w),
                    title: const Text('History'),
                    activeColor: ColorPalette.appSecondaryColor,
                    activeIconColor: Colors.white,
                    activeTitleColor: Colors.white,
                    inactiveColor: Colors.white,
                    // backgroundColorOpacity: 0.8
                  ),
                  BottomBarItem(
                    icon: Icon(Icons.settings, color: Colors.white, size: 24.w),
                    title: const Text('Settings'),
                    activeColor: ColorPalette.appSecondaryColor,
                    activeIconColor: Colors.white,
                    activeTitleColor: Colors.white,
                    inactiveColor: Colors.white,
                    // backgroundColorOpacity: 0.8
                  ),
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }

 Future<bool> showCloseDialog() async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SizedBox(
              height: 90,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Are you want to exit this App."),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            exit(0);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: ColorPalette.appPrimaryColor),
                          child: const Text("Yes"),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorPalette.appPrimaryColor,
                            ),
                            child: const Text("No",),
                          ))
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
