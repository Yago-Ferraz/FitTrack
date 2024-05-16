import 'package:fittrack/view/components/buttomchoise.dart';
import 'package:sqflite/sqflite.dart';
import 'database.dart';

class bt {
  static const String tableSql = 'CREATE TABLE $_tablename ('
      '$_name INTEGER )';

  static const String _tablename = 'tabela_de_botoes';
  static const String _name = 'name';

  List<buttomchoise> tolist(List<Map<String, dynamic>> bts) {
    final List<buttomchoise> lista = [];
    for (var linha in bts) {
      final buttomchoise botao = buttomchoise(
        numero: linha[_name],
        press: () {},
        tap: () {},
      );

      lista.add(botao);
    }
    return lista;
  }

  Map<String, dynamic> tomap(buttomchoise bts) {
    final Map<String, dynamic> map = Map();
    map[_name] = bts.numero;
    return map;
  }

  Future<List<Map<String, dynamic>>> findall() async {
    print('pegando todos os botoes');
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tablename);
    return result;
  }

  Future<List<buttomchoise>> find(int objeto) async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result =
        await db.query(_tablename, where: '$_name = ?', whereArgs: [objeto]);
    return tolist(result);
  }

  delete(int objeto) async {
    print('deletando botao');
    final Database db = await getDatabase();
    return await db
        .delete(_tablename, where: '$_name = ?', whereArgs: [objeto]);
  }

  save(buttomchoise bts) async {
    final Database db = await getDatabase();
    final existe = await find(bts.numero);
    final Map<String, dynamic> bstmap = tomap(bts);
    if (existe.isEmpty) {
      print('inserindo');
      return await db.insert(_tablename, bstmap);
    } else {
      print('update');
      return await db.update(_tablename, bstmap,
          where: '$_name = ?', whereArgs: [bts.numero]);
    }
  }
}
