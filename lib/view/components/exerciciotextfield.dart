// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';

class excerciciotexto extends StatefulWidget {
  final String campo;
  String texto;
  final pai;
  final bool isnumerico;
  excerciciotexto(
      {super.key,
      required this.texto,
      required this.campo,
      required this.isnumerico,
      required this.pai});
  @override
  State<excerciciotexto> createState() =>
      _exerciciotexto(nome: this.texto, isnumerico: this.isnumerico);
}

class _exerciciotexto extends State<excerciciotexto> {
  final String nome;
  final bool isnumerico;
  final myController = TextEditingController();
  var focused = FocusNode();

  _exerciciotexto({required this.isnumerico, required this.nome}) {
    myController.text = this.nome;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isnumerico
              ? Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Text(isnumerico ? widget.campo : '',
                      style: TextStyle(
                          fontFamily: 'inter',
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                )
              : Text(''),
          TextField(
            controller: myController,
            onChanged: (String x) {
              widget.texto = x;
            },
            onEditingComplete: () async {
              await widget.pai(widget.texto);
              focused.unfocus();
            },
            keyboardType:
                isnumerico ? TextInputType.number : TextInputType.text,
            decoration: InputDecoration(
              border: InputBorder.none,
              filled: isnumerico ? true : false,
              fillColor: Colors.white70,
            ),
            style: TextStyle(
                fontFamily: 'inter',
                fontSize: isnumerico ? 25 : 20,
                fontWeight: FontWeight.bold),
            maxLines: 2,
            minLines: 1,
            textInputAction: TextInputAction.done,
            onTapOutside: (event) async {
              await widget.pai(widget.texto);
              focused.unfocus();
            },
            focusNode: focused,
            textAlign: TextAlign.center,
          ),
        ],
      ),
      width: isnumerico ? size.width * 0.22 : size.width * 0.3,
      margin: EdgeInsets.only(left: size.width * 0.04866),
      padding: EdgeInsets.symmetric(vertical: 10),
    );
  }
}
