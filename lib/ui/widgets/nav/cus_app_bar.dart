import 'package:betcal/ui/utils/color.dart';
import 'package:betcal/ui/utils/status_bar.dart';
import 'package:flutter/material.dart';

class CusAppBar extends StatelessWidget {
  const CusAppBar({
    super.key,
    this.snap = true,
    this.pinned = false,
    this.floating = true,
    this.back = false,
    this.isDark = true,
    this.title = "",
    required this.context,
  });

  final bool snap;
  final bool pinned;
  final bool floating;
  final bool back;
  final bool isDark;
  final String title;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      systemOverlayStyle: statusBar(isDark: isDark),
      pinned: pinned,
      snap: snap,
      floating: floating,
      backgroundColor: white,
      elevation: 0,
      leading: leading(),
      title: mainTitle(),
      actions: [actions()],
    );
  }

  // leading
  Widget leading() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: back
          ? IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 20,
                color: primary,
              ),
            )
          : Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: const DecorationImage(
                  image: AssetImage("images/logo.png"),
                ),
              ),
            ),
    );
  }

  // title
  Widget mainTitle() {
    if (back) {
      return Center(
        child: Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: primary, fontSize: 16),
        ),
      );
    }

    return const SizedBox.shrink();
  }

  // trailing
  Widget actions() {
    return const SizedBox.shrink();
  }
}
