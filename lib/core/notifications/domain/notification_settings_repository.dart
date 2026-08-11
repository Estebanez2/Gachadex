abstract interface class NotificationSettingsRepository {
  Stream<bool> watchPackNotificationsEnabled();

  Future<bool> arePackNotificationsEnabled();

  Future<void> setPackNotificationsEnabled(bool enabled);
}
