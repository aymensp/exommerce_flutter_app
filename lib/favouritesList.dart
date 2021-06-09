import 'package:examen_2021/listproducts.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:convert';

import 'label.dart';


class ProductsFavoriteList extends StatefulWidget {
  ProductsFavoriteList({Key key}) : super(key: key);

  @override
  _CarsFavoriteListState createState() => _CarsFavoriteListState();
}

class _CarsFavoriteListState extends State<ProductsFavoriteList> {
  List<Product> cars = [];
  Future<bool> fetchedCars;

  Future<bool> fetchCar() async {
    Database db = await openDatabase(
        join(await getDatabasesPath(), "products_database.db"),
        version: 1);

    List<Map<String, dynamic>> maps = await db.query("products");
    cars = List.generate(maps.length, (int index) {
      return Product(
          maps[index]["id"], maps[index]["label"],
          maps[index]["description"],null,
         maps[index]["price"]);
    });

    return true;
  }

  @override
  void initState() {
    super.initState();
    fetchedCars = fetchCar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       
        body: FutureBuilder(
          future: fetchedCars,
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return CarInfo(cars[index].id, cars[index].label,cars[index].description, 'http://192.168.1.14:9090/img/1.jpeg' ,cars[index].price);
                },
                itemCount: cars.length,
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
