import 'package:flutter/material.dart';
import 'package:crew_brew/model/brew.dart';

class BrewTile extends StatelessWidget {
  final Brew brew;

  const BrewTile({super.key,required this.brew});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(8),
        child: Card(
        margin: EdgeInsets.all(20),
          child: ListTile(
            leading: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.brown[brew.strength],
            ),
            title: Text(brew.name),
            subtitle: Text('Takes ${brew.sugars} sugar(s)'),
          ),
    ),
    );
  }
}
