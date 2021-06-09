import 'package:examen_2021/listproducts.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class CarBooking extends StatefulWidget {
  @override
  _CarBookingState createState() => _CarBookingState();
}

class _CarBookingState extends State<CarBooking> {
  Product car;
  String _baseImageUrl = "http://192.168.1.14:9090/img/";
  Future<bool> carFetched;
  SharedPreferences prefs ;


    Future<bool> fetchCar() async {
    prefs = await SharedPreferences.getInstance();
  
    car = Product(prefs.getString("carId"),prefs.getString("label"),prefs.getString("description"),prefs.getString("image"),prefs.getString("price"));
    return true;
  }

  
  

  @override
  void initState() {
    super.initState();
   carFetched = fetchCar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Book a car")),
      body: FutureBuilder(
        future: carFetched,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(car.urlImage),
                SizedBox(height: 10),
                Text("Model : " + car.label + " " ),
                SizedBox(height: 10),
                Text("Description :"),
                Text(car.description),
                SizedBox(height: 10),
                Text("Quantity : " + car.price.toString()),
                SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: FlatButton(
                    child: Text("Book this car"),
                    onPressed: () {
                      // http
                      //     .patch("http://192.168.1.14:9090/car/" +
                      //         prefs.getString("carId"))
                      //     .then((http.Response response) {
                      //   http
                      //       .get("http://192.168.1.14:9090/car/" +
                      //           prefs.getString("carId"))
                      //       .then((http.Response response2) {
                      //     Map<String, dynamic> carFromServer =
                      //         json.decode(response2.body);
                      //     car = Car(carFromServer["_id"], carFromServer["make"],
                      //         carFromServer["model"], carFromServer["image"],
                      //         description: carFromServer["description"],
                      //         quantity: carFromServer["quantity"]);
                      //     setState(() {});
                      //   });
                      // });
                    },
                  ),
                )
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add),
        label: Text("Add product to favorites"),
        onPressed: () async {
          Database db = await openDatabase(
              join(await getDatabasesPath(), "products_database.db"),
              onCreate: (Database db, int version) {
            db.execute(
                "CREATE TABLE products(id TEXT PRIMARY KEY, label TEXT, description TEXT, price TEXT)");
          }, version: 1);

          await db.insert("products", car.toMap(),
              conflictAlgorithm: ConflictAlgorithm.replace);

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Confirmation"),
                content: Text("Product added to favorites"),
              );
            },
          );
        },
      ),
    );
  }
}
