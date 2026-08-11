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

final class DatabaseFailure extends AppFailure {
  const DatabaseFailure(super.safeMessage);
}

final class EntityNotFoundFailure extends AppFailure {
  const EntityNotFoundFailure(super.safeMessage);
}

final class DuplicateEntityFailure extends AppFailure {
  const DuplicateEntityFailure(super.safeMessage);
}

final class InvalidEntityFailure extends AppFailure {
  const InvalidEntityFailure(super.safeMessage);
}

final class ReferentialIntegrityFailure extends AppFailure {
  const ReferentialIntegrityFailure(super.safeMessage);
}

final class TransactionFailure extends AppFailure {
  const TransactionFailure(super.safeMessage);
}

final class MigrationFailure extends AppFailure {
  const MigrationFailure(super.safeMessage);
}

final class GachadexPackageFailure extends AppFailure {
  const GachadexPackageFailure(super.safeMessage);
}

final class GachadexPackageCanceled extends AppFailure {
  const GachadexPackageCanceled() : super('Operacion cancelada.');
}
