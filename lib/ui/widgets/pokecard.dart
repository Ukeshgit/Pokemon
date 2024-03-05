import 'package:flutter/material.dart';
import 'package:pokemon/datas/colors.dart';

class PokeCard extends StatelessWidget {
  const PokeCard({super.key, required this.name, required this.imageUrl, required this.type});

  final String name;
  final String imageUrl; 
  final List<String> type;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(20)),
      alignment: Alignment.bottomRight,
      child: Card(
        margin: const EdgeInsets.all(2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Text(name, style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 16),),
              ],
            ),
            Image.network(
              imageUrl,
              height: 110,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for(String value in type)
                  Card(color: pokemonTypeColors[value.toUpperCase()] ,child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                    child: Text(value, style: const TextStyle(color: Colors.white),),
                  ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
