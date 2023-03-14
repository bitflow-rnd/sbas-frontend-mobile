import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiProvider {
  static final String _baseUrl = dotenv.env['BASE_URL']!;

  static String loginUrl = '$_baseUrl/v1/test/login';
}
