import 'package:fittrack/model/dao.dart';
import 'package:fittrack/view/components/ExercicioSet.dart';
import 'package:flutter/material.dart';

class Treinamento extends StatefulWidget {
  final List<exercicio>? data;
  Treinamento({super.key, required this.data});

  @override
  State<Treinamento> createState() => _Treinamento();
}

class _Treinamento extends State<Treinamento> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        for (var wid in widget.data!) wid,
        ElevatedButton(
            onPressed: () {
              for (var wid in widget.data!) {
                dao().delete(wid.name);
              }
            },
            child: Text('apagar'))
      ]),
    );
  }
}
