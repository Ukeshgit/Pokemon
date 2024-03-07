import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon/modules/home/view/mobile_layout_screen.dart';
import 'package:pokemon/modules/home/view/mobile_layout_screen.dart';
import 'package:pokemon/modules/home/view/web_layout_screen.dart';
import 'package:pokemon/utils/responsive_layout.dart';



void main() {
  runApp(const ProviderScope(child: PokeDex()));
}

class PokeDex extends StatelessWidget {
  const PokeDex({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProviderScope(child: ResponsiveLayout(mobileScreenLayout: MobileLayoutScreen(), webScreenLayout: WebLayoutScreen())),
    );
  }
}


