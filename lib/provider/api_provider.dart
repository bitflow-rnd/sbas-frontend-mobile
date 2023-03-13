import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiProvider {
  static String baseUrl = dotenv.env['BASE_URL']!;
}
