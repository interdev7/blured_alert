# Blurry Dialog and Alert Components for Flutter

This package provides reusable Flutter components for displaying blurred dialogs and customizable alert dialogs with a generic `data` property. The main components are `showBlurryDialog` and `BluredAlert`, enabling visually appealing dialogs with a blurred background and structured alert content.

## Features

- **Blurry Dialog**: Uses `BackdropFilter` for a customizable blur effect.
- **Customizable Alerts**: `AlertProperties` base class for defining alert content (icon, title, description, action).
- **Generic Data**: Pass any data type to `AlertProperties` for dynamic content.
- **Responsive Design**: Alerts adapt to screen sizes with customizable width, height, and padding.
- **Accessibility**: Supports semantic labels for screen readers.
- **Flexible Styling**: Custom decorations, elevations, and spacing.
- **Dismissible Behavior**: Configurable barrier dismissibility and pop behavior.

## Installation

Ensure dependencies in `pubspec.yaml`:
```yaml
dependencies:
  blured_alert: latest
```

## Usage

### 1. Showing a Blurry Dialog

The `showBlurryDialog` function displays a dialog with a blurred background.

```dart

void showSampleDialog(BuildContext context) {
  showBlurryDialog(
    context: context,
    child: BluredAlert(
      alert: AlertProperties(
        context: context,
        title: Text('Sample Alert'),
        description: Text('This is a sample blurry dialog.'),
        action: ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('OK'),
        ),
      ),
    ),
    isDismissible: true,
    sigmaX: 5.0,
    sigmaY: 5.0,
    backgroundOpacity: 0.5,
    onDismiss: () => debugPrint('Dialog dismissed'),
  );
}
```

**Parameters**:
- `context`: The `BuildContext` for the dialog.
- `child`: Content widget (e.g., `BluredAlert`).
- `isDismissible`: Allows dismissing by tapping outside (default: `true`).
- `canPop`: Allows back button to pop dialog (default: `true`).
- `barrierColor`: Barrier color (default: `Colors.black`).
- `sigmaX`, `sigmaY`: Blur intensity (default: `10.0`).
- `backgroundOpacity`: Barrier opacity (default: `0.3`).
- `onPop`: Callback when dialog is popped.
- `onDismiss`: Callback when dialog is dismissed.

### 2. Custom Alert with Generic Data

Use `AlertProperties` with a generic `data` type to pass custom data (e.g., `PaymentModel`).

```dart
// Data model
class PaymentModel {
  final String id;
  final double amount;

  PaymentModel({required this.id, required this.amount});
}

// Custom alert properties
class SuccessPaymentAlertProperties extends AlertProperties<PaymentModel> {
  SuccessPaymentAlertProperties({super.context, super.data}) {
    title = Text('Payment Successful');
    icon = Icon(Icons.check_circle, color: Colors.green, size: 40);
    description = Text(
      data != null
          ? 'Payment of \$${data!.amount} for order #${data!.id} completed.'
          : 'Payment completed.',
    );
    action = ElevatedButton(
      onPressed: () {
        if (data != null) {
          debugPrint('Processing payment ID: ${data!.id}, \$${data!.amount}');
        }
        context?.pop();
      },
      child: Text('OK'),
    );
    decoration = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
    );
    semanticLabel = 'Success payment';
    spacing = 15.0;
    elevation = 6.0;
    padding = EdgeInsets.all(20);
  }
}

// Show alert
void showSuccessAlert(BuildContext context) {
  showBlurryDialog(
    context: context,
    child: BluredAlert(
      alert: SuccessPaymentAlertProperties(
        context: context,
        data: PaymentModel(id: '123456', amount: 99.99),
      ),
    ),
  );
}
```

### 3. Alert with Localization and Generic Data

Integrate localization (e.g., `easy_localization`) and use `data` for dynamic content.

```dart
class SuccessPaymentAlertProperties extends AlertProperties<PaymentModel> {
  SuccessPaymentAlertProperties({super.context, super.data}) {
    title = Text(context?.tr('successPaymentAlert.title') ?? 'Success');
    icon = Icon(Icons.check_circle, color: Colors.green);
    description = Text(
      context?.tr('successPaymentAlert.description', namedArgs: {
        'orderNo': data?.id ?? 'N/A',
        'amount': '\$${data?.amount.toStringAsFixed(2) ?? '0.00'}'
      }) ?? 'Payment completed.',
    );
    action = ElevatedButton(
      onPressed: () {
        if (data != null) {
          debugPrint('Confirmed payment: ${data!.id}, \$${data!.amount}');
        }
        context?.pop();
      },
      child: Text(context?.tr('successPaymentAlert.buttonText') ?? 'OK'),
    );
    decoration = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
    );
    semanticLabel = 'Success payment';
    spacing = 20.0;
    elevation = 6.0;
    padding = EdgeInsets.all(20);
  }
}

// Usage
void showLocalizedAlert(BuildContext context) {
  showBlurryDialog(
    context: context,
    child: BluredAlert(
      alert: SuccessPaymentAlertProperties(
        context: context,
        data: PaymentModel(id: '123456', amount: 50.0),
      ),
    ),
  );
}
```

### 4. Failed Payment Alert Example

```dart
class FailedPaymentAlertProperties extends AlertProperties<PaymentModel> {
  FailedPaymentAlertProperties({super.context, super.data}) {
    title = Text('Payment Failed');
    icon = Icon(Icons.error, color: Colors.red, size: 40);
    description = Text(
      data != null
          ? 'Failed to process payment for order #${data!.id}.'
          : 'Payment failed.',
    );
    action = ElevatedButton(
      onPressed: () {
        if (data != null) {
          debugPrint('Retry payment ID: ${data!.id}');
        }
        context?.pop();
      },
      child: Text('Try Again'),
    );
    decoration = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
    );
    semanticLabel = 'Failed payment';
    spacing = 15.0;
    elevation = 6.0;
    padding = EdgeInsets.all(20);
  }
}

void showFailedAlert(BuildContext context) {
  showBlurryDialog(
    context: context,
    child: BluredAlert(
      alert: FailedPaymentAlertProperties(
        context: context,
        data: PaymentModel(id: '123456', amount: 50.0),
      ),
    ),
  );
}
```

## AlertProperties Fields

- `data`: Generic data (e.g., `PaymentModel`) for dynamic content.
- `context`: `BuildContext` for navigation/localization.
- `title`: Alert title widget.
- `icon`: Alert icon widget.
- `semanticLabel`: Accessibility label.
- `description`: Alert description widget.
- `action`: Action widget (e.g., buttons).
- `spacing`: Spacing between elements (default: `30.0`).
- `elevation`: Alert elevation (default: `0`).
- `width`: Alert width (default: 87% of screen width).
- `height`: Alert height (optional).
- `padding`: Alert padding (default: `EdgeInsets.symmetric(horizontal: 45, vertical: 50)`).
- `decoration`: Custom decoration (default: white with rounded corners).
- `builder`: Optional custom builder for alert layout.

## Notes

- **Generic Data**: Check `data != null` before accessing properties to avoid errors.
- **Context**: Pass a valid `BuildContext` to avoid warnings.
- **Localization**: Use with packages like `easy_localization` for translatable strings.
- **Accessibility**: Set `semanticLabel` for screen reader support.
- **Performance**: `BackdropFilter` may impact low-end devices.


## Limitations

- `BackdropFilter` may cause performance issues on low-end devices.
- Ensure `context` is not null in `AlertProperties`.
- Default alert width is 87% of screen width (customizable via `width`).

