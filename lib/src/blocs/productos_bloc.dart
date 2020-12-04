import 'dart:async';

import 'package:ventas_muebles/src/providers/db_provider.dart';
import 'package:ventas_muebles/src/models/producto_model.dart';

class ProductosBloc{

  // static ProductosBloc _blocSingleton = new ProductosBloc._internal();

  // factory ProductosBloc(){
  //   if(_blocSingleton==null) return _blocSingleton = new ProductosBloc._internal();
  //   return _blocSingleton;
  // }
  ProductosBloc(){
    
  }

  ProductosBloc._internal();

  final _productosController = StreamController<List<ProductoModel>>.broadcast();

  Stream<List<ProductoModel>> get productosStream => _productosController.stream;


  void crarProducto(ProductoModel producto) async {
    await DBProvider.db.nuevoMueble(producto);
    // obtenerProductos();

  }

  void obtenerProductos() async {
    _productosController.sink.add(await DBProvider.db.geAlltMuebles());
  }

  void borrarTodo() async {
    await DBProvider.db.borrarTodos();

  }

  void dispose(){
    _productosController?.close();
  }



}