import 'package:clinica/administrateur/add_screen.dart';
import 'package:clinica/administrateur/medecin_details.dart';
import 'package:clinica/administrateur/medecin_form.dart';
import 'package:clinica/administrateur/rapport_screens.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/flutter_svg.dart';


class AdminMainPage extends StatefulWidget {
  static List<String> emailMed=[];
  const AdminMainPage({Key? key}) : super(key: key);

  @override
  State<AdminMainPage> createState() => _AdminMainPageState();
}

class _AdminMainPageState extends State<AdminMainPage> {
  final  Stream<QuerySnapshot> _medecintStream = FirebaseFirestore.instance.collection('medecin').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
   appBar: AppBar(
     title: Text('Espace administrateur'),
     
   ),
    body:  StreamBuilder<QuerySnapshot>(
      stream: _medecintStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        return ListView(
          children: snapshot.data!.docs
              .map((DocumentSnapshot document) {
            Map<String, dynamic> data =
            document.data()! as Map<String, dynamic>;
            AdminMainPage.emailMed.add(data['email']);
            return ListTile(
              title: Text("Dr ${data['nom']}  ${data['prenom']}"),
              subtitle: Text(data['specialite']),
              trailing: IconButton(
                onPressed: ()=>  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext conntex){
                      return AlertDialog(
                        title: const Text('Confirmation'),
                        content: const Text('confimer'),
                        scrollable: true,
                        actions: [
                          TextButton(
                              onPressed: (){
                                FirebaseFirestore.instance
                                    .collection('medecin')
                                    .where("id_medecin", isEqualTo: data['id_medecin'])
                                    .get()
                                    .then((value) => value.docs.forEach((document) {

                                  FirebaseFirestore.instance
                                      .collection('medecin')
                                      .doc(document.id)
                                      .delete()
                                      .then((_) {
                                    print("success!");
                                  });
                                }));
                                Navigator.of(context).pop();

                              },
                              child:Text('Oui') ),
                          TextButton(
                              onPressed: ()=>    Navigator.of(context).pop(),
                              child: Text('Non'))
                        ],
                      );


                    }
                )
                ,
                icon:Icon(
                    Icons.delete,

                ),
              ),
              onTap: (){
                Navigator.of(context).pushNamed(MedecinDeatils.nameRoute,arguments: data['id_medecin']);
              },

            );

          })
              .toList()
              .cast(),
        );
      },
    ),
    bottomNavigationBar: Padding(
      padding: EdgeInsets.only(right: 90,
      left: 90),
      child: ElevatedButton(
        child: Text('Ajouter médecin'),
        onPressed: (){
          Navigator.of(context).pushNamed(MedecinForm.routeNamed);
        },
      ),
    ),

    drawer:  Drawer(


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
                            Text("Admin")
                          ],
                        )
                    ),
                  ),

                ],
              ),
              ListTile(
                title: Text(
                  "Rapport",style: TextStyle(fontSize: 22),
                ),
                leading:SvgPicture.asset('icons/paper.svg',
                width: 30,
                ),
                trailing: Icon(Icons.arrow_right,color: Colors.orange,),
                onTap: ()=>Navigator.of(context).pushNamed(RappotScreens.routeNamed),
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
              ),




            ],
          ),

        )

    );
  }

}
