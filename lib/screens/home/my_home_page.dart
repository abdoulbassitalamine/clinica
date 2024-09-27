import 'package:clinica/administrateur/admin_main_page.dart';
import 'package:clinica/authentification/auth_page.dart';
import 'package:clinica/authentification/verify_email_page.dart';
import 'package:clinica/authentification/welcome_page.dart';
import 'package:clinica/screens/home/header.dart';
import 'package:clinica/widgets/grid_menu.dart';
import 'package:clinica/widgets/main_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../authentification/login_widget.dart';
class MainPage extends StatelessWidget {

 static const admin="3iYi2Hzz9mVAKimrAoF411kHzya2";
  @override
  Widget build(BuildContext context) {

    return Scaffold(
    body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Something went wrong!'));
        } else if (snapshot.hasData) {
          return VerifyEmailPage();
        }

        else {
          return AuthPage();
        }
      },
    ),
  );
  }
}

class MyHomePage extends StatefulWidget {

  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return isAdmin()? AdminMainPage():Scaffold(
        appBar: AppBar(title: Center(child: Text("Acceuil")),
        elevation: 0,
          // leading:IconButton(
          //   icon: SvgPicture.asset("icons/menu.svg") ,
          //   onPressed: (){},
          // ),
        ),
        body:  SingleChildScrollView(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,

            children: [
             Header(size: size),
            GridMenu(),


            ],
          ),
        ),



        drawer: MainDrawer(),
       

    );
  }
  bool isAdmin()=>MainPage.admin==user.uid;
}
