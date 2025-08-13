import 'package:crew_brew/screens/home/brewList.dart';
import 'package:crew_brew/screens/home/settings_form.dart';
import 'package:crew_brew/services/authService.dart';
import 'package:flutter/material.dart';
import 'package:crew_brew/services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crew_brew/model/brew.dart';
import '../../model/user.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  Home({super.key});

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel(){

      showModalBottomSheet(context: context, builder: (context){
          return Container(
            padding: EdgeInsets.all(20),
            child: SettingsForm(),
          );
    });
  }
    final user = Provider.of<MyUser?>(context);

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService(uid: user!.uid).brews,
      initialData: const [], // Empty list instead of null

      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text('Home', style: TextStyle(color: Colors.white)),
          actions: [
            FloatingActionButton.extended(
              onPressed: () async {
                await _auth.signOut();
              },
              backgroundColor: Colors.black,
              label: const Text('Logout', style: TextStyle(color: Colors.white)),
              icon: const Icon(Icons.person, color: Colors.white),
              elevation: 0,
            ),
            FloatingActionButton.extended(
              onPressed: () async {
                _showSettingsPanel();
              },
              backgroundColor: Colors.black,
              label: const Text('Settings', style: TextStyle(color: Colors.white)),
              icon: const Icon(Icons.settings, color: Colors.white),
              elevation: 0,
            ),

          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/coffee_bg.png'),
            fit: BoxFit.fill
            ),
          ),
            child: const Brewlist()
        ),
      ),
    );
  }
}

