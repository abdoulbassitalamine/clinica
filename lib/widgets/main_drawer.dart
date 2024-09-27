
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Drawer(

      child: ListView(
        children: [
          Column(
           
            children: [
              SizedBox(
                width: double.infinity,
                child: DrawerHeader(
                    decoration: const BoxDecoration(

                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                            end: Alignment.bottomLeft,
                            colors: [
                              Colors.blue,
                              Colors.white,
                            ]
                        )

                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage("images/user.png"),
                        ),
                        Text("Dr. Laminou Amadou Abdoul Bassit")
                      ],
                    )
                ),
              ),

            ],
          ),

                  ListTile(
                    title: Text(
                      "A props de l\'application",style: TextStyle(fontSize: 22),
                    ),
                    leading: Icon(Icons.info,color: Colors.green),
                    trailing: Icon(Icons.arrow_right,color: Colors.green,),
                    onTap: null ,
                  ),
                  ListTile(
                    title: Text(
                      "Se deconnecter",style: TextStyle(fontSize: 22),
                    ),
                    leading: Icon(Icons.power_settings_new,color: Colors.orange),
                    trailing: Icon(Icons.arrow_right,color: Colors.orange,),
                    onTap: ()=>FirebaseAuth.instance.signOut(),
                  )




            ],
          ),

      );

  }

}



