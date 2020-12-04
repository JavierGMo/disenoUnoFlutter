import 'package:flutter/material.dart';
import 'package:ventas_muebles/src/blocs/productos_bloc.dart';
import 'package:ventas_muebles/src/models/producto_model.dart';


class HomePage extends StatelessWidget {
  
  final productoBloc = new ProductosBloc();

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    productoBloc.obtenerProductos();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white12,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            color: Colors.black,
            onPressed: (){
              Navigator.pushReplacementNamed(context, 'crear');
            }
          )
        ],
      ),
      body: _allSections(size),
      bottomNavigationBar: _bottomNavigatonCustom(context),
    );
  }

  Widget _allSections(Size size){
    return Stack(
      children: [
        _backgroundScreen(),
        _mainSection(size),
      ],
    );
  }

  Widget _backgroundScreen(){
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black,
    );
  }

  Widget _mainSection(Size size){
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30.0), bottomRight: Radius.circular(30.0)),
      ),
      
      child: Column(
        children: [
          _titleAndSubtitleMain(size),
          _filterBarProducts(),
          Expanded(
            child: _listFurniture(),
          ),
          

        ],
      ),
    );
  }//Productos, titulos y filtrado

  Widget _titleAndSubtitleMain(Size size){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: size.width*0.8,
          child: Text(
            'Furniture in Unique Style',
            style: TextStyle(
              
              fontWeight: FontWeight.bold,
              fontSize: 40.0
            ),
          ),
        ),
        SizedBox(height: 10.0,),
        Text(
          'We have wide range of Furniture',
          style: TextStyle(
            color: Colors.grey
          ),
        ),
      ],
    );
  }//Titulo y subtitulo

  Widget _filterBarProducts(){

    return Row(
      children: [
        _btnFilter('Tables'),
        _btnFilter('Chairs'),
        _btnFilter('Lamps'),
        _btnFilter('All'),
      ],
    );

  }//filtrado de porductos

  Widget _btnFilter(String title){
    return FlatButton(
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold
        ),
      ),
      onPressed: (){

      }
    );
  }//Boton de filtrado

  Widget _listFurniture(){
    //Este es temporal, despues usare un listview.builder y streams

    return StreamBuilder(
      stream: productoBloc.productosStream,
      builder: (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot){
        final data = snapshot?.data;
        if(snapshot.hasData){
          return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: data.length,
            itemBuilder: (BuildContext context, int i){
              return _fornitureTile(context, data[i]);
            }
          );
        }else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        
        
      }
    );
  }//Lista de muebles

  Widget _fornitureTile(BuildContext context, ProductoModel prod){
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      child: ListTile(
        leading: Container(
          width: 90.0,
          height: 190.0,
          child: FadeInImage(
            placeholder: AssetImage('assets/no-image.jpg'),
            image: AssetImage('${prod.refImg}'),
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          '${prod.name}',
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${prod.description}',
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              '${prod.price}',
              
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
        trailing: Icon(
          Icons.keyboard_arrow_right,

        ),
        onTap: (){

          Navigator.pushNamed(context, 'furniture', arguments: prod);
        },
      ),
    );
  }

  Widget _bottomNavigatonCustom(BuildContext context){
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Colors.black,
        primaryColor: Colors.grey,
        textTheme: Theme.of(context).textTheme
                        .copyWith(
                          caption: TextStyle(
                            color: Colors.grey,
                          )
                        )

      ),
      child: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
        ]
      ),
    );
  }




}