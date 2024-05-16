import 'package:sqflite/sqflite.dart';
import 'database.dart';
import '../view/components/ExercicioSet.dart';

class dao {
  static const String tableSql = 'CREATE TABLE $_tablename ('
      '$_name TEXT, '
      '$_peso TEXT, '
      '$_numero INTEGER, '
      '$_repeticao TEXT)';

  static const String _tablename = 'exercicioset';
  static const String _name = 'name';
  static const String _peso = 'peso';
  static const String _repeticao = 'repeticao';
  static const String _numero = 'numero';

  List<exercicio> tolist(List<Map<String, dynamic>> mapadetarefas) {
    final List<exercicio> sets = [];
    
    for (Map<String, dynamic> linha in mapadetarefas) {
      final exercicio set = exercicio(
          peso: linha[_peso], repeticao: linha[_repeticao], name: linha[_name],numero: linha[_numero],fuc: (){},);
      sets.add(set);
    }
    return sets;
  }

  Map<String, dynamic> tomap(exercicio tarefa) {
    final Map<String, dynamic> mapadeset = Map();
    mapadeset[_name] = tarefa.name;
    mapadeset[_peso] = tarefa.peso;
    mapadeset[_repeticao] = tarefa.repeticao;
    mapadeset[_numero] = tarefa.numero;
    return mapadeset;
  }

  Future<List<exercicio>> findall() async {
    print('pegando todos');
    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> result =
        await bancoDeDados.query(_tablename);
    return tolist(result);
    
  }

  Future<List<exercicio>> find(String setname) async {
    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> result = await bancoDeDados
        .query(_tablename, where: '$_name = ?', whereArgs: [setname]);
    return tolist(result);
  }

  Future<List<Map<String,dynamic>>> findnumber(int setname) async {
    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> result = await bancoDeDados
        .query(_tablename, where: '$_numero = ?', whereArgs: [setname]);
    return result;
  }

  delete(String setname) async {
    final Database bancodedados = await getDatabase();
    print('deletando');
    return await bancodedados
        .delete(_tablename, where: '$_name = ?', whereArgs: [setname]);
  }

  save(exercicio set) async{
    final Database bancoDeDados = await getDatabase();
    var existeitem = await find(set.name);
    Map<String, dynamic> setmap = tomap(set);
    if(existeitem.isEmpty){
      print('insert');
      return await bancoDeDados.insert(_tablename,setmap);
    }else{
      print('update');
      return await bancoDeDados.update(_tablename
      ,setmap,where: '$_name = ?', whereArgs: [set.name]);
    }
  }
}
