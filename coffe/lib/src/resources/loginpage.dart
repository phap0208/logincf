import 'package:coffe/src/blocs/login_bloc.dart';
import 'package:coffe/src/resources/homepage.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget{
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{

  LoginBloc bloc = new LoginBloc();

  bool _showPass = false;
  TextEditingController _userController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: true, // Set to true
        body: Container(
          padding: EdgeInsets.fromLTRB(30,0,30,0),
          constraints: BoxConstraints.expand(),
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                child: Container(
                  width: 90,
                  height: 90,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffd8d8d8),
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'images/logo/cafe.jpg', // Replace with your café image path
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0,0,0,60),
                child: Text(
                  "Hello\n welcome back",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 30,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0,0,0,40),
                child: StreamBuilder(
                  stream: bloc.userStream ,
                  builder: (context, snapshot)=> TextField(
                      controller: _userController,
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      decoration: InputDecoration(
                        labelText:"Username",
                        errorText: snapshot.hasError ? snapshot.error as String : null,
                        labelStyle: TextStyle(
                          color: Color(0xff888888),
                          fontSize: 15,
                        ),
                      ),
                    ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0,0,0,40),
                child: Stack(
                  alignment: AlignmentDirectional.centerEnd,
                  children:<Widget>[
                    StreamBuilder(
                      stream: bloc.passStream,
                      builder: (context, snapshot)=>
                        TextField(
                      controller: _passController,
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      obscureText: !_showPass,
                      decoration: InputDecoration(
                        labelText:"Password",
                        errorText: snapshot.hasError ? snapshot.error as String : null,
                        labelStyle: TextStyle(
                          color: Color(0xff888888),
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                    GestureDetector(
                      onTap: onToggleShowPass,
                      child: Text(
                        _showPass ? "HIDE" : "SHOW",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const  EdgeInsets.fromLTRB(0,0,0,0),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: onSignInclicked,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // Set background color to sea blue
                    ),
                    child: Text('Sign in', style: TextStyle(color: Colors.white),),
                  ),
                ),
              ),
              Container(
                height: 50,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "New user? Sign up",
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xff888888),
                      ),
                    ),
                    Text(
                      "forgot password",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
  void onToggleShowPass(){
    setState(() {
      _showPass = !_showPass;
    });
  }
  void onSignInclicked() {
     if(bloc.isValidInfor(_userController.text, _passController.text)){
       Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
     }
  }

  Widget gotoHome (BuildContext context){
    return HomePage();
  }
}