class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl = '';

  // Android emulator
  //static const String baseUrl = 'http://10.0.2.2:8080/';

  // iOS simulator
  //static const String baseUrl = 'http://localhost:8080/';

  // receiveTimeout
  static const Duration receiveTimeout = Duration(milliseconds: 30000);

  // connectTimeout
  static const Duration connectionTimeout = Duration(milliseconds: 30000);
}
