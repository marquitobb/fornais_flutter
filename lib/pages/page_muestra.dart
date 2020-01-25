import 'package:flutter/material.dart';
import 'package:fornite_flutter/future_json/futu_fornais.dart';

class detallePage extends StatelessWidget {
  final User user;

  detallePage(this.user);
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(user.name),
      ),
      body: Center(
        child: Image.network(user.imagen),
      ),
    );
  }
}

