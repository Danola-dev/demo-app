import 'package:demo_app/models/shoes.dart';
import 'package:flutter_riverpod/legacy.dart';

class FavoriteShoeNotifier extends StateNotifier<List<Shoes>> {
  FavoriteShoeNotifier() : super([]);

  bool toggleFavoriteShoe(Shoes shoe) {
    final shoeIsFavorite = state.contains(shoe);
    if (shoeIsFavorite) {
      state = state.where((newShoe) {
        return newShoe.id != shoe.id;
      }).toList();
      return false;
    } else {
      state = [...state, shoe];
      return true;
    }
  }

  void removeFavorite(Shoes shoe) {
    state = state.where((item) {
      return item.id != shoe.id;
    }).toList();
  }
}

final favoriteShoeProvider =
    StateNotifierProvider<FavoriteShoeNotifier, List<Shoes>>((ref) {
      return FavoriteShoeNotifier();
    });
