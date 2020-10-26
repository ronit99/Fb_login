import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'details_screen.dart';
import 'dart:async';
import 'dart:convert' as JSON;
import 'package:http/http.dart' as http;


void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}
class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => new MyAppState();
}

class MyAppState extends State<MyApp> {

  static final FacebookLogin facebookSignIn = new FacebookLogin();

  String _message = '';
  Model data;

  Future<Null> _login() async {

  }
  Future<Null> _logOut() async {
    await facebookSignIn.logOut();
    _showMessage('Logged out.');
  }

  void _showMessage(String message) {
    setState(() {
      _message = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title:  Text('Facebook login Demo'),
        centerTitle: true,
      ),
      body:  Center(
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_message),
            RaisedButton(
              onPressed: () async {


                final FacebookLoginResult result =
                await facebookSignIn.logIn(['email']);
                print(result.status);
                switch (result.status) {
                  case FacebookLoginStatus.loggedIn:
                  // ignore: unrelated_type_equality_checks

                    final FacebookAccessToken accessToken = result.accessToken;
                    final graphResponse = await http.get(
                        'https://graph.facebook.com/v2.12/me?fields=name,picture.width(800).height(800),first_name,last_name,email&access_token=${result.accessToken.token}');
                    print(graphResponse.body);
                    Map userMap = JSON.jsonDecode(graphResponse.body);
                    var user = Model.fromJson(userMap);
                    data = user;
                    //              _showMessage('''
                    // ${user.name},
                    // ${user.email},
                    // Token: ${accessToken.token},
                    // User id: ${accessToken.userId}
                    // ''');
                    // Expires: ${accessToken.expires}
                    // Permissions: ${accessToken.permissions}
                    // Declined permissions: ${accessToken.declinedPermissions}
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailScreen(model1: user)));
                    break;
                  case FacebookLoginStatus.cancelledByUser:
                    _showMessage('Login cancelled by the user.');
                    break;
                  case FacebookLoginStatus.error:
                    _showMessage('Something went wrong with the login process.\n'
                        'Here\'s the error Facebook gave us: ${result.errorMessage}');
                    print(result.errorMessage);
                    break;
                }
                // ignore: unrelated_type_equality_checks



              },
              child: new Text('Log in using facebook'),
            ),

          ],
        ),
      ),
    );

  }
}
class Model {
  String name;
  Picture picture;
  String firstName;
  String lastName;
  String email;
  String id;

  Model(
      {this.name,
        this.picture,
        this.firstName,
        this.lastName,
        this.email,
        this.id});

  Model.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    picture =
    json['picture'] != null ? new Picture.fromJson(json['picture']) : null;
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.picture != null) {
      data['picture'] = this.picture.toJson();
    }
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['id'] = this.id;
    return data;
  }
}

class Picture {
  Data data;

  Picture({this.data});

  Picture.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  int height;
  bool isSilhouette;
  String url;
  int width;

  Data({this.height, this.isSilhouette, this.url, this.width});

  Data.fromJson(Map<String, dynamic> json) {
    height = json['height'];
    isSilhouette = json['is_silhouette'];
    url = json['url'];
    width = json['width'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['height'] = this.height;
    data['is_silhouette'] = this.isSilhouette;
    data['url'] = this.url;
    data['width'] = this.width;
    return data;
  }
}