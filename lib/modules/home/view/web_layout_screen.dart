import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokemon/ui/widgets/pokecard.dart';

class WebLayoutScreen extends StatelessWidget {
  const WebLayoutScreen({super.key});

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
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        hintText: "E.g. Pikachu",
                        hintStyle: const TextStyle(color: Colors.grey, fontSize: 18),
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
                  const SizedBox(height: 20,)
                ],
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              color: Colors.white,
              child: GridView.builder(
                itemCount: 12,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemBuilder: (context, index) => const PokeCard()),
              ),
            ),
          
        ],
      ),
    );
  }
}