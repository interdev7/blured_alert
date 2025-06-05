import 'package:flutter/material.dart';

import '../alert_properties.dart';

class BluredAlert extends StatelessWidget {
  const BluredAlert({
    super.key,
    required this.alert,
  });

  final AlertProperties alert;

  Widget _sizedBoxAfter(Object? obj) {
    if (obj != null) {
      return SizedBox(height: alert.spacing ?? 30);
    }
    return const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // final a = AlertDialog();
    return alert.builder?.call(alert) ??
        Center(
          child: PhysicalModel(
            color: Colors.transparent,
            elevation: alert.elevation ?? 4,
            // shadowColor: Colors.black.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
            child: Container(
              width: alert.width ?? size.width * 0.87,
              height: alert.height,
              padding: alert.padding ?? const EdgeInsets.symmetric(horizontal: 45, vertical: 50),
              decoration: alert.decoration ??
                  BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (alert.icon != null) alert.icon!,
                  _sizedBoxAfter(alert.icon),
                  if (alert.title != null) alert.title!,
                  _sizedBoxAfter(alert.title),
                  if (alert.description != null) alert.description!,
                  _sizedBoxAfter(alert.description),
                  if (alert.action != null) alert.action!,
                ],
              ),
            ),
          ),
        );
  }
}
