import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'bottomNav.dart';

class SignIn extends StatefulWidget {
  @override
  _CarAddState createState() => _CarAddState();
}

class _CarAddState extends State<SignIn> {
  String username;
  
  String password;
  

  GlobalKey<FormState> _keyForm = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      
      body:
      Form(
        
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
    
          SizedBox(height: 10),
         SizedBox(height: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RaisedButton(
                
                child: Text("SignIn"),
                onPressed: () {
                  if (!_keyForm.currentState.validate()) return;
                  _keyForm.currentState.save();

                  Map<String, dynamic> userData = {
                    "username": username,
                    "password": password
                  
                  };

                  Map<String, String> headers = {
                    "Content-Type": "application/json; charset=UTF-8"
                  };

                  http
                      .post("http://192.168.1.14:9090/user/signin",
                          headers: headers, body: json.encode(userData))
                      .then((http.Response response) {
                           if (response.statusCode==200) {
                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context) => BottomNavigationInterface()), ModalRoute.withName('/'));
                          }  
                    String message = response.statusCode == 200
                        ? "Sign In succefully" 
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
                child: Text("SignUp"),
                onPressed: () {
                  _keyForm.currentState.reset();
                  Navigator.pushReplacementNamed(context, "/signup");
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
