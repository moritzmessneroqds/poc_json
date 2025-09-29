# Dynamic Widget Demo

A Flutter proof-of-concept app that demonstrates how to load and render Flutter widgets from JSON data using the [dynamic_widget](https://pub.dev/packages/dynamic_widget) package.

## Features

- **Dynamic Widget Rendering**: Load and render Flutter widgets from JSON data
- **Automatic Fallback**: Loads from web URL, falls back to local sample data
- **Code Configuration**: JSON URL configured in code, not in UI
- **Error Handling**: Comprehensive error handling and loading states
- **Modern UI**: Clean, Material 3 design with light/dark theme support

## Configuration

### Setting JSON URL

Edit `lib/config/app_config.dart` to configure your JSON source:

```dart
class AppConfig {
  // Load from web URL
  static const String? jsonUrl = 'https://your-api.com/widget.json';
  
  // Or use local sample data only
  // static const String? jsonUrl = null;
}
```

### Behavior

1. **Web URL Available**: Loads JSON from the configured URL
2. **Web URL Fails**: Automatically falls back to local sample data
3. **No URL Configured**: Uses local sample data directly

## JSON Format

The JSON format follows Flutter widget structure. Here's a simple example:

```json
{
  "type": "Container",
  "padding": "16,16,16,16",
  "child": {
    "type": "Text",
    "data": "Hello, Dynamic Widgets!"
  }
}
```

## Sample JSON

A complete sample JSON file is included (`sample_widget.json`) that demonstrates various widgets and layouts.

## Dependencies

- `dynamic_widget: ^6.0.0` - For rendering widgets from JSON
- `dio: ^5.4.0` - For HTTP requests to load JSON from URLs

## Getting Started

1. Install dependencies:
   ```bash
   flutter pub get
   ```

2. Configure your JSON URL in `lib/config/app_config.dart`

3. Run the app:
   ```bash
   flutter run
   ```

4. The app will automatically load and render your JSON widgets

## Supported Widgets

The dynamic_widget package supports many Flutter widgets including:
- Container, Text, Row, Column
- ElevatedButton, OutlinedButton, TextButton
- Card, Scaffold, AppBar
- Icon, Image, ListView, GridView
- And many more!

For a complete list, see the [dynamic_widget documentation](https://pub.dev/packages/dynamic_widget).

## Development

- **Change JSON Source**: Edit `lib/config/app_config.dart`
- **Add Click Handlers**: Modify `lib/widgets/dynamic_widget_page.dart`
- **Update Sample Data**: Edit `lib/services/json_data_service.dart`
