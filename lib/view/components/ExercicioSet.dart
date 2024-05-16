import 'package:fittrack/model/dao.dart';
import 'package:fittrack/view/components/exerciciotextfield.dart';
import 'package:flutter/material.dart';

class exercicio extends StatefulWidget {
  final String peso;
  final String repeticao;
  final String name;
  final int numero;
  final fuc;
  exercicio(
      {super.key,
      required this.peso,
      required this.repeticao,
      required this.name,
      required this.numero,
      required this.fuc});
  @override
  State<exercicio> createState() => _exercicio(
      nome: this.name,
      numero: this.numero,
      fuc: this.fuc,
      peso: this.peso,
      repeticao: this.repeticao);
}

class _exercicio extends State<exercicio> {
  String nome;
  String peso;
  String repeticao;
  final int numero;
  final fuc;
  _exercicio(
      {required this.nome,
      required this.numero,
      required this.fuc,
      required this.peso,
      required this.repeticao});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    print(widget.name);

    return Container(
      height: size.height * 0.23,
      decoration: BoxDecoration(
        color: Colors.black26,
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: Column(children: [
        Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                  width: 40,
                  height: 40,
                  child: IconButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color.fromARGB(255, 255, 107, 107)),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero),
                          ),
                          alignment: Alignment.center),
                      onPressed: () {
                        dao().delete(this.nome);
                        fuc();
                      },
                      icon: Icon(
                        Icons.clear,
                        size: 25,
                      )))
            ]),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            excerciciotexto(
                texto: this.nome,
                campo: 'Exercicio:',
                isnumerico: false,
                pai: (dado) {
                  dao().delete(this.nome);
                  dao().save(exercicio(
                      peso: this.peso,
                      repeticao: this.repeticao,
                      name: dado,
                      numero: widget.numero,
                      fuc: this.fuc));
                  setState(() {
                    this.nome = dado;
                    print(widget.name);
                  });
                }),
            excerciciotexto(
              texto: this.peso,
              campo: 'Peso:',
              isnumerico: true,
              pai: (dado) {
                dao().save(exercicio(
                    peso: dado,
                    repeticao: this.repeticao,
                    name: this.nome,
                    numero: widget.numero,
                    fuc: this.fuc));
                setState(() {
                  this.peso = dado;
                });
              },
            ),
            excerciciotexto(
                texto: this.repeticao,
                campo: 'Repetição:',
                isnumerico: true,
                pai: (dado) {
                  dao().delete(this.nome);
                  dao().save(exercicio(
                      peso: this.peso,
                      repeticao: dado,
                      name: this.nome,
                      numero: widget.numero,
                      fuc: this.fuc));
                  setState(() {
                    this.repeticao = dado;
                  });
                })
          ],
        )
      ]),
    );
  }
}
