final class PackRechargeResult {
  const PackRechargeResult({
    required this.availableCount,
    required this.nextRechargeAtUtc,
    required this.generatedCount,
    required this.reachedMaximum,
  });

  final int availableCount;
  final DateTime nextRechargeAtUtc;
  final int generatedCount;
  final bool reachedMaximum;

  bool changedFrom({
    required int previousAvailableCount,
    required DateTime previousNextRechargeAtUtc,
  }) {
    return availableCount != previousAvailableCount ||
        nextRechargeAtUtc != previousNextRechargeAtUtc;
  }
}

final class PackRechargeCalculator {
  const PackRechargeCalculator();

  PackRechargeResult calculate({
    required int availableCount,
    required int maxAccumulated,
    required int rechargeSeconds,
    required DateTime nextRechargeAtUtc,
    required DateTime currentTimeUtc,
  }) {
    if (rechargeSeconds <= 0 || maxAccumulated <= 0) {
      throw ArgumentError('Invalid recharge configuration.');
    }
    final now = currentTimeUtc.toUtc();
    final next = nextRechargeAtUtc.toUtc();
    final clampedAvailable = availableCount.clamp(0, maxAccumulated);
    if (clampedAvailable >= maxAccumulated) {
      return PackRechargeResult(
        availableCount: maxAccumulated,
        nextRechargeAtUtc: next,
        generatedCount: 0,
        reachedMaximum: true,
      );
    }
    if (now.isBefore(next)) {
      return PackRechargeResult(
        availableCount: clampedAvailable,
        nextRechargeAtUtc: next,
        generatedCount: 0,
        reachedMaximum: false,
      );
    }

    final interval = Duration(seconds: rechargeSeconds);
    var generated = 0;
    var newAvailable = clampedAvailable;
    var newNext = next;
    while (!now.isBefore(newNext) && newAvailable < maxAccumulated) {
      generated += 1;
      newAvailable += 1;
      newNext = newNext.add(interval);
    }

    return PackRechargeResult(
      availableCount: newAvailable,
      nextRechargeAtUtc: newAvailable >= maxAccumulated ? newNext : newNext,
      generatedCount: generated,
      reachedMaximum: newAvailable >= maxAccumulated,
    );
  }

  DateTime nextAfterConsumed({
    required int previousAvailableCount,
    required int newAvailableCount,
    required int maxAccumulated,
    required int rechargeSeconds,
    required DateTime currentTimeUtc,
    required DateTime currentNextRechargeAtUtc,
  }) {
    if (previousAvailableCount >= maxAccumulated &&
        newAvailableCount < maxAccumulated) {
      return currentTimeUtc.toUtc().add(Duration(seconds: rechargeSeconds));
    }

    return currentNextRechargeAtUtc.toUtc();
  }
}
