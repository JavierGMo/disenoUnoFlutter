import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import 'package:ventas_muebles/src/models/producto_model.dart';
export 'package:ventas_muebles/src/models/producto_model.dart';

class DBProvider {
  
  
  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if(_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'muebles.db');
    print('Path de la base de datos ${path}');
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db){},
      onCreate: (Database db, int version) async {
        await db.execute(
          '''
            CREATE TABLE mueble(
              id INTEGER PRIMARY KEY,
              name TEXT,
              description TEXT,
              refImg TEXT,
              pieces INTEGER,
              price INTEGER
            );
          '''
        );
      }
    );
  }


  Future<int> nuevoMueble(ProductoModel producto) async {
    final db = await database;

    final res = await db.insert('mueble', producto.toJson());

    return res;


  }

  Future<ProductoModel> getMuebleById(int id) async {
    final db = await database;
    final res = await db.query('mueble', where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty?ProductoModel.fromJson(res.first):null;
  }

  Future<List<ProductoModel>> geAlltMuebles() async {
    final db = await database;
    final res = await db.query('mueble');
    return res.isNotEmpty
      ?res.map((producto) => ProductoModel.fromJson(producto)).toList()
      :null;
  }

  Future<int> updateProducto(ProductoModel producto) async {
      final db = await database;
      final res = await db.update('mueble', producto.toJson(), where: 'id = ?', whereArgs: [producto.id]);
      return res;
  }

  Future<int> borrarTodos() async {
    final db = await database;
    final res = await db.delete('mueble');
    return res;
  }

}