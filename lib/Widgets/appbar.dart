import 'package:flutter/material.dart';

class SlideAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const SlideAppBarWidget({
    super.key,
    required this.child,
    required this.controller,
    required this.isShowBar,
  });

  final PreferredSizeWidget child;
  final AnimationController controller;
  final bool isShowBar;

  @override
  // TODO: implement preferredSize
  Size get preferredSize => child.preferredSize;

  @override
  Widget build(BuildContext context) {
    isShowBar ? controller.forward() : controller.reverse();
    return SlideTransition(
      position: Tween(
        begin: const Offset(0, -1),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(parent: controller, curve: Curves.fastLinearToSlowEaseIn),
      ),
      child: child,
    );
  }
}
