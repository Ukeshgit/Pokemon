import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon/modules/home/controllers/name_provider.dart';
import 'package:pokemon/ui/widgets/pokecard.dart';

class MobileLayoutScreen extends ConsumerWidget {
  MobileLayoutScreen({super.key});

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context, ref) {
    var _pokemons =
        ref.watch(searchPokemonProvider(_searchController.text.trim()));
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
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            onChanged: (value) {
                              print(_searchController.text.trim());
                              _pokemons = ref.watch(searchPokemonProvider(
                                  _searchController.text.trim()));
                            },
                            controller: _searchController,
                            decoration: InputDecoration(
                                hintText: "E.g. Pikachu",
                                hintStyle: const TextStyle(
                                    color: Colors.grey, fontSize: 18),
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
                      ],
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
                child: _pokemons.when(
                    data: (data1) {
                      return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          itemCount: data1.length,
                          itemBuilder: (context, index) {
                            final pokemon = data1[index];

                            final _pokemonDetail = ref
                                .watch(pokemonDetailProvider(pokemon['url']));

                            return _pokemonDetail.when(
                                data: (data2) {
                                  final String imageUrl =
                                      data2['sprites']['front_default'];
                                  final List<dynamic> types = data2['types'];
                                  final List<String> typeNames = types
                                      .map<String>(
                                          (type) => type['type']['name'])
                                      .toList();

                                  return PokeCard(
                                      imageUrl: imageUrl,
                                      name: pokemon['name'],
                                      type: typeNames);
                                },
                                error: (error, stackTrace) =>
                                    Text(error.toString()),
                                loading: () => const Center(
                                      child: CircularProgressIndicator(),
                                    ));
                          });
                    },
                    error: (error, stackTrace) => Text(error.toString()),
                    loading: () => const Center(
                          child: CircularProgressIndicator(),
                        ))),
          ),
        ],
      ),
    );
  }
}
