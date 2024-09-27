import 'package:custom_clippers/Clippers/sin_cosine_wave_clipper.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_auth_email/main.dart';
import 'package:clinica/main.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../utils.dart';
import 'forgot_password_page.dart';
import 'package:email_validator/email_validator.dart';

class LoginWidget extends StatefulWidget {
  static const routeNamed="/login-widget";
  final VoidCallback onClickedSignUp;

  const LoginWidget({
    Key? key,
    required this.onClickedSignUp,
  }) : super(key: key);
  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();


  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double w=MediaQuery.of(context).size.width;
    double h=MediaQuery.of(context).size.height;
    return Scaffold(

    body:

     SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          children: [
            ClipPath(
                clipper: SinCosineWaveClipper(),
                child:Container(
                  width: w,
                  height: h*0.3,
                  decoration: BoxDecoration(

                      image: DecorationImage(

                        image: AssetImage("images/arrirereplan.jpg"),
                        fit: BoxFit.cover,

                      )
                  ),
                )
            ),
            Container(
              width: w,
              margin: EdgeInsets.only(left: 20,right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Bienvenue",style: TextStyle(fontSize: 60,fontWeight: FontWeight.bold),),
                  Text("Connectez-vous à votre compte",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey[500]
                    ),),
                  SizedBox(height: 50,),
                  Container(
                    decoration:BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                        boxShadow:[
                          BoxShadow(
                              blurRadius: 10,
                              spreadRadius: 7,
                              offset: Offset(1,1),
                              color: Colors.grey.withOpacity(0.2)
                          )
                        ]
                    ) ,
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (email) =>
                      email != null && !EmailValidator.validate(email)
                          ? 'Entrer un email valide'
                          : null,
                      controller: emailController,
                      decoration: InputDecoration(
                        prefixIcon:Icon(Icons.mail),
                        hintText: "Entrer votre email",
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                                color: Colors.white
                            )
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                                color: Colors.white,
                                width: 1.0
                            )
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),

                      ),

                    ),
                  ),
                  SizedBox(height: 20,),

                  Container(
                    decoration:BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                        boxShadow:[
                          BoxShadow(
                              blurRadius: 10,
                              spreadRadius: 7,
                              offset: Offset(1,1),
                              color: Colors.grey.withOpacity(0.2)
                          )
                        ]
                    ) ,
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) => value != null && value.length < 6
                          ? 'Enter min. 6 characters'
                          : null,
                      controller: passwordController,
                      decoration: InputDecoration(
                        hintText: " votre mot de passe",
                        prefixIcon:Icon(Icons.password) ,
                        suffixIcon: IconButton(
                          icon: Icon(Icons.remove_red_eye),
                          onPressed: null,
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                                color: Colors.white
                            )
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                                color: Colors.white,
                                width: 1.0
                            )
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),

                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Expanded(
                          child:Container()
                      ),
                      InkWell(

                        child: Text("Mot de passe oublié?",
                          style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.grey[500]
                          ),
                        ),
                        onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ForgotPasswordPage(),
                        ),
                      ),
                      )
                    ],
                  )
                ]

              ),
            ),
            SizedBox(height: 70,),
            InkWell(
              onTap: signIn,
              child: Container(
                width: w*0.5,
                height: h*0.06,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.blue
                ),
                child: Center(

                  child: Text(
                    "Se connecter",
                    style: TextStyle(
                        fontSize: 20.5,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: w*0.2,),
            InkWell(
              onTap: (){
               // Navigator.of(context).pushNamed(LogoutPage.routeName);
              },
              child: RichText(text: TextSpan(
                  text: "Je n\'ai pas de compte?",
                  style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 20
                  ),
                  children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = widget.onClickedSignUp,
                      text: " Créer",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold

                      ),)
                  ]
              )),
            )




          ],
        ),
      ),),
  );
  }

  Future signIn() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e);

      Utils.showSnackBar(e.message);
    }

    // Navigator.of(context) not working!
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
