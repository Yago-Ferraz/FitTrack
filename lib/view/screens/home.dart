import 'package:fittrack/view/components/bodyhome.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../components/head.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    print('reconstrucao da tela');
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: header(size: size),
      body: bodyt(),
    );
  }
}
