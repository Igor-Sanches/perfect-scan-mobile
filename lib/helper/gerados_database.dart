import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:perfectscan/interface/gerados_db_interface.dart';
import 'package:perfectscan/model/gerados_model.dart';
import 'package:sqflite/sqflite.dart';

class GeradosDatabase implements IGerados{
  static GeradosDatabase? _GeradosDatabase;
  Database? _database;
  String tabela = 'Gerados',
      collid = 'id',
      collisCamera = 'isCamera',
      colldisplayName = 'displayName',
      collresult = 'result',
      colldata = 'data',
      collformato = 'formato',
      colltipo = 'tipo',
      colluuid = 'UUID',
      collisNuvem = 'isNuvem';

  GeradosDatabase._createInstance();

  factory GeradosDatabase(){
    _GeradosDatabase ??= GeradosDatabase._createInstance();
    return _GeradosDatabase!;
  }

  Future<Database?> get database async {
    _database ??= await inicializarDatabase();
    return _database;
  }

  Future<Database?> inicializarDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}Gerados.db';
    var escaneadosDatabas = await openDatabase(
        path, version: 1, onCreate: _createDb);
    return escaneadosDatabas;
  }

  void _createDb(Database db, int version) {
    db.execute('CREATE TABLE $tabela($collid INTEGER PRIMARY KEY AUTOINCREMENT, $colldisplayName TEXT, $collresult TEXT, $colldata NUMBER, $collformato TEXT, $colltipo TEXT, $colluuid TEXT, $collisNuvem TEXT, $collisCamera TEXT)');
  }

  @override
  Future<Gerados?> getGerado(int? id) async {
    var db = await database;
    List<Map> maps = await db!.query(tabela, columns: [this.collid, colldisplayName, collresult, colldata, colltipo], where: '$id = ?', whereArgs: [id!]);
    return Gerados.fromMap(maps.first);
  }

  @override
  Future<List<Map>?> lista()async{
    var db = await database;
    List<Map> maps = await db!.query(tabela, columns: [collid, colldisplayName, collresult, colldata, colltipo], orderBy: 'data DESC');
    return maps;
  }

  @override
  Future<int?> delete(int id) async {
    var db = await database;
    var resultado = await db!.delete(tabela, where: '$collid = ?', whereArgs: [id]);
    return resultado;
  }

  @override
  Future close() async {
    var db = await database;
    db!.close();
  }

  @override
  Future<int?> adicionar(Gerados? gerados) async {
    bool? notExist = await isNotEmpty(gerados!.result!, gerados.formato!);
    if(notExist!){
      var db = await database;
      var resultado = await db!.insert(tabela, gerados.toMap());
      return resultado;
    }else {
      return -1;
    }
  }

  @override
  Future<int?> atualizar(Map<String, Object?> values, int id) async {
    var db = await database;
    var resultado = await db!.update(tabela, values, where: '$collid = ?', whereArgs: [id]);
    return resultado;
  }

  @override
  Future<int?> numerosGerados() async {
    var db = await database;
    List<Map<String, dynamic>> x = await db!.rawQuery('SELECT COUNT (*) from $tabela');
    var resultado = Sqflite.firstIntValue(x);
    return resultado;
  }

  @override
  Future<bool?> isNotEmpty(String result, String formato) async {
    var db = await database;
    List<Map> maps = await db!.query(tabela, columns: [collid, colldisplayName, collresult, colldata, colltipo], where: '$collresult = ? AND $collformato = ?', whereArgs: [result, formato]);
    return !maps.isNotEmpty;
  }
}