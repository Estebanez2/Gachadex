import 'app_exception.dart';
import 'app_failure.dart';

abstract final class ErrorMapper {
  static AppFailure toFailure(Object error, {required String fallbackMessage}) {
    if (error is AppFailure) {
      return error;
    }

    if (error is AppException) {
      return UnexpectedFailure(error.safeMessage ?? fallbackMessage);
    }

    return UnexpectedFailure(fallbackMessage);
  }
}
