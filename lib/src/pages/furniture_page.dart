import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ventas_muebles/src/blocs/producto_bloc.dart';
import 'package:ventas_muebles/src/models/producto_model.dart';


class FurniturePage extends StatelessWidget {
  
  final productoBloc = new ProductoBloc();
  final greyNoMaterial = Color.fromRGBO(245, 243, 244, 1);

  @override
  Widget build(BuildContext context) {

    final ProductoModel productoArgs = ModalRoute.of(context).settings.arguments;//Args del mueble
    final size = MediaQuery.of(context).size;
    // print('Precio ${productoArgs['price']}');
    
    productoBloc.cambiarTotalPriceProductos(productoArgs.price);

    return Scaffold(
      appBar: AppBar(
        
        title: Container(
          alignment: AlignmentDirectional.center,
          child: Text(
            productoArgs.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border),
            color: Colors.black,
            onPressed: (){

            },
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: _containerMain(productoArgs, size),
      floatingActionButton: _floatingsActionButtonCustom(productoArgs.price)
    );
  }

  Widget _containerMain(ProductoModel details, Size size){
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: double.infinity,
      child: _details(details, size),
    );
  }//Contenedor principal

  Widget _details(ProductoModel details, Size size){
    return Column(
      children: [
        _imageFurniture(details.refImg, size),
        Expanded(child: _titleAndDescription(details.name, details.description, details.price, size))
      ],
    );
  }//Detalels del mueble

  Widget _imageFurniture(String imageName, Size size){
    return Container(
      height: size.height*0.55,
      width: double.infinity,
      child: Image(
        image: AssetImage(imageName),
        fit: BoxFit.cover,
      ),
    );
  }//Imagen del producto

  Widget _titleAndDescription(String name, String description, int price, Size size){
    return Container(
      width: double.infinity,
      height: size.height*0.40,
      child: Column(
        children: [
          _titleAndPrice(name, price),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 35.0),
            child: Text(
              description,
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.grey
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _titleAndPrice(String name, int price){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      margin: EdgeInsets.symmetric(vertical: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '\$$price',
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }


  Widget _floatingsActionButtonCustom(int price){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _btnAddOrDecrement(price),
        _btnAndPrice(price),
      ],
    );
  }

  Widget _btnAddOrDecrement(int price){
    final priceFinal = price;
    return StreamBuilder<int>(
      stream: productoBloc.numeroProductosStream,
      builder: (BuildContext context, AsyncSnapshot<int> snapshot){
        print('Data ${ snapshot.data }');
        productoBloc.cambiarNumeroDeProductos(snapshot.data??1);
        final numeroDeProductos = snapshot.data;
        return Container(
          margin: EdgeInsets.only(left: 30.0),
          child: Row(
            children: [
              Container(
                width: 60.0,
                height: 35.0,
                child: FlatButton.icon(
                  icon: Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
                  color: greyNoMaterial,
                  label: Text(''),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        bottomLeft: Radius.circular(40.0),
                    ),
                  ),
                  onPressed: (){
                    
                    productoBloc.cambiarNumeroDeProductos(numeroDeProductos+1);
                    
                    productoBloc.cambiarTotalPriceProductos((numeroDeProductos+1)*priceFinal);
                  }
                ),
              ),
              Container(
                color: greyNoMaterial,
                padding: EdgeInsets.symmetric(vertical: 10.0),
                width: 30.0,
                height: 35.0,
                child: Text(
                  '$numeroDeProductos',
                  textAlign: TextAlign.center,
                )
              ),
              Container(
                width: 60.0,
                height: 35.0,
                child: FlatButton.icon(
                  icon: Icon(
                    Icons.remove,
                    color: Colors.black,
                  ),
                  color: greyNoMaterial,
                  label: Text(''),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40.0),
                        bottomRight: Radius.circular(40.0),
                    ),
                  ),
                  onPressed: (){
                    if(numeroDeProductos > 1){
                      productoBloc.cambiarNumeroDeProductos(numeroDeProductos-1);
                      productoBloc.cambiarTotalPriceProductos((numeroDeProductos-1)*priceFinal);
                    }
                    
                  }
                ),
              ),
            ],
          ),
        );
      }
    );
    
  }
  
  Widget _btnAndPrice(int precio){
    return StreamBuilder(
      stream: productoBloc.totalPriceStream,
      builder: (BuildContext context, AsyncSnapshot<int> snapshot){

        productoBloc.cambiarTotalPriceProductos(snapshot.data??precio);
        final price = snapshot.data;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total: \$$price',
              style: TextStyle(
                fontSize: 10.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20.0),
              child: FlatButton.icon(
                height: 75.0,
                icon: Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.white,
                ),
                color: Colors.black,
                label: Text(''),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(10.0),
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.elliptical(70.0, 50.0),
                  ),
                ),
                onPressed: (){

                }
              ),
            ),
          ],
        );
      },
    );
    
  }

  
  

}