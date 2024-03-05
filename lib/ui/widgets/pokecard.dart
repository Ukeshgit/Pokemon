import 'package:flutter/material.dart';

class PokeCard extends StatelessWidget {
  const PokeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xfffaf5cd),
        borderRadius: BorderRadius.circular(20)
      ),
    );
  }
}