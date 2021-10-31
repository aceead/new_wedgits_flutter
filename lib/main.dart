import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:percent_indicator/percent_indicator.dart';

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
      //body: lvDismissble(),
      body: Center(
        child: ListView(children: <Widget>[
          new CircularPercentIndicator(
            radius: 100.0,
            lineWidth: 10.0,
            percent: 0.8,
            header: new Text("Icon header"),
            center: new Icon(
              Icons.person_pin,
              size: 50.0,
              color: Colors.blue,
            ),
            backgroundColor: Colors.grey,
            progressColor: Colors.blue,
          ),
          new CircularPercentIndicator(
            radius: 130.0,
            animation: true,
            animationDuration: 1200,
            lineWidth: 15.0,
            percent: 0.4,
            center: new Text(
              "40 hours",
              style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            circularStrokeCap: CircularStrokeCap.butt,
            backgroundColor: Colors.yellow,
            progressColor: Colors.red,
          ),
          new CircularPercentIndicator(
            radius: 120.0,
            lineWidth: 13.0,
            animation: true,
            percent: 0.8,
            center: new Text(
              "80.0%",
              style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            footer: new Text(
              "Sales this week",
              style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
            ),
            circularStrokeCap: CircularStrokeCap.round,
            progressColor: Colors.purple,
          ),
          Padding(
            padding: EdgeInsets.all(15.0),
            child: new CircularPercentIndicator(
              radius: 60.0,
              lineWidth: 5.0,
              percent: 1.0,
              center: new Text("100%"),
              progressColor: Colors.green,
            ),
          ),
          Container(
            padding: EdgeInsets.all(15.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new CircularPercentIndicator(
                  radius: 45.0,
                  lineWidth: 4.0,
                  percent: 0.10,
                  center: new Text("10%"),
                  progressColor: Colors.red,
                ),
                new Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                ),
                new CircularPercentIndicator(
                  radius: 45.0,
                  lineWidth: 4.0,
                  percent: 0.30,
                  center: new Text("30%"),
                  progressColor: Colors.orange,
                ),
                new Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                ),
                new CircularPercentIndicator(
                  radius: 45.0,
                  lineWidth: 4.0,
                  percent: 0.60,
                  center: new Text("60%"),
                  progressColor: Colors.yellow,
                ),
                new Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                ),
                new CircularPercentIndicator(
                  radius: 45.0,
                  lineWidth: 4.0,
                  percent: 0.90,
                  center: new Text("90%"),
                  progressColor: Colors.green,
                )
              ],
            ),
          )
        ]),
      ),
    );
  }

  ListView lvDismissble() {
    return ListView.builder(
      itemCount: li.length,
      itemBuilder: (ctx, index) {
        final item = li[index];
        return Dismissible(
          key: Key(item),
          child: ListTile(
            title: Center(
              child: Text(item),
            ),
          ),
          background: Container(
            color: Colors.red,
            child: Icon(
              Icons.delete,
              color: Colors.white,
            ),
            alignment: Alignment.centerLeft,
          ),
          secondaryBackground: Container(
            color: Colors.green,
            child: Icon(
              Icons.thumb_up,
              color: Colors.white,
            ),
            alignment: Alignment.centerRight,
          ),
          onDismissed: (DismissDirection direction) {
            setState(() {
              li.removeAt(index);
            });
            Scaffold.of(ctx).showSnackBar(
              SnackBar(
                content: Text(direction == DismissDirection.startToEnd ? "$item Deleted" : "$item Liked"),
                action: SnackBarAction(
                  label: "Undo",
                  onPressed: () {
                    setState(() {
                      li.insert(index, item);
                    });
                  },
                ),
              ),
            );
          },
        );
      },
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
