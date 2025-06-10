# 🌫️ Blured Alert – Blurry Dialog & Custom Alert Widgets for Flutter

A beautiful and reusable set of Flutter components for displaying **blurred dialogs** and **customizable alert views** using a generic `data` property.

Easily display visually stunning alerts with flexible content, animation, and style. Great for success, error, or confirmation dialogs!

---

## ✨ Features

- ✅ **Blurred Background**: Uses `BackdropFilter` for smooth background blur.
- 🧩 **Modular Alerts**: Create alerts using the `AlertProperties` base class.
- 🔄 **Generic Data**: Pass custom data to alerts (e.g., payment info, messages).
- 📱 **Responsive Layout**: Scales beautifully across devices.
- 🧑‍🦯 **Accessibility Support**: Set `semanticLabel` for screen readers.
- 🎨 **Flexible Styling**: Customize padding, decoration, spacing, elevation.
- ❌ **Dismiss Behavior**: Control dismissibility via tap or back press.

---

## 🚀 Installation

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  blured_alert: latest
```

---

## 🛠️ Usage

### 1. Show a Simple Blurred Dialog

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
    sigmaX: 5,
    sigmaY: 5,
    backgroundOpacity: 0.5,
    onDismiss: () => debugPrint('Dialog dismissed'),
  );
}
```

**Main Parameters:**
- `context`: Build context for navigation and theming.
- `child`: Dialog content widget (usually `BluredAlert`).
- `isDismissible`: Allow dismiss by tapping outside (`true` by default).
- `sigmaX`, `sigmaY`: Blur intensities (default: `10.0`).
- `backgroundOpacity`: Background dimness (default: `0.3`).
- `onPop`, `onDismiss`: Optional callbacks.

---

### 2. Custom Alert with Generic Data

```dart
class PaymentModel {
  final String id;
  final double amount;

  PaymentModel({required this.id, required this.amount});
}
```

```dart
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
        debugPrint('Payment ID: ${data?.id}');
        context?.pop();
      },
      child: Text('OK'),
    );
  }
}
```

```dart
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

---

### 3. Localized Alert with Data (e.g. `easy_localization`)

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
      onPressed: () => context?.pop(),
      child: Text(context?.tr('successPaymentAlert.buttonText') ?? 'OK'),
    );
  }
}
```

---

### 4. Failed Payment Example

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
        debugPrint('Retry payment ID: ${data?.id}');
        context?.pop();
      },
      child: Text('Try Again'),
    );
  }
}
```

---

## 📦 `AlertProperties<T>` – API Overview

| Property         | Description                                                                 |
|------------------|-----------------------------------------------------------------------------|
| `data`           | Generic data object (e.g., `PaymentModel`)                                 |
| `context`        | Build context (used for navigation, localization, etc.)                    |
| `title`          | Title widget                                                               |
| `icon`           | Optional icon widget                                                       |
| `description`    | Description widget                                                         |
| `action`         | Button(s) or any widget                                                    |
| `spacing`        | Vertical spacing between elements (`default: 30`)                          |
| `elevation`      | Dialog elevation                                                            |
| `width`          | Dialog width (`default: 87%` of screen)                                    |
| `height`         | Optional dialog height                                                      |
| `padding`        | Inner padding (`default: EdgeInsets.symmetric(horizontal: 45, vertical: 50)`) |
| `decoration`     | Background decoration                                                       |
| `semanticLabel`  | Accessibility label                                                         |
| `builder`        | Optional custom builder to override layout                                 |

---

## 📝 Notes

- ✅ Always check `data != null` before accessing it.
- 🌐 Use localization packages like `easy_localization` for multi-language support.
- ♿ Set `semanticLabel` for accessibility compliance.
- ⚠️ `BackdropFilter` may affect performance on low-end devices.

---

## ⚠️ Limitations

- ❗ `BackdropFilter` can be heavy for devices with low GPU performance.
- 🔄 Ensure `context` is valid when building the alert.
- 📏 Default width is 87% of screen; override if needed.
