import 'package:fittrack/model/dao.dart';
import 'package:fittrack/view/components/ExercicioSet.dart';
import 'package:fittrack/view/components/bodyhead.dart';
import 'package:fittrack/view/components/treinamento.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class bodyt extends StatefulWidget {
  bodyt({Key? key}) : super(key: key);

  @override
  _body createState() => _body();
}

class _body extends State<bodyt> {
  Future<List<Map<String, dynamic>>> _exerciciosFuture = dao().findnumber(1);
  var numero = 1;

  List<exercicio> tolist(List<Map<String, dynamic>>? mapadetarefas) {
    final List<exercicio> sets = [];
    if (mapadetarefas != null) {
      for (Map<String, dynamic> linha in mapadetarefas) {
        final exercicio set = exercicio(
          peso: linha['peso'],
          repeticao: linha['repeticao'],
          name: linha['name'],
          numero: linha['numero'],
          fuc: att,
        );
        sets.add(set);
      }
    }
    return sets;
  }

  att() {
    setState(() {
      _exerciciosFuture = dao().findnumber(numero);
    });
  }

  @override
  Widget build(BuildContext context) {
    atualizar(x) {
      setState(() {
        _exerciciosFuture = dao().findnumber(x);
        numero = x;
      });
    }

    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: bodyheader(size: size, obs: atualizar),
      body: FutureBuilder(
          future: _exerciciosFuture,
          builder: (context, snapshot) {
            List<exercicio>? set = tolist(snapshot.data);
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Text('espera');
              case ConnectionState.waiting:
                return Text('espera');
              case ConnectionState.active:
                return Text('espera');
              case ConnectionState.done:
                print(set);
                return RefreshIndicator(
                    onRefresh: () async {
                      _exerciciosFuture = dao().findnumber(numero);
                      setState(() {});
                    },
                    child: ListView(children: [Treinamento(data: set)]));
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await dao().save(exercicio(
            peso: '1',
            repeticao: '1',
            name: 'coloque o nome aqui',
            numero: numero,
            fuc: () {},
          ));
          setState(() {
            _exerciciosFuture = dao().findnumber(numero);
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
