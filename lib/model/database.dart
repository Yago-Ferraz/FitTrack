import 'package:fittrack/model/bt.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/dao.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'exercicioset.db');
  return openDatabase(
    path,
    onCreate: (db, version) async{
      await db.execute(dao.tableSql);
      await db.execute(bt.tableSql);
    },
    version: 3  );
}
