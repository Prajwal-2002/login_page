import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_page/model/user_model.dart';
import 'package:login_page/screens/home_screen.dart';
import 'package:login_page/screens/login_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  final _auth = FirebaseAuth.instance;

  //editing controller
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController firstnameController = new TextEditingController();
  final TextEditingController lastnameController = new TextEditingController();
  final TextEditingController confirmpasswordController =
      new TextEditingController();

  RegExp regex = new RegExp(r'^.{3,}$');

  var _val, _isObscure1 = true, _isObscure2 = true;
  @override
  Widget build(BuildContext context) {
    final firstnameField = TextFormField(
      autofocus: false,
      controller: firstnameController,
      keyboardType: TextInputType.name,
      validator: (valve) {
        //RegExp regex = new RegExp(r'^.{3,}$');
        if (valve!.isEmpty) {
          return ('First Name Required');
        }
        if (!regex.hasMatch(valve)) {
          return ('Enter Valid FirstName(Min. 3 Characters)');
        }
        return null;
      },
      onSaved: (valve) {
        firstnameController.text = valve!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.account_circle),
        contentPadding: EdgeInsets.fromLTRB(15, 15, 25, 15),
        hintText: "First Name",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );

    final lastnameField = TextFormField(
      autofocus: false,
      controller: lastnameController,
      keyboardType: TextInputType.name,
      validator: (valve) {
        //RegExp regex = new RegExp(r'^.{3,}$');
        if (valve!.isEmpty) {
          return ('Last Name cannot be Empty');
        }
        return null;
      },
      onSaved: (valve) {
        lastnameController.text = valve!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.account_circle),
        contentPadding: EdgeInsets.fromLTRB(15, 15, 25, 15),
        hintText: "Last Name",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );

    regex = new RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]");

    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (valve) {
        _val = valve;
        //RegExp regex = new RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]");
        if (_val!.isEmpty) {
          return ("Email Required");
        }
        //reg expression for email validation
        if (!regex.hasMatch(_val)) {
          return ("Please Enter a valid Email");
        }
        return null;
      },
      onSaved: (valve) {
        emailController.text = valve!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.mail),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Email",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );

    regex = new RegExp(r'^.{6,}$');

    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordController,
      obscureText: _isObscure1,
      validator: (valve) {
        //RegExp regex = new RegExp(r'^.{6,}$');

        //storing the password to check with confirm password
        _val = valve;

        if (valve!.isEmpty) {
          return ('Password Required');
        }
        if (!regex.hasMatch(valve)) {
          return ('Enter Valid Password(Min. 6 Characters)');
        }
      },
      onSaved: (valve) {
        passwordController.text = valve!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.vpn_key_sharp),
        suffixIcon: IconButton(
          icon: Icon(
            _isObscure1 ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              _isObscure1 = !_isObscure1;
            });
          },
        ),
        contentPadding: EdgeInsets.fromLTRB(15, 20, 15, 20),
        hintText: "Password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );

    final confirmpasswordField = TextFormField(
      autofocus: false,
      controller: confirmpasswordController,
      obscureText: _isObscure2,
      validator: (valve) {
        //RegExp regex = new RegExp(r'^.{6,}$');

        if (confirmpasswordController.text != passwordController.text) {
          return 'Passwords do not match';
        }
        return null;
      },
      onSaved: (valve) {
        confirmpasswordController.text = valve!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.vpn_key_sharp),
        suffixIcon: IconButton(
          icon: Icon(
            _isObscure2 ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              _isObscure2 = !_isObscure2;
            });
          },
        ),
        contentPadding: EdgeInsets.fromLTRB(15, 20, 15, 20),
        hintText: "Confirm Password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );

    final signUpButton = Material(
      elevation: 6,
      color: Colors.redAccent,
      borderRadius: BorderRadius.circular(25),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width * 0.70,
        onPressed: () {
          signUp(emailController.text, passwordController.text);
        },
        child: Text(
          'SignUp',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_sharp),
          color: Colors.blue,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 200,
                        child: Image.asset(
                          "android/assets/my_app_logo.jpg",
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 35),
                      firstnameField,
                      const SizedBox(height: 20),
                      lastnameField,
                      const SizedBox(height: 20),
                      emailField,
                      const SizedBox(height: 20),
                      passwordField,
                      const SizedBox(height: 15),
                      confirmpasswordField,
                      const SizedBox(height: 15),
                      signUpButton,
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {
                postDetailsToFirestore(),
              })
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  void postDetailsToFirestore() async {
    //calling firestore
    //calling usermodel
    //sending these valves

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel usm = UserModel();

    usm.email = user!.email;
    usm.uid = user!.uid;
    usm.firstName = firstnameController.text;
    usm.secondName = lastnameController.text;

    await firebaseFirestore.collection("users").doc(user.uid).set(usm.toMap());
    Fluttertoast.showToast(msg: "Account created successfully :) ");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (route) => false);
  }
}
