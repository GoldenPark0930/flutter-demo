import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_demo/model/users.dart';
import 'package:flutter_demo/data/rest_ds.dart';

class LoginScreen extends StatefulWidget {
    @override
    State<StatefulWidget> createState() {
        // TODO: implement createState
        return new LoginViewState();
      }
}
class LoginViewState extends State<LoginScreen> {
    BuildContext _ctx;
    bool _isLoading = false;
    final formKey = new GlobalKey<FormState>();
    final scaffoldKey = new GlobalKey<ScaffoldState>();
    String _username, _password;

    void _showSnackBar(String text) {
      scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(text)));
    }
    void _submit() {
      final form = formKey.currentState;
      if (form.validate()) {
        setState(() {
                  _isLoading = true;
                });
        form.save();
        var resdata = new RestDatasource();
        resdata.login(_username, _password).then((dynamic obj) {
            if (obj.runtimeType == User) {
              print(obj.toString());
              // navigate to Home screen 
              Navigator.of(_ctx).pushReplacementNamed("/home");
            }
            else {
              // show error message with snack bar 
              _showSnackBar(obj.toString());
              setState(() {
                _isLoading = false;
              });
            }  
        });
      }
    }
    @override
    Widget build(BuildContext context) {
      _ctx = context;
      var loginbtn = new RaisedButton(
        onPressed: _submit,
        child: new Text("LOGIN"),
        color: Colors.primaries[0],
        textColor: Colors.white,
      );
      var loginForm = new Column(
        children: <Widget>[
          new Text(
            "Login App",
            textScaleFactor: 2.0,
          ),
          new Form(
            key: formKey,
            child: new Column(
              children: <Widget>[
                new Padding(
                  padding: EdgeInsets.all(8.0),
                  child: new TextFormField(
                    onSaved: (val) => _username = val,
                    validator: (val) {
                      return val.length < 10 ? "Username must have 10 letters" : null;
                    },
                    decoration: new InputDecoration(labelText: "Username"),
                  ),
                ),
                new Padding(
                  padding: EdgeInsets.all(8.0),
                  child: new TextFormField(
                    onSaved: (val) => _password = val,
                    validator: (val) {
                      return val.length == 0 ? "Please enter password to login" : null;
                    },
                    obscureText: true,
                    decoration: new InputDecoration(labelText: "Password"),
                  ),
                ),
              ],
            ),
          ),
          new Padding(
            padding: EdgeInsets.all(20.0),
            child: _isLoading ? new CircularProgressIndicator() : loginbtn,
          ),
        ],
        crossAxisAlignment: CrossAxisAlignment.center,
      );

      return new Scaffold(
        appBar: null,
        key: scaffoldKey,
        body: new Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
               image: new AssetImage("assets/images.jpeg"),
                fit: BoxFit.cover),
          ),
          child: new Center(
            child: new ClipRect(
              child: new BackdropFilter(
                filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: new Container(
                  child: loginForm,
                  height: 300.0,
                  width: 300.0,
                  decoration: new BoxDecoration(
                     color: Colors.grey.shade200.withOpacity(0.5)),
                ),
              ),
            ),
          ),
        ),
      );
    }

}