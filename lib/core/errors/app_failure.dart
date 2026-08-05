sealed class AppFailure {
  const AppFailure(this.safeMessage);

  final String safeMessage;
}

final class UnexpectedFailure extends AppFailure {
  const UnexpectedFailure(super.safeMessage);
}

final class ValidationFailure extends AppFailure {
  const ValidationFailure(super.safeMessage);
}

final class NavigationFailure extends AppFailure {
  const NavigationFailure(super.safeMessage);
}
