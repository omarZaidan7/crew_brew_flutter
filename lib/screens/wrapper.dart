import 'package:crew_brew/model/user.dart';
import 'package:crew_brew/screens/auth/auth.dart';
import 'package:crew_brew/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {

    final myUser = Provider.of<MyUser?>(context);
    if(myUser == null){
      return Authenticate();
    }else{
      return Home();
    }

  }
}
