import 'package:flutter/material.dart';
import 'dart:math';
import 'package:ventas_muebles/src/blocs/productos_bloc.dart';
import 'package:ventas_muebles/src/models/producto_model.dart';



class CreateMueblesPage extends StatefulWidget {
  CreateMueblesPage({Key key}) : super(key: key);

  @override
  _CreateMueblesPageState createState() => _CreateMueblesPageState();
}

class _CreateMueblesPageState extends State<CreateMueblesPage> {

  
  
  final images = ['assets/furniture.jpg', 'assets/mask.png'];
  final nameMuebles = ['Sofa', 'Cama', 'Silla'];
  final descriptions = [
    'Esta es una descripcion chida algo larga muy muy muy muy muy muy muy muy muy muy muy muy muy muy muy muy muy muy muy largo',
    'Descripcion no tan larga pero si, bueno no, la laa alala al alaala'
  ];

  final blocProducto = new ProductosBloc();
  final productoModel = new ProductoModel();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear productos'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){
            Navigator.pushReplacementNamed(context, 'home');
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30.0,),
            Text('Crear productos'),
            SizedBox(height: 30.0,),
            Center(
              child: FlatButton(
                child: Text('Crear'),
                color: Colors.blueAccent,
                onPressed: (){
                  _crear();
                }
              ),
            ),
            SizedBox(height: 30.0,),
            Center(
              child: FlatButton.icon(
                icon: Icon(Icons.dangerous),
                label: Text('Borrar todo alv'),
                color: Colors.red,
                onPressed: (){
                  blocProducto.borrarTodo();
                }
              ),
            ),
          ],
        )
      ),
    );
  }

  //Crear proudctos

  void _crear(){
    productoModel.name = nameMuebles[Random().nextInt(3)];
    productoModel.description = descriptions[Random().nextInt(2)];
    productoModel.refImg = images[Random().nextInt(2)];
    productoModel.pieces = 20;
    productoModel.price = 100;
    print('Exito ${Random().nextInt(3)}');
    blocProducto.crarProducto(productoModel);
    

  }

  @override
  void dispose() {
    blocProducto?.dispose();
    super.dispose();
  }


}