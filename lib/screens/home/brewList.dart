import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:crew_brew/model/brew.dart';
import 'package:crew_brew/screens/home/brew_tile.dart';

class Brewlist extends StatefulWidget {
  const Brewlist({super.key});

  @override
  State<Brewlist> createState() => _BrewlistState();
}

class _BrewlistState extends State<Brewlist> {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<Brew>>(context)??[];
    return ListView.builder(
      itemCount: brews.length,
      itemBuilder: (context, index){
        return BrewTile(brew:brews[index]);

      },

    );
  }
}
