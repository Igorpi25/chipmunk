# Price Tracker

Demo project for Flutter/BLoC(Cubit)/Websocket stack. Author made practice on CleanArchitecture and Solid. Somewhere you can meet unit-tests remaining after authors TDD plays.

## Live sample:

<img src="../media/screenshot_tracker_1.png?raw=true" height="300">

[Click to open](https://igorpi25.com/chipmunk/#/)

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

- [domain/](lib/domain/)
- [data/](lib/data/)
- [presentation/](lib/presentation/)

### Domain

Here we have domain model(data classes on which other architecture layers are tied) 
and abstract repositories, used in presentation layer. 
Implementation of repositories you can find in [`data/network`](lib/data/network/)

- [domain/](lib/domain/)
  * [model/](lib/domain/model/)
    * asset.dart
    * market.dart
    * price.dart
  * [repository/](lib/domain/repository/)
    * [asset_repository.dart](lib/domain/repository/asset_repository.dart)
    * [market_repository.dart](lib/domain/repository/market_repository.dart)
    * [price_repository.dart](lib/domain/repository/price_repository.dart)

### Data

The core of Data layer is placed in [`data/network/repository`](lib/data/network/repository/). All others are serving and providing the implementation of repositories.
Abstract [`network_service.dart`](lib/data/network/service/network_service.dart) is created to have the grained control for the test implementation. The real work with Websocket is isolated in [`binary_network_service.dart`](lib/data/network/service/binary_network_service.dart).

**network_util.dart**
This class is untended to be the single data-layer dependency in repositories implementations (therefore other classes don't stick outside of the data-layer). 
So all you need to understant the idea of `data/network` layer are: [`network_util.dart`](lib/data/network/network_util.dart), [`binary_network_service.dart`](lib/data/network/service/binary_network_service.dart). 

**cache_service.dart**
Used to store the result of `active_symbol_request` in cached Map. We do this to avoid repeating the request every time when we change Market or Asset in `tracker_page`. 

*WARNING! Keeping  `CacheService` as private property is not Clean Acrhitecture way. Don't do like this. It's better to take `CacheService` as constructor argument, to have testing and mocking flexibility. It due to be refactored hereafter*

- [data/](lib/data/)
  * [network/](lib/data/network/)
    * [mapper/](lib/data/network/mapper/)
      * [asset_mapper.dart](lib/data/network/mapper/asset_mapper.dart)
      * [market_mapper.dart](lib/data/network/mapper/market_mapper.dart)
      * [price_mapper.dart](lib/data/network/mapper/price_mapper.dart)
    * [model/](lib/data/network/model/)
      * [symbol.dart](lib/data/network/model/symbol.dart)
      * [tick.dart](lib/data/network/model/tick.dart)
    * [repository/](lib/data/network/repository/)
      * [network_asset_repository.dart](lib/data/network/repository/network_asset_repository.dart)
      * [network_market_repository.dart](lib/data/network/repository/network_market_repository.dart)
      * [network_price_repository.dart](lib/data/network/repository/network_price_repository.dart)
    * [request/](lib/data/network/request/)
      * [request.dart](lib/data/network/request/request.dart)
      * [active_symbol_request.dart](lib/data/network/request/active_symbol_request.dart)
      * [forget_request.dart](lib/data/network/request/forget_request.dart)
      * [tick_request.dart](lib/data/network/request/tick_request.dart)
    * [response/](lib/data/network/response/)
      * [response.dart](lib/data/network/response/response.dart)
      * [active_symbol_response.dart](lib/data/network/response/active_symbol_response.dart)
      * [forget_response.dart](lib/data/network/response/forget_response.dart)
      * [tick_response.dart](lib/data/network/response/tick_response.dart)
    * [service/](lib/data/network/service/)
      * [network_service.dart](lib/data/network/service/network_service.dart)
      * [cache_service.dart](lib/data/network/service/cache_service.dart)
      * [binary_network_service.dart](lib/data/network/service/binary_network_service.dart)
    * [network_util.dart](lib/data/network/network_util.dart)

### Presentation

Consists from two page: `loader_page`, `tracker_page`:
<img src="../media/screenshot_loader.png?raw=true" height="400">  |  <img src="../media/screenshot_tracker_0.png?raw=true" height="400"> | <img src="../media/screenshot_tracker_1.png?raw=true" height="400"> |
:-------------------------:|:-------------------------:|:-------------------------:
`loader_page.dart`             |  `tracker_page.dart`(markets) | `tracker_page.dart`(markets/assets/price) |

1. Loader page hasn't any business logic. Initial loader screen's Bloc is placed in app.dart, there we use "special" `common_bloc/loader`, please look below.
2. Tracker consists from three nested views: markets_section, assets_section, price_section. Each of them depends on other: `markets(assets(price))`. Required repositories are injected from app.dart through engines context.read<T>. 


- [presentation/](lib/presentation/)
  * [common_bloc (cubit & state)](lib/presentation/common_bloc/)
    * [loader_cubit.dart](lib/presentation/common_bloc/loader_cubit.dart)
    * [loader_state.dart](lib/presentation/common_bloc/loader_state.dart)
  * [page/](lib/presentation/page/)
    * [tracker/](lib/presentation/page/tracker/)
      * [bloc(cubit & state)/](lib/presentation/page/tracker/bloc)
        * market
        * asset
        * price
      * [view/](lib/presentation/page/tracker/view/)
        * [assets_section.dart](lib/presentation/page/tracker/view/assets_section.dart)
        * [markets_section.dart](lib/presentation/page/tracker/view/markets_section.dart)
        * [price_section.dart](lib/presentation/page/tracker/view/price_section.dart)
      * [viewmodel/](lib/presentation/page/tracker/viewmodel/)
        * [asset_dropdown_viewmodel.dart](lib/presentation/page/tracker/viewmodel/asset_dropdown_viewmodel.dart)
        * [market_dropdown_viewmodel.dart](lib/presentation/page/tracker/viewmodel/market_dropdown_viewmodel.dart)
      * [tracker_page.dart](lib/presentation/page/tracker/tracker_page.dart)
    * [loader/](lib/presentation/page/loader/)
      * [loader_page.dart](lib/presentation/page/loader/loader_page.dart)
- [ui_kit/](lib/ui_kit/)
  * [dropdown.dart](lib/ui_kit/dropdown.dart)

**common_bloc/loader**

Used to display some LoadingState while await for `Future<T>`. There two cases within app:
1. Wait for 'List<Market>'. Show `loader_page` while await
2. Load List<Asset> after click on `market`.
 
*Please, don't wonder when see `typedef`, it's just a Demo*
 
**dropdown.dart & viewmodels**
 
Flutter's default DropdownButton widget has extremely unconvinient and leads to "spaghetti code". Author made his own implementation based on DropdownButton. *It didn't help much, indeed*

## Features overview
 
### Forget subscription

When Flutter engine make deattaching `PriceCubit` from Widgets tree it calls [`PriceCubit.close()`](lib/presentation/page/tracker/bloc/price_cubit.dart), inside of that we calling [`priceRepository.stopTicking(_asset);`](lib/data/network/repository/network_price_repository.dart) where `_asset` is [`Asset`](lib/domain/model/asset.dart)(domain model).

Then inside [`NetworkUtil`](lib/data/network/network_util.dart) we call `forgetTick()`. The idea of this method is to hookup proper `Tick` response with necessary `subscriptionId`. After hook we send `forget_request(subscriptionID)` only for specified subscription. Mechanism is non-trivial, but helps to avoid keeping an additional `Map<Asset, subcriptionID>`


### Price text color

Please, take your look on `presentation/page/tracker/block/`. Here is [`price_cubit.dart`](presentation/page/tracker/block/price_cubit.dart) inside which we have `_getSplittedPriceValue(prev, next)` method. This method compares `prev` and `next` and return "colored" [`PriceState`](lib/presentation/page/tracker/bloc/price_state.dart).

The `PriceData` state is splitted to three: `GrowingValue`, `DecreasingValue`, `StandingValue` child states. 
 
And, please, open [`price_section.dart`](presentation/page/tracker/view/price_section.dart) from `presentation/page/tracker/view/`, here you'd find _priceColorByState() method where splitted states become to material color.
 
