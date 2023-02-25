import 'dart:async';

import 'package:betcal/ui/utils/alert.dart';
import 'package:betcal/ui/utils/color.dart';
import 'package:betcal/ui/utils/status_bar.dart';
import 'package:betcal/ui/widgets/nav/cus_app_bar.dart';
import 'package:betcal/ui/widgets/nav/cus_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  RefreshController reloadController = RefreshController(initialRefresh: false);
  late StreamSubscription<InternetConnectionStatus> internetListener;
  late bool isInternetConnected;

  @override
  void initState() {
    super.initState();
    internetConnection();
  }

  @override
  void dispose() {
    super.dispose();
    internetListener.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final dWidth = MediaQuery.of(context).size.width;
    final dHeight = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: statusBar(),
        child: Scaffold(
          backgroundColor: white,
          body: SmartRefresher(
            enablePullDown: true,
            header: const WaterDropMaterialHeader(
              backgroundColor: white,
              color: primary,
            ),
            controller: reloadController,
            onRefresh: reload,
            child: Stack(
              children: [
                CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    // app bar
                    CusAppBar(pinned: false, context: context),
                    // betters' stats
                    avatar(dWidth, dHeight),
                    // deposit
                    deposit(dWidth, dHeight),
                    SliverPadding(
                      padding: EdgeInsets.only(
                        bottom: dHeight * 0.20,
                      ),
                    )
                  ],
                ),
                const CusBottomBar(selectedPage: 3)
              ],
            ),
          ),
        ),
      ),
    );
  }

  // avatar
  Widget avatar(dWidth, dHeight) {
    return SliverToBoxAdapter(
      child: Container(
        height: dHeight * 0.20,
        margin: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          color: black,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.20),
              spreadRadius: 2,
              blurRadius: 6,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Icon(
          Iconsax.user,
          color: white,
          size: dHeight * 0.10,
        ),
      ),
    );
  }

  // deposit
  Widget deposit(dWidth, dHeight) {
    return SliverToBoxAdapter(
      child: GestureDetector(
        onTap: () {},
        child: Container(
          // height: dHeight * 0.08,
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Get Funded & Started",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Add some cash to your added to automatically sub for a weekly placement",
                    ),
                  ],
                ),
              ),
              const Expanded(child: Icon(Iconsax.wallet_add))
            ],
          ),
        ),
      ),
    );
  }

  // checking internet connection
  void internetConnection() async {
    internetListener = InternetConnectionChecker().onStatusChange.listen(
      (status) {
        switch (status) {
          case InternetConnectionStatus.connected:
            break;
          case InternetConnectionStatus.disconnected:
            Alert(
              type: "error",
              context: context,
              message: "No Internet Connection!!!",
            ).show();
            break;
        }
      },
    );
  }

  // reload screen
  void reload() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() {});
    reloadController.refreshCompleted();
  }
}
