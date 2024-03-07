import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:pokemon/datas/colors.dart';

class PokeCard extends StatefulWidget {
  const PokeCard(
      {super.key,
      required this.name,
      required this.imageUrl,
      required this.type});

  final String name;
  final String imageUrl;
  final List<String> type;

  @override
  State<PokeCard> createState() => _PokeCardState();
}

class _PokeCardState extends State<PokeCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: Colors.grey.shade200, borderRadius: BorderRadius.circular(20)),
      alignment: Alignment.bottomRight,
      child: Card(
        margin: const EdgeInsets.all(2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.name,
                  style: const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ],
            ),
            CachedNetworkImage(
              key: UniqueKey(),
              cacheManager: CacheManager(Config(
                'cacheKey',
                stalePeriod: const Duration(hours: 1),
              )),
              imageUrl: widget.imageUrl,
              height: 100,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (String value in widget.type)
                  Card(
                      color: pokemonTypeColors[value.toUpperCase()],
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 8.0),
                        child: Text(
                          value,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
