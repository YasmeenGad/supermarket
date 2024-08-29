abstract class Failure {
  final String message;
  const Failure(this.message);
}

// Network Failures
abstract class NetworkFailure extends Failure {
  const NetworkFailure(String message) : super(message);
}

class TimeoutFailure extends NetworkFailure {
  const TimeoutFailure() : super('Connection timed out. Please try again.');
}

class NoInternetFailure extends NetworkFailure {
  const NoInternetFailure()
      : super('No internet connection. Please check your network settings.');
}

// Server-side Failures
class ServerFailure extends Failure {
  final int statusCode;
  const ServerFailure(String message, this.statusCode) : super(message);
}

class InternalServerErrorFailure extends ServerFailure {
  const InternalServerErrorFailure()
      : super('Internal server error. Please try again later.', 500);
}

class CacheFailure extends Failure {
  const CacheFailure({String message = 'No data found in cache'})
      : super(message);
}

// General Failure for any unspecified errors
class GeneralFailure extends Failure {
  const GeneralFailure(String message) : super(message);
}
