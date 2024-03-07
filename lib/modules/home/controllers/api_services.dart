import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class ApiServices{
  // Method to fetch all pokemons
  Future<List<Map<String, dynamic>>> fetchAllPokemons() async {
    final response = await http
        .get(Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=2000'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> results = data['results'];
      return results.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to load pokemons');
    }
  }

  // Method to fetch details of a specific pokemon
  Future<Map<String, dynamic>> fetchPokemonDetails(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to load pokemon details');
    }
  }

  // Method to filter pokemons based on a search query
  Future<List<Map<String, dynamic>>> filterPokemons(String query) async {
    final List<Map<String, dynamic>> allPokemons = await fetchAllPokemons();
    final List<Map<String, dynamic>> filteredPokemons = allPokemons
        .where((pokemon) => pokemon['name']
            .toString()
            .toLowerCase()
            .contains(query.toLowerCase()))
        .toList();
    return filteredPokemons;
  }

  Future<List<Map<String, dynamic>>> searchPokemon(String query) async {
    if (query.isEmpty) {
        return fetchAllPokemons();
    } else {
        return filterPokemons(query);
    }
  }

}


final nameProvider = Provider<ApiServices>((ref)=> ApiServices());