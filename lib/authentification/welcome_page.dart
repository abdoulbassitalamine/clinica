
import 'package:clinica/authentification/login_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../animations/delayed_animation.dart';
import '../configurations/mes_couleurs.dart';




class WelcomPage extends StatelessWidget {
  static const routeNamed="/welcome-page";
  const WelcomPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height ,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 237, 238, 242),
          ),
          // margin: const EdgeInsets.symmetric(
          //   vertical: 60,
          //   horizontal: 30,
          // ),
          child: Column(
            children: [
              DelayedAnimation(
                delay: 1500,
                  child:Container(

                    decoration: const BoxDecoration(
                     color:MesCouleurs.couleur1,
                      image: DecorationImage(


                        colorFilter: ColorFilter.mode(MesCouleurs.couleur1, BlendMode.colorBurn),
                        image: AssetImage("images/logo_clinic.png")
                      )

                    ),
                    height: 170,

                   // child: Image.asset("images/logo_clinic.png",fit: BoxFit.cover,),
                  ) ,
                  ),
              DelayedAnimation(
                delay: 2500,
                child:SizedBox(
                  height: 400,
                  child: Image.asset("images/doctor.png",),
                ) ,
              ),
              DelayedAnimation(
                delay: 3500,
                child:Container(
                  padding: const EdgeInsets.only(top: 30,bottom: 20,),


                  width:double.infinity,
                  child:Text("Gerer vos patients plus facilement avc clinica",
                  style: GoogleFonts.poppins(
                    color: Colors.grey,
                    fontSize: 16
                  ),
                    textAlign: TextAlign.center,
                  ),
                ) ,


              ),
              DelayedAnimation(
                delay: 4500,
                child:SizedBox(

                  width:double.infinity,
                  child:ElevatedButton(
                    child: const Text("Demarer"),
                    onPressed: (){

                     Navigator.of(context).pushNamed( LoginWidget.routeNamed);
                    },

                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,

                      shape: const StadiumBorder()


                    ),

                ),
                ) ,
              ),


            ],

          ),
        ),



    );
  }
}
