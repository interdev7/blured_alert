// ignore_for_file: deprecated_member_use

import 'dart:ui';

import 'package:flutter/material.dart';

Future<T?> showBlurryDialog<T extends Object?>(
  BuildContext context,
  Widget child, {
  bool isDismissible = true,
  bool canPop = true,
  Color? barrierColor,
  double sigmaX = 10.0,
  double sigmaY = 10.0,
  double backgroundOpacity = 0.3,
  Future<void> Function()? onPop,
  void Function()? onDismiss,
}) {
  return showGeneralDialog<T>(
    context: context,
    barrierLabel: "BlurDialog",
    barrierDismissible: isDismissible,
    barrierColor: (barrierColor ?? Colors.black).withOpacity(backgroundOpacity),
    pageBuilder: (context, _, __) {
      return PopScope(
        canPop: canPop,
        onPopInvoked: (canPop) async {
          await onPop?.call();
        },
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                onDismiss?.call();
                if (isDismissible) {
                  Navigator.of(context).maybePop();
                }
              },
              child: GestureDetector(
                onTap: () {},
                child: child,
              ),
            ),
          ),
        ),
      );
    },
    transitionDuration: const Duration(milliseconds: 150),
    transitionBuilder: (_, animation, __, child) {
      return FadeTransition(opacity: animation, child: child);
    },
  );
}
