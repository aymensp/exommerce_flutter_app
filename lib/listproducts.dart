import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'label.dart';



class CarsList extends StatefulWidget {
  @override
  _CarsListState createState() => _CarsListState();
}

class _CarsListState extends State<CarsList> {
  List<Product> cars = [];
  String _baseImageUrl = "http://192.168.1.14:9090/img/";
  Future<bool> fetchedCars;

  Future<bool> fetchCar() async {
    http.Response response = await http.get("http://192.168.1.14:9090/product");

    List<dynamic> carsFromServer = json.decode(response.body);
    if(carsFromServer.length != 0) {
      for(int i = 0; i < carsFromServer.length; i++) {
        if(carsFromServer[i] != null) {
          cars.add(Product(carsFromServer[i]["_id"], carsFromServer[i]["label"],carsFromServer[i]["description"], _baseImageUrl + carsFromServer[i]["image"],carsFromServer[i]["price"]));
        }
      }
    }

    return true;
  }

  @override
  void initState() {
    super.initState();
    fetchedCars = fetchCar();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchedCars,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if(snapshot.hasData) {
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return CarInfo(cars[index].id, cars[index].label,cars[index].description, cars[index].urlImage,cars[index].price);
            },
            itemCount: cars.length,
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class Product {
  String id;
  String label;

  String urlImage;
  String description;
  String price;

  Product(this.id, this.label,this.description, this.urlImage, this.price );

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "label": label,
      
      "description": description,
      "price": price
    };
  }

  @override
  String toString() {
    return 'Product{id: $id, make: $label, urlImage: $urlImage, description: $description, price: $price}';
  }
}