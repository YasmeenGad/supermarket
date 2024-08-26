class ServerException implements Exception {
  final String message;
  final int statusCode;

  ServerException(this.message, this.statusCode);
}

class CacheException implements Exception {}

class NoInternetException implements Exception {}