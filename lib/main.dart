import 'package:flutter/material.dart';
import 'package:pokemon/modules/home/view/mobile_layout_screen.dart';
import 'package:pokemon/modules/home/view/web_layout_screen.dart';
import 'package:pokemon/utils/responsive_layout.dart';


void main() {
  runApp(const PokeDex());
}

class PokeDex extends StatelessWidget {
  const PokeDex({super.key});

  @override
  Widget build(BuildContext context) {
    return const  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ResponsiveLayout(mobileScreenLayout: MobileLayoutScreen(), webScreenLayout: WebLayoutScreen()),
    );
  }
}


