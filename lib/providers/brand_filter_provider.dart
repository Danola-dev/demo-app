import 'package:demo_app/models/shoes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:demo_app/data/dummy_data.dart';
import 'package:flutter_riverpod/legacy.dart';

// Holds the selected brand — null means "All"
final selectedBrandProvider = StateProvider<String?>((ref) => null);

// Derives the filtered list automatically from the selected brand
final filteredShoesProvider = Provider<List<Shoes>>((ref) {
  final selectedBrand = ref.watch(selectedBrandProvider);

  if (selectedBrand == null) {
    return dummyShoes; // no filter, return everything
  }

  return dummyShoes.where((shoe) => shoe.category == selectedBrand).toList();
});
