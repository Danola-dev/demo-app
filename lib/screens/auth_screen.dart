import 'package:demo_app/widgets/wavy.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key, reu});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final firebase = FirebaseAuth.instance;

  var form = GlobalKey<FormState>();
  var isLogin = true;
  var enteredName = '';
  var enteredEmail = '';
  var enteredPassword = '';
  var isAuthenticating = false;

  void submit() async {
    final isValid = form.currentState!.validate();
    if (isValid) {
      form.currentState!.save();
    }
    setState(() {
      isAuthenticating = true;
    });

    try {
      if (isLogin) {
        final userCredential = await firebase.signInWithEmailAndPassword(
          email: enteredEmail,
          password: enteredPassword,
        );
      } else {
        final userCredential = await firebase.createUserWithEmailAndPassword(
          email: enteredEmail,
          password: enteredPassword,
        );
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Email already in use')));
      }
      if (error.code == 'invalid-credential') {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Invalid credential')));
      }
      if (error.code == 'invalid-email') {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Invalid email')));
      }
      if (error.code == 'weak-password') {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Password too weak')));
      }
    }
    setState(() {
      isAuthenticating = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipPath(
              clipper: WaveClipper(),
              child: Container(
                width: double.infinity,
                height: 230,
                color: const Color.fromARGB(255, 79, 176, 255),
                child: Image.asset(
                  'assets/images/pattern.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            if (isLogin)
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 20),
                child: Text(
                  'Log in',
                  style: TextStyle(fontSize: 31.5, fontWeight: FontWeight.bold),
                ),
              ),
            if (!isLogin)
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 22),
                  child: Text(
                    'Sign up',
                    style: TextStyle(fontSize: 31, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            if (isLogin)
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  "Glad you're back! Let's get back to business.",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            SizedBox(height: 3.5),
            Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Form(
                  key: form,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (!isLogin)
                        Text(
                          'Name',
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      SizedBox(height: 9),
                      if (!isLogin)
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Enter your name',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.length < 4) {
                              return 'Must be at least 4 characters long';
                            }
                            return null;
                          },
                          onSaved: (newValue) {
                            enteredName = newValue!;
                          },
                        ),
                      SizedBox(height: 13),
                      Text(
                        'Email address',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 9),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Enter email address',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        textCapitalization: TextCapitalization.none,
                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty ||
                              !value.contains('@')) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          enteredEmail = newValue!;
                        },
                      ),
                      SizedBox(height: 13),
                      Text(
                        'Password',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 19,
                        ),
                      ),
                      SizedBox(height: 9),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Enter your password',
                          border: OutlineInputBorder(),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.trim().length < 6) {
                            return 'Password must be at least 6 characters long';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          enteredPassword = newValue!;
                        },
                      ),
                      SizedBox(height: 21),
                      if (isAuthenticating)
                        Center(child: CircularProgressIndicator())
                      else
                        Center(
                          child: ElevatedButton(
                            onPressed: submit,
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(345, 53),
                              backgroundColor: Colors.blue,
                            ),
                            child: Text(
                              isLogin ? 'Login' : 'Signup',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      SizedBox(height: 11),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 100,
                            height: 1.5,
                            color: Colors.black,
                          ),
                          Text(
                            isLogin ? 'Or Sign in with' : 'Or Sign up with',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            width: 100,
                            height: 1.5,
                            color: Colors.black,
                          ),
                        ],
                      ),
                      SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Image.asset(
                              'assets/images/google.png',
                              width: 75,
                              height: 75,
                            ),
                          ),
                          IconButton(
                            iconSize: 42,
                            color: const Color.fromARGB(255, 0, 119, 216),
                            onPressed: () {},
                            icon: Icon(Icons.facebook_rounded),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            isLogin
                                ? "Don't have an account? "
                                : 'Already have an account? ',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isLogin = !isLogin;
                              });
                            },
                            child: Text(
                              isLogin ? 'Sign up' : 'Login',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
