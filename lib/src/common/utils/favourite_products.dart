import '../../core/infrastructure/datasources/local/storage.dart';

class FavouriteProductsUntil {
  FavouriteProductsUntil._();

  static bool isFavourite(int id) {
    var user = Storage.user;

    if (user != null) {
      List<int> listFavourite = user.favouriteProducts;
      return listFavourite.contains(id);
    }
    return false;
  }

  static bool removeFromFavourite(int id) {
    var user = Storage.user;
    if (user != null) {
      var oldFavouriteProducts = List.of(user.favouriteProducts);
      oldFavouriteProducts.remove(id);
      var newUser = user.copyWith(favouriteProducts: oldFavouriteProducts);
      Storage.setUser(newUser);
      return true;
    }
    return false;
  }

    static bool addToFavourite(int id) {
    var user = Storage.user;
    if (user != null) {
      var oldFavouriteProducts = List.of(user.favouriteProducts);
      oldFavouriteProducts.add(id);
      var newUser = user.copyWith(favouriteProducts: oldFavouriteProducts);
      Storage.setUser(newUser);
      return true;
    }
    return false;
  }
}
