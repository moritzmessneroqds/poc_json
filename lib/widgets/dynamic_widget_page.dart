import 'package:flutter/material.dart';
import 'package:dynamic_widget/dynamic_widget.dart';
import '../services/json_data_service.dart';

/// Page that displays dynamic widgets loaded from JSON
class DynamicWidgetPage extends StatefulWidget {
  final String? jsonUrl;
  final String? jsonData;

  const DynamicWidgetPage({
    super.key,
    this.jsonUrl,
    this.jsonData,
  });

  @override
  State<DynamicWidgetPage> createState() => _DynamicWidgetPageState();
}

class _DynamicWidgetPageState extends State<DynamicWidgetPage> {
  final JsonDataService _jsonService = JsonDataService();
  Widget? _dynamicWidget;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadDynamicWidget();
  }

  Future<void> _loadDynamicWidget() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      String? jsonString;

      if (widget.jsonData != null) {
        // Use provided JSON data
        jsonString = widget.jsonData;
      } else if (widget.jsonUrl != null) {
        try {
          // Try to load JSON from URL first
          jsonString = await _jsonService.loadJsonFromUrl(widget.jsonUrl!);
        } catch (e) {
          // If URL fails, fall back to local sample data
          print('Failed to load from URL: $e');
          print('Falling back to local sample data');
          jsonString = _jsonService.getSampleJsonData();
        }
      } else {
        // Use sample data as fallback
        jsonString = _jsonService.getSampleJsonData();
      }

      if (jsonString != null) {
        final widget = await DynamicWidgetBuilder.build(
          jsonString,
          context,
          _DefaultClickListener(),
        );
        
        setState(() {
          _dynamicWidget = widget;
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = 'No JSON data available';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error loading dynamic widget: $e\n\nThis might be due to:\n• Invalid JSON format\n• Unsupported widget properties\n• Missing required fields\n• Type mismatch in JSON values';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Loading dynamic widget...'),
            ],
          ),
        ),
      );
    }

    if (_errorMessage != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
          backgroundColor: Colors.red,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red,
              ),
              const SizedBox(height: 16),
              Text(
                'Error:',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  _errorMessage!,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _loadDynamicWidget,
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    return _dynamicWidget ?? const SizedBox.shrink();
  }
}

/// Default click listener for handling button clicks and other events
class _DefaultClickListener implements ClickListener {
  @override
  void onClicked(String? event) {
    print('Button clicked: $event');
    
    // Handle different types of click events
    if (event != null) {
      if (event.startsWith('route://')) {
        _handleRouteEvent(event);
      } else if (event.startsWith('action://')) {
        _handleActionEvent(event);
      } else {
        _handleGenericEvent(event);
      }
    }
  }
  
  void _handleRouteEvent(String event) {
    // Extract route information from event
    final uri = Uri.parse(event);
    final path = uri.path;
    final queryParams = uri.queryParameters;
    
    print('Navigation requested: $path');
    print('Query parameters: $queryParams');
    
    // Here you can implement actual navigation logic
    // For example, using Navigator.pushNamed or go_router
  }
  
  void _handleActionEvent(String event) {
    // Handle custom actions
    print('Action requested: $event');
  }
  
  void _handleGenericEvent(String event) {
    // Handle generic events
    print('Generic event: $event');
  }
}
