import 'package:betcal/ui/screens/account.dart';
import 'package:betcal/ui/screens/home.dart';
import 'package:betcal/ui/screens/matches.dart';
import 'package:betcal/ui/screens/standings.dart';
import 'package:betcal/ui/utils/color.dart';
import 'package:blur_bottom_bar/blur_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:page_transition/page_transition.dart';

// custom button navbar
class CusBottomBar extends StatefulWidget {
  const CusBottomBar({Key? key, required this.selectedPage}) : super(key: key);

  // page index selected
  final int selectedPage;

  @override
  State<CusBottomBar> createState() => _CusBottomBarState();
}

class _CusBottomBarState extends State<CusBottomBar> {
  // navigation bar items
  List navigationBarItemList = [
    // home bar item
    const BottomNavigationBarItem(
      label: "Home",
      tooltip: "Home",
      icon: Icon(Iconsax.home),
    ),
    // matches bar item
    const BottomNavigationBarItem(
      label: "Matches",
      tooltip: "Matches",
      icon: Icon(Iconsax.calendar_1),
    ),
    // standings bar item
    const BottomNavigationBarItem(
      label: "Standings",
      tooltip: "Standings",
      icon: Icon(Iconsax.chart_1),
    ),
    // account bar item
    const BottomNavigationBarItem(
      label: "Account",
      tooltip: "Account",
      icon: Icon(Iconsax.user),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlurBottomView(
      currentIndex: widget.selectedPage,
      onIndexChange: onChangeScreen,
      filterX: 4,
      filterY: 4,
      backgroundColor: white,
      selectedItemColor: primary,
      unselectedItemColor: gray,
      bottomNavigationBarItems: [
        for (var item in navigationBarItemList) item,
      ],
    );
  }

  void onChangeScreen(int index) {
    setState(() {
      // home route
      if (index == 0 && widget.selectedPage != index) {
        Navigator.pushReplacement(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            child: const HomeScreen(),
          ),
        );
      }
      // matches route
      if (index == 1 && widget.selectedPage != index) {
        Navigator.pushReplacement(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            child: const MatchesScreen(),
          ),
        );
      }
      // standings route
      if (index == 2 && widget.selectedPage != index) {
        Navigator.pushReplacement(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            child: const StandingsScreen(),
          ),
        );
      }
      // account route
      if (index == 3 && widget.selectedPage != index) {
        Navigator.pushReplacement(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            child: const AccountScreen(),
          ),
        );
      }
    });
  }
}
