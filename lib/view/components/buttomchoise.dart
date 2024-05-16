import 'package:fittrack/model/bt.dart';
import 'package:fittrack/model/dao.dart';
import 'package:flutter/material.dart';
import 'ExercicioSet.dart';

class buttomchoise extends StatelessWidget {
  final int numero;
  final press;
  final tap;
  buttomchoise(
      {super.key,
      required this.numero,
      required this.press,
      required this.tap});
  List<exercicio> tolist(List<Map<String, dynamic>> mapadetarefas) {
    final List<exercicio> sets = [];

    for (Map<String, dynamic> linha in mapadetarefas) {
      final exercicio set = exercicio(
        peso: linha['peso'],
        repeticao: linha['repeticao'],
        name: linha['name'],
        numero: linha['numero'],
        fuc: () {},
      );
      sets.add(set);
    }
    return sets;
  }

  apagarcard() async {
    final dados = tolist(await dao().findnumber(this.numero));
    for (var d in dados) {
      dao().delete(d.name);
      this.tap(this.numero - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          this.tap(this.numero);
        },
        child: Text(this.numero.toString()),
        onLongPress: () {
          bt().delete(this.numero);
          this.press();
          apagarcard();
        });
  }
}
