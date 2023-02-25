import 'dart:async';

import 'package:betcal/ui/utils/alert.dart';
import 'package:betcal/ui/utils/color.dart';
import 'package:betcal/ui/utils/status_bar.dart';
import 'package:betcal/ui/widgets/animations/left_right_arrow.dart';
import 'package:betcal/ui/widgets/nav/cus_app_bar.dart';
import 'package:betcal/ui/widgets/nav/cus_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  RefreshController reloadController = RefreshController(initialRefresh: false);
  late StreamSubscription<InternetConnectionStatus> internetListener;
  late bool isInternetConnected;
  late List<ChartData> data;
  late TooltipBehavior tooltip;

  @override
  void initState() {
    super.initState();
    getChart();
    internetConnection();
  }

  @override
  void dispose() {
    super.dispose();
    internetListener.cancel();
  }

  void getChart() {
    data = [
      ChartData('David', 25),
      ChartData('Steve', 38),
      ChartData('Jack', 34),
      ChartData('Others', 52)
    ];
    tooltip = TooltipBehavior(enable: true);
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
                    bettersStats(dWidth, dHeight),
                    // live nba
                    liveNBA(dWidth, dHeight),
                    // top 10 nba teams
                    top10TeamsNBA(dWidth, dHeight),
                    // top story nba
                    topStoryNBA(dWidth, dHeight),
                    // nba random 3 news
                    random3NewsNBA(dWidth, dHeight),
                    // live epl
                    liveEPL(dWidth, dHeight),
                    // top 10 epl teams
                    top10TeamsEPL(dWidth, dHeight),
                    // top story epl
                    topStoryEPL(dWidth, dHeight),
                    // epl random 3 news
                    random3NewsEPL(dWidth, dHeight),
                    SliverPadding(
                      padding: EdgeInsets.only(
                        bottom: dHeight * 0.20,
                      ),
                    )
                  ],
                ),
                const CusBottomBar(selectedPage: 0)
              ],
            ),
          ),
        ),
      ),
    );
  }

  // betters' stats
  Widget bettersStats(dWidth, dHeight) {
    return SliverToBoxAdapter(
      child: Container(
        constraints: BoxConstraints(minHeight: dHeight * 0.15),
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: black,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              spreadRadius: 2,
              blurRadius: 6,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "This week's deposit",
                      style: TextStyle(
                        color: white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text("₦ 5,000", style: TextStyle(color: white)),
                  ],
                ),
                const SizedBox(height: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "This week's income",
                      style: TextStyle(
                        color: white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text("₦ 5,570", style: TextStyle(color: white)),
                  ],
                ),
                const SizedBox(height: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "This week's games count",
                      style: TextStyle(
                        color: white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text("17", style: TextStyle(color: white)),
                  ],
                ),
              ],
            ),
            Expanded(
              child: SizedBox(
                height: dHeight * 0.15,
                child: SfCircularChart(
                  tooltipBehavior: tooltip,
                  series: [
                    DoughnutSeries(
                      dataSource: data,
                      xValueMapper: (data, _) => data.x,
                      yValueMapper: (data, _) => data.y,
                      name: "Playing",
                      radius: "100%",
                      explode: true,
                      explodeIndex: 1,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // live nba
  Widget liveNBA(dWidth, dHeight) {
    return SliverToBoxAdapter(
      child: SizedBox(
        width: dWidth,
        height: dHeight * 0.30,
        child: Stack(
          children: [
            ListView.separated(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: 3,
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) =>
                  SizedBox(width: dWidth * 0.02),
              itemBuilder: (context, index) {
                return Container(
                  width: dWidth,
                  height: dHeight * 0.30,
                  color: gray,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: (dHeight * 0.30) * 0.7,
                        color: primary,
                        child: IntrinsicHeight(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Container(
                                  height: (dHeight * 0.30) * 0.7,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage("images/logo.png"),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      bottomLeft: Radius.circular(5),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "BOS",
                                      style: TextStyle(
                                        color: white.withOpacity(0.5),
                                        fontSize: 90,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const VerticalDivider(
                                color: darkGreen,
                                width: 2,
                                thickness: 2,
                              ),
                              Expanded(
                                child: Container(
                                  height: (dHeight * 0.30) * 0.7,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage("images/logo.png"),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(5),
                                      bottomRight: Radius.circular(5),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "IND",
                                      style: TextStyle(
                                        color: white.withOpacity(0.5),
                                        fontSize: 90,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: (dHeight * 0.30) * 0.3,
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image.asset(
                              "images/logo.png",
                              fit: BoxFit.fitWidth,
                              width: dWidth * 0.20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  "68",
                                  style: TextStyle(
                                    color: white,
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "vs",
                                  style: TextStyle(
                                    color: white,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "59",
                                  style: TextStyle(
                                    color: white,
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Image.asset(
                              "images/logo.png",
                              fit: BoxFit.fitWidth,
                              width: dWidth * 0.20,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            Positioned(
              top: 0,
              bottom: 0,
              right: dWidth * 0.08,
              child: const LRArrow(color: white, size: 30),
            )
          ],
        ),
      ),
    );
  }

  // top 10 nba teams
  Widget top10TeamsNBA(dWidth, dHeight) {
    return SliverToBoxAdapter(
      child: Container(
        height: dHeight * 0.10,
        margin: const EdgeInsets.only(top: 10),
        child: SizedBox(
          height: dHeight * 0.08,
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(8.0),
            shrinkWrap: true,
            itemCount: 10,
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => const SizedBox.shrink(),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {},
                child: Container(
                  width: dWidth * 0.2,
                  height: dHeight,
                  decoration: BoxDecoration(
                    color: primary,
                    border: Border.all(color: Colors.red, width: 2),
                    shape: BoxShape.circle,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  // top story nba
  Widget topStoryNBA(dWidth, dHeight) {
    return SliverToBoxAdapter(
      child: Container(
        height: dHeight * 0.30,
        margin: const EdgeInsets.only(top: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset("images/nba.png",
                            fit: BoxFit.fitWidth, width: dWidth * 0.08),
                        const Text(
                          "TOP STORIES",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        children: const [
                          Text(
                            "More",
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(width: 5),
                          Icon(Iconsax.arrow_right, color: primary)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: SizedBox(
                height: dHeight * 0.23,
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) =>
                      SizedBox(width: dWidth * 0.02),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {},
                      child: Stack(
                        children: [
                          Container(
                            width: dWidth * 0.35,
                            height: dHeight,
                            decoration: BoxDecoration(
                              color: primary,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            child: Container(
                              width: dWidth * 0.35,
                              height: 60,
                              decoration: BoxDecoration(
                                color: black.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(5),
                                gradient: const LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [black, transparent],
                                ),
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                alignment: Alignment.bottomCenter,
                                child: const Text(
                                  "Playoff Picture: Western Conference",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: white),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // nba random 3 news
  Widget random3NewsNBA(dWidth, dHeight) {
    return SliverToBoxAdapter(
      child: Stack(
        children: [
          ListView.separated(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: 3,
            separatorBuilder: (context, index) =>
                SizedBox(width: dHeight * 0.02),
            itemBuilder: (context, index) {
              return Container(
                width: dWidth,
                height: dHeight * 0.40,
                padding: const EdgeInsets.all(15),
                margin: EdgeInsets.fromLTRB(10, dHeight * 0.025, 10, 10),
                decoration: BoxDecoration(
                  color: gray,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Stack(
                  children: [
                    Container(
                      width: dWidth,
                      height: dHeight * 0.18,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: const DecorationImage(
                          image: AssetImage("images/logo.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: dHeight * 0.20,
                      left: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {},
                        child: const Text(
                          "Will Dominates Immediately In NBA",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.ios_share_rounded,
                          color: white,
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // live epl
  Widget liveEPL(dWidth, dHeight) {
    return SliverToBoxAdapter(
      child: Container(
        width: dWidth,
        height: dHeight * 0.30,
        margin: EdgeInsets.only(top: dHeight * 0.05),
        child: Stack(
          children: [
            ListView.separated(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: 3,
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) =>
                  SizedBox(width: dWidth * 0.02),
              itemBuilder: (context, index) {
                return Container(
                  width: dWidth,
                  height: dHeight * 0.30,
                  color: gray,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: (dHeight * 0.30) * 0.7,
                        color: primary,
                        child: IntrinsicHeight(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Container(
                                  height: (dHeight * 0.30) * 0.7,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage("images/logo.png"),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      bottomLeft: Radius.circular(5),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "BOS",
                                      style: TextStyle(
                                        color: white.withOpacity(0.5),
                                        fontSize: 90,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const VerticalDivider(
                                color: darkGreen,
                                width: 2,
                                thickness: 2,
                              ),
                              Expanded(
                                child: Container(
                                  height: (dHeight * 0.30) * 0.7,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage("images/logo.png"),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(5),
                                      bottomRight: Radius.circular(5),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "IND",
                                      style: TextStyle(
                                        color: white.withOpacity(0.5),
                                        fontSize: 90,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: (dHeight * 0.30) * 0.3,
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image.asset(
                              "images/logo.png",
                              fit: BoxFit.fitWidth,
                              width: dWidth * 0.20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  "68",
                                  style: TextStyle(
                                    color: white,
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "vs",
                                  style: TextStyle(
                                    color: white,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "59",
                                  style: TextStyle(
                                    color: white,
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Image.asset(
                              "images/logo.png",
                              fit: BoxFit.fitWidth,
                              width: dWidth * 0.20,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            Positioned(
              top: 0,
              bottom: 0,
              right: dWidth * 0.08,
              child: const LRArrow(color: white, size: 30),
            )
          ],
        ),
      ),
    );
  }

  // top 10 epl teams
  Widget top10TeamsEPL(dWidth, dHeight) {
    return SliverToBoxAdapter(
      child: Container(
        height: dHeight * 0.10,
        margin: const EdgeInsets.only(top: 10),
        child: SizedBox(
          height: dHeight * 0.08,
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(8.0),
            shrinkWrap: true,
            itemCount: 10,
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) =>
                SizedBox(width: dWidth * 0.02),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {},
                child: Container(
                  width: dWidth * 0.2,
                  height: dHeight,
                  decoration: BoxDecoration(
                    color: primary,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.purple, width: 2),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  // top story epl
  Widget topStoryEPL(dWidth, dHeight) {
    return SliverToBoxAdapter(
      child: Container(
        height: dHeight * 0.30,
        margin: const EdgeInsets.only(top: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset("images/epl.png",
                            fit: BoxFit.fitWidth, width: dWidth * 0.08),
                        const Text(
                          "TOP STORIES",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        children: const [
                          Text(
                            "More",
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(width: 5),
                          Icon(Iconsax.arrow_right, color: primary)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: SizedBox(
                height: dHeight * 0.23,
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) =>
                      SizedBox(width: dWidth * 0.02),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {},
                      child: Stack(
                        children: [
                          Container(
                            width: dWidth * 0.35,
                            height: dHeight,
                            decoration: BoxDecoration(
                              color: primary,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            child: Container(
                              width: dWidth * 0.35,
                              height: 60,
                              decoration: BoxDecoration(
                                color: black.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(5),
                                gradient: const LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [black, transparent],
                                ),
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                alignment: Alignment.bottomCenter,
                                child: const Text(
                                  "Playoff Picture: Western Conference",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: white),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // epl random 3 news
  Widget random3NewsEPL(dWidth, dHeight) {
    return SliverToBoxAdapter(
      child: Stack(
        children: [
          ListView.separated(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: 3,
            separatorBuilder: (context, index) =>
                SizedBox(width: dHeight * 0.02),
            itemBuilder: (context, index) {
              return Container(
                width: dWidth,
                height: dHeight * 0.40,
                padding: const EdgeInsets.all(15),
                margin: EdgeInsets.fromLTRB(10, dHeight * 0.025, 10, 10),
                decoration: BoxDecoration(
                  color: gray,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Stack(
                  children: [
                    Container(
                      width: dWidth,
                      height: dHeight * 0.18,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: const DecorationImage(
                          image: AssetImage("images/logo.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: dHeight * 0.20,
                      left: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {},
                        child: const Text(
                          "Promise Dominates Immediately In EPL",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.ios_share_rounded,
                          color: white,
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ],
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

class ChartData {
  ChartData(this.x, this.y);

  final String x;
  final double y;
}
