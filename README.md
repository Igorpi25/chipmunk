# Price Tracker

Demo project for Flutter/BLoC(Cubit)/Websocket stack. Author made practice on CleanArchitecture and Solid. Somewhere you can meet unit-tests remaining after authors TDD plays.

## Table Of Contents

- [Architecture](#architecture-layers)
  * [Domain](#domain)
  * [Data](#data)
  * [Presentation](#presentation)
- [Features overview](#features-overview)
  * [Forget subscription](#forget-subscription)
  * [Price text color](#price-text-color)

## Architecture

In this demonstration app we use only some Layers presented in Clean Architecture approach:

- [domain/]()
- [data/]()
- [presentation/]()

### Domain

Here we have domain model(data classes on which other architecture layers are tied) 
and abstract repositories, used in presentation layer. 
Implementatio of repositories you can find in `data/network`

- [domain/]()
  * [model/]()
    * asset.dart
    * market.dart
    * price.dart
  * [repository/]()
    * asset_repository.dart
    * market_repository.dart
    * price_repository.dart

### Data

The core of Data layer is placed in `data/network/repository`. All others are serving and providing the implementation of repositories.
Abstract `network_service.dart` is created for have grained control for test implementation. Real work with Websocket communication is isolated in `binary_network_service`.

**network_util.dart**
This class untended to be single data-layer dependency in repositories implementation (other parts are not stick outside of data-layer). 
So total you have to see to understant the meaning of `data/network` are: `network_util.dart`, `binary_network_service.dart`. 

**cache_service.dart**
Used to store the result of `active_symbol_request` in cache map. We do this to avoid repeated request every time when we change Market or Asset in `tracker_page`. 

*WARNING! Keeping  `CacheService` as private property is not Clean Acrhitecture way. Don't do like this. It's better to take `CacheService` as constructor argument, to have testing and mocking flexibility. It due to be refactored hereafter*

- [data/]()
  * [network/]()
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

### Presentation

Consists from two page: `tracker_page`, `tracker_page`:

1. Loader page hasn't any business logic. Initial loader screen's Bloc is placed in app.dart, there we use "special" `common_bloc/loader`, please look below.
2. Tracker consists from three nested views: markets_section, assets_section, price_section. Each of them depends on other: `markets(assets(price))`. Required repositories are injected from app.dart through engines context.read<T>. 


- [presentation/]()
  * [common_bloc (cubit & state)]()
    * loader
  * [page/]()
    * [tracker/]()
      * [block(cubit & state)/]()
        * market
        * asset
        * price
      * [view/]()
        * assets_section.dart
        * markets_section.dart
        * price_section.dart
      * [viewmodel/]()
        * asset_dropdown_viewmodel.dart
        * market_dropdown_viewmodel.dart
      * tracker_page.dart
    * [loader/]
      * loader_page.dart
- [ui_kit/]()
  * dropdown.dart

**common_bloc/loader**

Used to display some LoadingState while await for `Future<T>`. There two cases within app:
1. Wait for 'List<Market>'. Show LoadingPage while await
2. Load List<Asset> after click on market.
 
*Please, don't wonder when see `typedef`, it's just a Demo*
 
**dropdown.dart & viewmodels**
 
Flutter's default DropdownButton widget has extremely unconvinient and leads to "spaghetti code". Author made his own implementation based on DropdownButton. *It didn't help much, indeed*

## Features overview
 
### Forget subscription

When Flutter engine make deattaching `PriceCubit` from Widgets tree it calls `PriceCubit.close()`, inside of that we calling `priceRepository.stopTicking(_asset);` where `_asset` is `Asset`(domain model).

Then inside `NetworkUtil` we call `forgetTick()`. The idea of this method is to hookup proper `Tick` response with necessary `subscriptionId`. After hook we send `forget_request(subscriptionID)` only for specified subscription. Mechanism is non-trivial, but helps to avoid keep additional `Map<Asset, subcriptionID>`


### Price text color

Please, take your look on `presentation/page/tracker/block/`. Here is `price_cubit.dart` inside which `_getSplittedPriceValue(prev, next)` method. This method compares `prev` and `next` and return "colored" PriceState.

`PriceData` state is splitted to three: `GrowingValue`, `DecreasingValue`, `StandingValue` child states. 
 
 And, please, open `price_section.dart` from `presentation/page/tracker/view/`, here you'd find _priceColorByState() method where splitted states become to material color.
 
