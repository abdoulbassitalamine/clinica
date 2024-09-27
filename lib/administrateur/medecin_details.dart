import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MedecinDeatils extends StatefulWidget {
  static const nameRoute='/medecin_details';
  const MedecinDeatils({Key? key}) : super(key: key);

  @override
  State<MedecinDeatils> createState() => _MedecinDeatilsState();
}

class _MedecinDeatilsState extends State<MedecinDeatils> {
  late String nom;

  @override
  Widget build(BuildContext context) {
    final _idMedecin=ModalRoute.of(context)!.settings.arguments as String;
    final  Stream<QuerySnapshot> _medecinStream = FirebaseFirestore.instance.collection('medecin')
        .where('id_medecin', isEqualTo: _idMedecin).snapshots();
    return Scaffold(
      appBar: AppBar(title: Text('Details'),),
      body: StreamBuilder<QuerySnapshot>(
        stream: _medecinStream,
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
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children: [

                  Container(
                    margin: EdgeInsets.only(top: 25),
                    child: Center(
                      child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Center(child: Text('Details'),),
                            information("Nom ", data['nom']),
                            information("Prenom ", data['prenom']),
                            information("Spécialité ", data['specialite']),
                            information("email ", data['email']),
                            information("Numero de telephone ", data['Telephone']),
                          ],
                        ),
                      ),
                    ),
                  ),


                ],
              );

              return  Expanded(

                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[100]
                  ),
                  height: MediaQuery.of(context).size.height*0.3,
                  width:MediaQuery.of(context).size.width*0.9 ,
                  child: Expanded(
                    child: Column(

                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Center(child: Text('Details'),),
                        information("Nom ", data['nom']),
                        information("Prenom ", data['prenom']),
                        information("Spécialité ", data['specialite']),
                        information("email ", data['email']),
                        information("Numero de telephone ", data['Telephone']),


                      ],
                    ),
                  ),
                ),

              );
            })
                .toList()
                .cast(),
          );
        },
      ),
    );
  }
  Widget information(String champ,var champInformation){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RichText(
          overflow: TextOverflow.clip,
          text: TextSpan(
              children: [
                TextSpan(
                  text: "${champ}:\n",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight:FontWeight.bold,
                      color: Colors.blue
                  ),

                ),
                TextSpan(
                    text: "${champInformation}",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey[700],
                      overflow: TextOverflow.clip

                    )
                )
              ]
          )
      ),
    );
  }
}
