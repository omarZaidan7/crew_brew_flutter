import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crew_brew/model/user.dart';
import 'package:crew_brew/services/Loading.dart';
import 'package:crew_brew/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4', '5'];

  String? _currentName;
  String? _currentSugars;
  int? _currentStrength;

  @override
  Widget build(BuildContext context) {
    final myUser = Provider.of<MyUser?>(context);
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: myUser!.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          UserData userData = snapshot.data!;
          return Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Update Brew Settings',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 20),

                TextFormField(
                  initialValue: userData.name,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (val) => val == null || val.isEmpty ? 'Please enter a name' : null,
                  onChanged: (val) => setState(() => _currentName = val),
                ),

                const SizedBox(height: 20),

                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Sugars',
                    border: OutlineInputBorder(),
                  ),
                  value: _currentSugars ?? userData.sugars,
                  items: sugars.map((sugar) {
                    return DropdownMenuItem(
                      value: sugar,
                      child: Text('$sugar sugars'),
                    );
                  }).toList(),
                  onChanged: (val) => setState(() => _currentSugars = val),
                  validator: (val) => val == null ? 'Please select sugar amount' : null,
                ),

                const SizedBox(height: 20),
                Slider(
                  value: (_currentStrength ?? userData.strength).toDouble(),
                  activeColor: Colors.brown[_currentStrength ?? userData.strength],
                  inactiveColor: Colors.brown[_currentStrength ?? userData.strength],
                  min: 100,
                  max: 900,
                  divisions: 8,
                  onChanged: (val){
                    setState(() {
                      _currentStrength = val.round();
                    });
                  },
                ),
                const SizedBox(height: 20),

                // Update button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    onPressed: () async{
                      if (_formKey.currentState!.validate()) {
                          await DatabaseService(uid: myUser.uid).updateUserData(
                            _currentSugars ?? userData.sugars,
                            _currentName ?? userData.name,
                            _currentStrength ?? userData.strength
                          );
                          Navigator.pop(context);
                      }
                    },
                    child: const Text(
                      'Update',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          );

        }
        else{
          return Loading();

        }


      }
    );
  }

}

