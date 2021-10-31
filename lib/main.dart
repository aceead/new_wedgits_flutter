import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'my_color.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Stateful Clicker Counter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Clicker Counter Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

enum AuthMode { SignUp, Login }

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final ImagePicker _picker = ImagePicker();
  File pickedImage;
  fetchImage() async {
    final XFile image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }
    setState(() {
      pickedImage = File(image.path);
    });
  }

  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.SignUp;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  final li = List<String>.generate(20, (index) => "Item Number ${index + 1}");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      //body: inhert(),
      // body: marqueeLV(),
      // body: imagePicker(),
      // floatingActionButton: imagePFAP(),
      //body: formFielsBuilder(),
      body: ListView.builder(
        itemCount: li.length,
        itemBuilder: (ctx, index) {
          final item = li[index];
          return Dismissible(
            child: ListTile(
              title: Center(
                child: Text(item),
              ),
            ),
          );
        },
      ),
    );
  }

  Center formFielsBuilder() {
    return Center(
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "Email"),
                keyboardType: TextInputType.emailAddress,
                validator: (val) {
                  if (val.isEmpty || !val.contains('@')) {
                    return 'Invalid email';
                  } else
                    return null;
                },
                onSaved: (val) {
                  _authData['email'] = val;
                  print(_authData['email']);
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Password"),
                controller: _passwordController,
                obscureText: true,
                validator: (val) {
                  if (val.isEmpty || val.length < 6) {
                    return 'Invalid password';
                  } else
                    return null;
                },
                onSaved: (val) {
                  _authData['email'] = val;
                  print(_authData['email']);
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              if (_authMode == AuthMode.SignUp)
                TextFormField(
                  enabled: _authMode == AuthMode.SignUp,
                  decoration: InputDecoration(labelText: "Confirm Password"),
                  obscureText: true,
                  validator: _authMode == AuthMode.SignUp
                      ? (val) {
                          if (val != _passwordController.text) {
                            return 'Password not match';
                          } else {
                            return null;
                          }
                        }
                      : null,
                ),
              SizedBox(
                height: 10.0,
              ),
              RaisedButton(
                child: Text(_authMode == AuthMode.Login ? 'Login' : 'Register'),
                onPressed: _submit,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 8.0),
                color: Colors.blueAccent,
                textColor: Colors.white,
              ),
              SizedBox(
                height: 10.0,
              ),
              FlatButton(
                child: Text('${_authMode == AuthMode.Login ? "Register" : "Login"} Instead'),
                onPressed: _switchAuthMode,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                color: Colors.white,
                textColor: Colors.blue,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submit() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    if (_authMode == AuthMode.Login) {
      //Login
    } else {
      //register
    }
  }

  Widget imagePicker() {
    return Center(
      child: pickedImage == null ? null : Image.file(pickedImage),
    );
  }

  FloatingActionButton imagePFAP() {
    return FloatingActionButton(
      onPressed: fetchImage,
      child: Icon(Icons.add),
    );
  }

  ListView marqueeLV() {
    return ListView(
      children: [
        SizedBox(
          height: 15.0,
        ),
        SizedBox(
          height: 70.0,
          child: Card(
            color: Colors.greenAccent,
            child: Marquee(
              text: "Simple text 1",
              blankSpace: 200,
              scrollAxis: Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.start,
              accelerationDuration: Duration(microseconds: 100),
            ),
          ),
        ),
        SizedBox(
          height: 15.0,
        ),
        SizedBox(
          height: 70.0,
          child: Card(
            color: Colors.greenAccent,
            child: Marquee(
              text: "Simple text 2",
              blankSpace: 50,
              scrollAxis: Axis.vertical,
              accelerationDuration: Duration(microseconds: 10),
            ),
          ),
        ),
      ],
    );
  }

  Center inhert() {
    return Center(
      child: MyColor(
        color: Colors.blueAccent,
        child: Builder(
          builder: (ctx) => Text(
            "Text",
            style: TextStyle(
              color: Colors.white,
              fontSize: 45,
              backgroundColor: MyColor.of(ctx).color,
            ),
          ),
        ),
      ),
    );
  }
}
