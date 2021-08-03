import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'homepage.dart';
class Signpage extends StatefulWidget {
  const Signpage({Key? key}) : super(key: key);
  static String id='sign-up';


  @override
  _SignpageState createState() => _SignpageState();
}

class _SignpageState extends State<Signpage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> _key= GlobalKey<FormState>();
  String errorMessage = '';
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    //User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(
        body: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Image.asset("assets/food.png",
                fit: BoxFit.cover,
                color: Colors.black.withOpacity(0.5),
                colorBlendMode: BlendMode.lighten,
              ),
              Center(
                child: Form(
                  key: _key,
                  child: new Container(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("FOOD ANALYZER",
                          textAlign: TextAlign.center,
                          style:const TextStyle(fontWeight: FontWeight.bold, fontSize: 50, color: Colors.white),),
                        Padding(padding: const EdgeInsets.all(20)),
                        TextFormField(
                          controller: emailController,
                          validator: validateEmail,
                          decoration: InputDecoration(
                            enabledBorder: new OutlineInputBorder(
                                borderSide: new BorderSide(color: Colors.white)),
                              labelText: "Email",
                            labelStyle: TextStyle(
                              color: Colors.white,
                            )
                          ),
                          style: TextStyle(color: Colors.white,
                          ),
                        ),
                        Padding(padding: const EdgeInsets.all(10)),
                        TextFormField(
                          controller: passwordController,
                          validator: validatePassword,
                          obscureText: true,
                          decoration: InputDecoration(
                            enabledBorder: new OutlineInputBorder(
                                borderSide: new BorderSide(color: Colors.white)),
                              labelText: "Password",
                            labelStyle: TextStyle(
                              color: Colors.white,
                            )
                          ),
                          style: TextStyle(color: Colors.white),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Center(
                            child: Text(errorMessage, style: TextStyle(color: Colors.red),),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                                child: isLoading? CircularProgressIndicator(color: Colors.black,)
                                    :Text("SIGN UP"),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white,),
                                onPressed: () async{
                                  setState(() {
                                    isLoading = true;
                                    errorMessage = '';
                                  });
                                  if(_key.currentState!.validate()) {
                                    try {
                                      final new_user=  await FirebaseAuth.instance
                                          .createUserWithEmailAndPassword(
                                        email: emailController.text,
                                        password: passwordController.text,
                                      );
                                      if (new_user != null) {
                                        Navigator.pushNamed(context, HomePage.id);
                                      }

                                    } on FirebaseAuthException catch(error) {
                                      errorMessage = error.message!;
                                    }
                                    setState(() => isLoading = false);
                                  }
                                }),
                            ElevatedButton(child:
                            isLoading? CircularProgressIndicator(color: Colors.black,)
                                : Text("SIGN IN"),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white,),
                                onPressed: () async{
                                  setState(() => isLoading = true);

                                  if(_key.currentState!.validate()) {
                                    try {
                                      final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
                                        email: emailController.text,
                                        password: passwordController.text,
                                      );
                                      if (user != null) {
                                        Navigator.pushNamed(context, HomePage.id);}
                                      errorMessage = '';
                                    } on FirebaseAuthException catch (error) {
                                      errorMessage = error.message!;
                                    }
                                    setState(() => isLoading = false);
                                  }
                                }),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ]
        )
    );
  }
}

String? validateEmail(String? formEmail) {
  if (formEmail == null || formEmail.isEmpty)
    return 'Email address is required';

  String pattern= r'\w+@\w+\.\w+';
  RegExp regex = RegExp(pattern);
  if(!regex.hasMatch(formEmail)) return 'Invalid Email Address Format';

  return null;
}

String? validatePassword(String? formPassword) {
  if (formPassword == null || formPassword.isEmpty)
    return 'Password is required';

  String pattern= r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  RegExp regex = RegExp(pattern);
  if(!regex.hasMatch(formPassword))
    return '''
    Password must be at least 8 characters ,
    include an uppercase letter, number and symbol
    ''';

  return null;
}