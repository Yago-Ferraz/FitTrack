import 'package:fittrack/view/components/buttomchoise.dart';
import 'package:flutter/material.dart';
import '../../model/bt.dart';

class bodyheader extends StatefulWidget implements PreferredSizeWidget {
  final size;
  final obs;
  const bodyheader({super.key, required this.size, required this.obs});

  @override
  _bodyhead createState() => _bodyhead(size: this.size, observador: this.obs);

  @override
  Size get preferredSize => size;
}

class _bodyhead extends State<bodyheader> {
  final size;
  final observador;
  _bodyhead({required this.size, required this.observador});

  max(List<buttomchoise> lbt) {
    var max = 0;
    for (var x in lbt) {
      max > x.numero ? null : max = x.numero;
    }
    return max;
  }

  atualizar() {
    setState(() {
      bts = bt().findall();
    });
  }

  List<buttomchoise> tolist(List<Map<String, dynamic>>? bts) {
    final List<buttomchoise> lista = [];
    if (bts != null) {
      for (var linha in bts) {
        final buttomchoise botao = buttomchoise(
          numero: linha['name'],
          press: atualizar,
          tap: observador,
        );

        lista.add(botao);
      }
    }
    return lista;
  }

  Future<List<Map<String, dynamic>>> bts = bt().findall();
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      height: preferredSize.height,
      color: Colors.greenAccent,
      alignment: Alignment.center,
      child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: FutureBuilder(
              future: bts,
              builder: (context, snapshot) {
                final List<buttomchoise>? lista = tolist(snapshot.data);
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return Text('nao foi');

                  case ConnectionState.waiting:
                    return Text('espere');

                  case ConnectionState.active:
                    return Text('conectado');

                  case ConnectionState.done:
                    return Row(
                      children: [
                        for (var wid in lista!) wid,
                        ElevatedButton(
                            onPressed: () async {
                              int number = max(lista) + 1;
                              observador(number);
                              await bt().save(buttomchoise(
                                numero: number,
                                press: () {},
                                tap: () {},
                              ));
                              setState(() {
                                bts = bt().findall();
                              });
                            },
                            child: Text('+'))
                      ],
                    );
                }
              })),
    ));
  }

  Size get preferredSize => Size.fromHeight(size.height * 0.05);
}
