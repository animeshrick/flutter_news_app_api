import 'package:flutter/material.dart';
import 'package:flutter_newa_app_api/views/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

///Login Widget
class LoginSample extends StatelessWidget {
  ///saving login data
  void saveLoggedIn() async {
    var sharePref = await SharedPreferences.getInstance();
    sharePref.setBool("isLoggedIn", true);
  }

  ///check logged in
  Future<bool> isLoggedIn() async {
    //var sharePref = await SharedPreferences.getInstance();
    return /*sharePref.getBool("isLoggedIn") ??*/ false;
  }

  ///saving updated password
  Future<String> getPassword() async {
    var sharePref = await SharedPreferences.getInstance();
    return sharePref.getString("password") ?? "";
  }

  ///saving updated username
  Future<String> getUsername() async {
    var sharePref = await SharedPreferences.getInstance();
    return sharePref.getString("username") ?? "";
  }

  @override
  Widget build(BuildContext context) {
    print("Login Screen called Up");

    ///hardcoded username & password
    String USER_NAME = "jitesh";
    String PASSWORD = "jitesh@123";

    var userNameController = TextEditingController();
    var passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        builder: (builder, snapshot) {
          ///
          if (snapshot.hasData) {
            ///
            if (snapshot.data == true) {
              // LoggedIn
              return Home();
            }

            ///
            else if (snapshot.data == false) {
              // Not Logged In
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'S',
                          style: TextStyle(color: Colors.white, fontSize: 40),
                        ),
                      ),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.blue),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: userNameController,
                      decoration: InputDecoration(
                          labelText: 'User Name', border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      obscureText: true,
                      controller: passwordController,
                      decoration: InputDecoration(
                          labelText: 'Password', border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    ///login Button
                    RaisedButton(
                      onPressed: () {
                        ///
                        String userName = userNameController.text.toString();
                        String password = passwordController.text.toString();
                        print("given username :" + userName);
                        print("given password :" + password);

                        ///
                        if (USER_NAME == userName && PASSWORD == password) {
                          saveLoggedIn();
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (ctx) {
                            return Home();
                          }));
                        }
                      },
                      child: const Text('Login'),
                    ),
                    Expanded(child: SizedBox()),

                    ///Sign Up Button
                    RaisedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (ctx) {
                          return SignUpScreen();
                        })).then((value) async {
                          print("Coming from sign up screen");
                          var password = await getPassword();
                          var username = await getUsername();
                          PASSWORD = password;
                          USER_NAME = username;
                          print("Current Password: " + password);
                          print("Current username: " + username);
                        });
                      },
                      child: const Text('Sign Up'),
                    )
                  ],
                ),
              );
            }
          }

          return Center(child: CircularProgressIndicator());
        },
        future: isLoggedIn(),
      ),
    );
  }
}

///Sign Up widget
class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  ///saving password in sign up page
  Future<void> savePassword(String pass) async {
    var sharePref = await SharedPreferences.getInstance();
    sharePref.setString("password", pass);
  }

  ///saving username in sign up page
  Future<void> saveUsername(String uname) async {
    var sharePref = await SharedPreferences.getInstance();
    sharePref.setString("username", uname);
  }

  @override
  Widget build(BuildContext context) {
    var userNameController = TextEditingController();
    var passwordController = TextEditingController();
    var confirmPasswordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 100,
                width: 100,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'S',
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                ),
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: userNameController,
                decoration: InputDecoration(
                    labelText: 'User Name', border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                obscureText: true,
                controller: passwordController,
                decoration: InputDecoration(
                    labelText: 'Password', border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                obscureText: true,
                controller: confirmPasswordController,
                decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 20,
              ),

              ///confirm button
              RaisedButton(
                onPressed: () async {
                  String userName = userNameController.text.toString();
                  String password = passwordController.text.toString();
                  String confirmPassword =
                      confirmPasswordController.text.toString();
                  // print(userName);
                  // print(password);
                  // print(confirmPassword);

                  if (userName != '') {
                    await saveUsername(userName);
                    if (password == confirmPassword) {
                      await savePassword(password);
                      Navigator.of(context).pop();
                    } else {
                      print("Please check the password");
                    }
                  }
                },
                child: Text('Confirm'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

///Home Widget
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove back button
        title: const Text('Home Screen'),
      ),
      body: Center(
        child: const Text('Welcome to home screen'),
      ),
    );
  }
}
