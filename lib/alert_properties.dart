// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

/// Base class for payment alert properties
/// [data] is the data of the alert
/// [context] is the context of the alert
/// [title] is the title of the alert
/// [icon] is the icon of the alert
/// [description] is the description of the alert
/// [action] is the action of the alert
/// [spacing] is the spacing between all the widgets (icon, title, description, action)
///
/// Example:
///
/// ```dart
/// CashPaymentAlertProperties(context: context, data: PaymentModel(id: "123456"));
/// ```
///
/// ```dart
/// FailedPaymentAlertProperties(context: context, data: PaymentModel(id: "123456"));
/// ```
///
///
/// ```dart
/// SuccessPaymentAlertProperties(context: context, data: PaymentModel(id: "123456"));
/// ```
abstract class AlertProperties<T extends Object?> {
  AlertProperties({this.context, this.data}) {
    if (context == null) {
      debugPrint('\x1B[31m [ WARNING! ] Context is null!\n\nBe sure to pass context to the constructor of the alert properties entity!\x1B[0m');
    }
  }

  /// Data of the alert
  /// This data might be used to pass data to the alert
  /// For example, the order number
  ///
  /// ```dart
  /// CashPaymentAlertProperties(context: context, data: PaymentModel(id: "123456"));
  /// ```
  ///
  final T? data;

  /// Builder of the alert
  Widget Function(AlertProperties<T> alert)? builder;

  /// Context of the alert
  final BuildContext? context;

  /// Title of the alert
  Widget? title;

  /// Image of the alert
  Widget? icon;

  /// Semantic label of the alert
  /// This is used for accessibility
  ///
  /// Example:
  ///
  /// ```dart
  /// FailedPaymentAlertProperties(context: context, data: PaymentModel(id: "123456"))
  ///   ..semanticLabel = "Failed payment";
  /// ```
  ///
  /// ```dart
  /// SuccessPaymentAlertProperties(context: context, data: PaymentModel(id: "123456"))
  ///  ..semanticLabel = "Success payment";
  /// ```
  ///
  String? semanticLabel;

  /// Description of the alert
  Widget? description;

  /// Action widget
  Widget? action;

  /// Spacing between all the widgets (icon, title, description, action)
  ///
  /// Default: 30
  ///
  double? spacing;

  /// Elevation of the alert
  ///
  /// Default: 0
  double? elevation;

  /// Width of the alert
  double? width;

  /// Height of the alert
  double? height;

  /// Padding of the alert
  EdgeInsetsGeometry? padding;

  /// Decoration of the alert
  ///
  /// Example:
  ///
  /// ```dart
  /// FailedPaymentAlertProperties(context: context, data: PaymentModel(id: "123456"))
  ///  ..decoration = BoxDecoration(
  ///     color: Colors.red,
  ///     borderRadius: BorderRadius.circular(30),
  ///   );
  /// ```
  ///
  /// ```dart
  /// SuccessPaymentAlertProperties(context: context, data: PaymentModel(id: "123456"))
  /// ..decoration = BoxDecoration(
  ///     color: Colors.green,
  ///     borderRadius: BorderRadius.circular(30),
  ///   );
  /// ```
  ///
  ///
  Decoration? decoration;
}
