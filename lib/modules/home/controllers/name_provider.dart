import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon/modules/home/controllers/api_services.dart';

final pokemonDetailProvider =
    FutureProvider.family<Map<String, dynamic>, String>((ref, url) async {
  return ref.watch(nameProvider).fetchPokemonDetails(url);
});

final searchPokemonProvider = 
  FutureProvider.family<List<Map<String, dynamic>>, String>((ref, query) async {
    print("Hello");
  return ref.watch(nameProvider).searchPokemon(query);
});
