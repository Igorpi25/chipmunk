const _delay = Duration(seconds: 1);

class PriceRepository {
  Stream<String> tick(String asset) {
    return Stream.periodic(_delay, (_) => '$asset : $_');
  }
}
