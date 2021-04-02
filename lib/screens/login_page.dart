import 'package:flutter/material.dart';
import 'package:foodie/screens/my_home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _controllerEmail;
  TextEditingController _controllerPassword;
  @override
  void initState() {
    print('login');
    _controllerEmail = TextEditingController();
    _controllerPassword = TextEditingController();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: width,
                height: height * 0.30,
                // child: Image.asset(
                //   'assets/yoga.png',
                //   fit: BoxFit.fill,
                // ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Login To Your Account',
                      style: TextStyle(
                          fontSize: 25.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              TextField(
                controller: _controllerEmail,
                decoration: InputDecoration(
                  hintText: 'Email',
                  suffixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: _controllerPassword,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                  suffixIcon: Icon(Icons.visibility_off),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              SizedBox(
                height: 50.0,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Forget password?',
                      style: TextStyle(fontSize: 12.0),
                    ),
                    RaisedButton(
                      child: Text('Login'),
                      color: Color(0xffEE7B23),
                      onPressed: () async {
                        SharedPreferences _pref =
                            await SharedPreferences.getInstance();
                        var login = _pref.getStringList('login');
                        print(login);
                        if (_controllerEmail.text.toLowerCase() ==
                                login[0].toLowerCase() &&
                            _controllerPassword.text.toString() ==
                                login[1].toString()) {
                          List<String> list = [
                            _controllerEmail.text.toLowerCase(),
                            _controllerPassword.text.toString()
                          ];
                          _pref.setString('session', 'true');
                          _controllerEmail.clear();
                          _controllerPassword.clear();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyHomePage()));
                        } else if (_controllerEmail.text.isEmpty &&
                            _controllerPassword.text.isEmpty) {
                          _controllerEmail.clear();
                          _controllerPassword.clear();
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Invalid Details")));
                        } else {
                          _controllerEmail.clear();
                          _controllerPassword.clear();
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Invalid Details")));
                        }
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30.0),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Second()));
                },
                child: Text.rich(
                  TextSpan(text: 'Don\'t have an account   ', children: [
                    TextSpan(
                      text: 'Signup',
                      style: TextStyle(color: Color(0xffEE7B23)),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Second extends StatefulWidget {
  @override
  _SecondState createState() => _SecondState();
}

class _SecondState extends State<Second> {
  TextEditingController _controllerEmail;
  TextEditingController _controllerPassword;
  @override
  void initState() {
    _controllerEmail = TextEditingController();
    _controllerPassword = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: width,
                height: height * 0.30,
                // child: Image.asset(
                //   'assets/play.png',
                //   fit: BoxFit.fill,
                // ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Signup',
                      style: TextStyle(
                          fontSize: 25.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              TextField(
                controller: _controllerEmail,
                decoration: InputDecoration(
                  hintText: 'Email',
                  suffixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              TextField(
                controller: _controllerPassword,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                  suffixIcon: Icon(Icons.visibility_off),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'i Agrred to All Terms',
                      style: TextStyle(fontSize: 12.0),
                    ),
                    RaisedButton(
                      child: Text('Signup'),
                      color: Color(0xffEE7B23),
                      onPressed: () async {
                        if (_controllerEmail.text.toString() != null &&
                            _controllerPassword.text.toString() != null) {
                          SharedPreferences _pref =
                              await SharedPreferences.getInstance();
                          _pref.setStringList('login', [
                            _controllerEmail.text.toLowerCase(),
                            _controllerPassword.text.toString()
                          ]);
                          _controllerEmail.clear();
                          _controllerPassword.clear();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        } else {
                          _controllerEmail.clear();
                          _controllerPassword.clear();
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Invalid Details")));
                        }
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30.0),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
                child: Text.rich(
                  TextSpan(text: 'Have Already Account  ', children: [
                    TextSpan(
                      text: 'Signin',
                      style: TextStyle(color: Color(0xffEE7B23)),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
