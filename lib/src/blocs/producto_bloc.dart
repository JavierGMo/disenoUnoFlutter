import 'dart:async';

import 'package:ventas_muebles/src/providers/db_provider.dart';

class ProductoBloc{

  static ProductoBloc _blocSingleton = new ProductoBloc._internal();

  factory ProductoBloc(){
    if(_blocSingleton!=null)return _blocSingleton;
    _blocSingleton = new ProductoBloc._internal();
    return _blocSingleton;
  }

  ProductoBloc._internal(){
    primerProducto();
  }

  final _productoController = StreamController<ProductoModel>.broadcast();
  final _numeroProductoController = StreamController<int>.broadcast();
  final _cargandoProductoController = StreamController<bool>.broadcast();
  final _totalPrecioController = StreamController<int>.broadcast();

  //Streams
  Stream<ProductoModel> get productoStream => _productoController.stream;
  
  Stream<int> get numeroProductosStream => _numeroProductoController.stream;
  Stream<int> get totalPriceStream => _totalPrecioController.stream;
  Stream<bool> get cargandoProductoStream => _cargandoProductoController.stream;

  //Adds

  Function(int) get cambiarNumeroDeProductos => _numeroProductoController.sink.add;
  Function(int) get cambiarTotalPriceProductos => _totalPrecioController.sink.add;

  void primerProducto(){
    _numeroProductoController.sink.add(1);
  }
  

  void actualizarProducto(ProductoModel producto) async {
    _cargandoProductoController.sink.add(true);
    await DBProvider.db.updateProducto(producto);
    _cargandoProductoController.sink.add(false);
  }
  

  void dispose(){
    _productoController?.close();
    _numeroProductoController?.close();
    _cargandoProductoController?.close();
    _totalPrecioController?.close();
  }



}