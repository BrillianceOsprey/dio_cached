import 'package:path_provider/path_provider.dart' as pp;

class AppPathProvider {
  AppPathProvider._();

  static String? _path;

  static String get path {
    print('get path: $_path');
    if (_path != null) {
      return _path!;
    } else {
      throw Exception('path not initialized');
    }
  }

  static Future<void> initPath() async {
    final dir = await pp.getApplicationDocumentsDirectory();
    _path = dir.path;
    print('initPath: $_path');
  }
}
