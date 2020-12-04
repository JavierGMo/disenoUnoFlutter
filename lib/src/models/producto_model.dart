import 'dart:convert';

ProductoModel productoModelFromJson(String str) => ProductoModel.fromJson(json.decode(str));

String productoModelToJson(ProductoModel data) => json.encode(data.toJson());

class ProductoModel {
    ProductoModel({
        this.id,
        this.name,
        this.description,
        this.refImg,
        this.pieces,
        this.price,
    });

    int id;
    String name;
    String description;
    String refImg;
    int pieces;
    int price;

    factory ProductoModel.fromJson(Map<String, dynamic> json) => ProductoModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        refImg: json["refImg"],
        pieces: json["pieces"],
        price: json["price"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "refImg": refImg,
        "pieces": pieces,
        "price": price,
    };
}
