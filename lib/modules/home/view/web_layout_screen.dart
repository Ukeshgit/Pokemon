import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokemon/ui/widgets/pokecard.dart';

class WebLayoutScreen extends StatefulWidget {
  const WebLayoutScreen({super.key});

  @override
  State<WebLayoutScreen> createState() => _WebLayoutScreenState();
}

class _WebLayoutScreenState extends State<WebLayoutScreen> {
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

  Future<Map<String, dynamic>> fetchPokemonDetails(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to load pokemon details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff072ac8),
      body: Column(
        children: [
          const SizedBox(height: 30),
          Container(
            color: const Color(0xff072ac8),
            child: Center(
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/pokeball.png",
                    height: 70,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Who are you looking for?",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25.0, vertical: 10),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {});
                      },
                      decoration: InputDecoration(
                          hintText: "E.g. Pikachu",
                          hintStyle:
                              const TextStyle(color: Colors.grey, fontSize: 18),
                          contentPadding: const EdgeInsets.all(9),
                          prefixIcon: const Icon(
                            CupertinoIcons.search,
                            size: 30,
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25)),
                          fillColor: Colors.white,
                          filled: true),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              color: Colors.white,
              child: Center(
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: fetchAllPokemons(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      final List<Map<String, dynamic>> pokemons =
                          snapshot.data!;
                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4),
                        itemCount: pokemons.length,
                        itemBuilder: (context, index) {
                          final pokemon = pokemons[index];
                          return FutureBuilder<Map<String, dynamic>>(
                            future: fetchPokemonDetails(pokemon['url']),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                final Map<String, dynamic> pokemonDetails =
                                    snapshot.data!;
                                final String imageUrl =
                                    pokemonDetails['sprites']['front_default'];
                                final List<dynamic> types =
                                    pokemonDetails['types'];
                                final List<String> typeNames = types
                                    .map<String>((type) => type['type']['name'])
                                    .toList();
                                return PokeCard(
                                    imageUrl: imageUrl,
                                    name: pokemon['name'],
                                    type: typeNames);
                              }
                            },
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
