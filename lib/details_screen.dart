
import 'main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  // Declare a field that holds the Todo.
  final Model model1;

  // In the constructor, require a Todo.
  DetailScreen({Key key, @required this.model1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Text(model1.firstName),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('First name : ${model1.firstName}',
                style: TextStyle(
                    fontSize: 25
                ),
              ),
              SizedBox(height: 20),
              Text('Last name : ${model1.lastName}',
                style: TextStyle(
                    fontSize: 25
                ),
              ),
              SizedBox(height: 20),
              Text(model1.email,
                style: TextStyle(
                    fontSize: 25
                ),
              ),
              SizedBox(height: 20),
              RaisedButton(
                child: Text('LogOut'),
                onPressed: () async {
                  await MyAppState.facebookSignIn.logOut();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}