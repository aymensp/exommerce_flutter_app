import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CarInfo extends StatelessWidget {
  String _carId;
  String productLabel;
  String description;
  String _imageUrl;
  String  productPrice;
  CarInfo(this._carId, this.productLabel, this.description, this._imageUrl,this.productPrice);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString("carId", _carId);
          prefs.setString("label", productLabel);
          prefs.setString("price", productPrice);
          prefs.setString("description", description);
          prefs.setString("image", _imageUrl);
          Navigator.pushNamed(context, "/details");
        },
        child: Row(
          children: [
            Image.network(_imageUrl, width: 100, height: 100),
            Container(
              margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text(productLabel), Text(productPrice.toString())],
              ),
            )
          ],
        ),
      ),
    );
  }
}
