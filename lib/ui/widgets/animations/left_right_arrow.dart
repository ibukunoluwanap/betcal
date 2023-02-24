import 'package:betcal/ui/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class LRArrow extends StatefulWidget {
  const LRArrow({
    super.key,
    this.direction = Direction.leftToRight,
    this.size = 20,
    this.color = primary,
  });

  final Direction direction;
  final double size;
  final Color color;

  @override
  State<LRArrow> createState() => _LRArrowState();
}

class _LRArrowState extends State<LRArrow> with SingleTickerProviderStateMixin {
  late final AnimationController controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);

  late final Animation<Offset> offset = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(1.2, 0.0),
  ).animate(CurvedAnimation(
    parent: controller,
    curve: Curves.easeIn,
  ));

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: offset,
      child: Icon(
        getIcon(widget.direction),
        size: widget.size,
        color: widget.color,
      ),
    );
  }

  IconData? getIcon(direction) {
    switch (direction) {
      case Direction.leftToRight:
        return Iconsax.arrow_left_2;
      case Direction.rightToLeft:
        return Iconsax.arrow_right_2;
      case Direction.topToBottom:
        return Iconsax.arrow_up_2;
      case Direction.bottomToTop:
        return Iconsax.arrow_down_2;
    }
    return null;
  }
}

enum Direction { leftToRight, rightToLeft, topToBottom, bottomToTop }
