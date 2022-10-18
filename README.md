# Price Tracker

Demo project for Flutter/BLoC(Cubit)/Websocket stack. Author made practice on CleanArchitecture and Solid. Somewhere you can meet unit-tests remaining after authors TDD plays.

## Architecture

- [domain]()
  * [model]()
    * asset.dart
    * market.dart
    * price.dart
  * [repository]()
    * asse_repository.dart
    * market_repository.dart
    * price_repository.dart
- [data]()
  * [network]()
    * [mapper/]()
      * asset_mapper.dart
      * market_mapper.dart
      * price_mapper.dart
    * [model/]()
      * symbol.dart
      * tick.dart
    * [repository/]()
      * network_asset_repository.dart
      * network_market_repository.dart
      * network_price_repository.dart
    * [request/]()
      * request.dart
      * active_symbol_request.dart
      * forget_request.dart
      * tick_request.dart
    * [response/]()
      * request.dart
      * active_symbol_response.dart
      * forget_request.dart
      * tick_response.dart
    * [service/]()
      * network_service.dart
      * cache_service.dart
      * binary_network_service.dart
    * network_util.dart
- [presentation]()
- [ui_kit]()

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
