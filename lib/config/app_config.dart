/// App configuration for JSON widget loading
class AppConfig {
  // Configure your JSON URL here
  // Set to null to use only local sample data
  static const String? jsonUrl = 'https://example.com/widget.json';
  
  // Alternative: Use local sample data only
  // static const String? jsonUrl = null;
  
  // Alternative: Use a different URL
  // static const String? jsonUrl = 'https://your-api.com/widgets/demo.json';
  
  /// Get the configured JSON URL
  static String? get configuredJsonUrl => jsonUrl;
  
  /// Check if we should try to load from URL
  static bool get shouldLoadFromUrl => jsonUrl != null && jsonUrl!.isNotEmpty;
}
