import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class UserAdd extends StatefulWidget {
  @override
  _CarAddState createState() => _CarAddState();
}

class _CarAddState extends State<UserAdd> {
  String username;
  String email;
  String password;
  String avatar;

  GlobalKey<FormState> _keyForm = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:   Form(
      key: _keyForm,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        
          TextFormField(
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: "Username"),
            validator: (String value) {
              if (value.isEmpty)
                return "Make must not be empty";
              else
                return null;
            },
            onSaved: (String value) {
              username = value;
            },
          ),
          SizedBox(height: 10),
          TextFormField(
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: "Password"),
                obscureText: true,
            validator: (String value) {
              if (value.isEmpty)
                return "Model must not be empty";
              else
                return null;
            },
            onSaved: (String value) {
              password = value;
            },
          ),
          SizedBox(height: 10),
          TextFormField(
           
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: "Email"),
            validator: (String value) {
              if (value.isEmpty)
                return "Description must not be empty";
              else
                return null;
            },
            onSaved: (String value) {
              email = value;
            },
          ),
          SizedBox(height: 10),
         SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RaisedButton(
                child: Text("Add"),
                onPressed: () {
                  if (!_keyForm.currentState.validate()) return;
                  _keyForm.currentState.save();

                  Map<String, dynamic> userData = {
                    "username": username,
                    "email": email,
                    "password": password,
                    "avatar": "m1.png"
                  };

                  Map<String, String> headers = {
                    "Content-Type": "application/json; charset=UTF-8"
                  };

                  http
                      .post("http://192.168.1.14:9090/user/signup",
                          headers: headers, body: json.encode(userData))
                      .then((http.Response response) {
                    String message = response.statusCode == 201
                        ? "User has been added"
                        : "Something went wrong, please try again !";
                    _keyForm.currentState.reset();
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Confirmation"),
                          content: Text(message),
                        );
                      },
                    );
                  });
                },
              ),
              RaisedButton(
                child: Text("Cancel"),
                onPressed: () {
                  _keyForm.currentState.reset();
                  Navigator.pushReplacementNamed(context, "/signin");
                },
              )
            ],
          )
        ],
      ),
    )
 
    );
    
  }
}
