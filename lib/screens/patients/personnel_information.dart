import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PersonnelInformation extends StatelessWidget {
  String id;
   PersonnelInformation({Key? key,required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   // FirebaseFirestore db=FirebaseFirestore.instance.collection("patients") as FirebaseFirestore;
    final Stream<QuerySnapshot> _patientStream=FirebaseFirestore.instance.collection("patients").where('num_fiche_patient',isEqualTo: this.id).snapshots();

    return  Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: _patientStream,
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
                  Center(
                    child: CircleAvatar(
                      radius: 90,
                      backgroundImage: AssetImage("images/user_p.png"),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 25),
                    child: Center(
                      child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            information('Nom:',data['nom']),
                            information("Prenom", data['prenom']),
                            information("date de naissance", data['date_de_naissance']),
                            information("Profession", data['profession']),
                            information("Adresse", data['adresse']),
                            information("CIN", data['cin']),
                            information("Telephone", data['telephone']),
                            information("Sexe", data['sexe']),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 270),
                    child: ElevatedButton(
                        onPressed: (){},
                        child: Text("Modifier")
                    ),
                  )

                ],
              );


            })
                .toList()
                .cast(),
          );
        },
      ),
    );
      /*Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

      children: [
        Center(
          child: CircleAvatar(
            radius: 90,
            backgroundImage: AssetImage("images/user_p.png"),
          ),
        ),
        Card(
          child: Column(

            children: [
              information('Nom:', this.id),
              information("Prenom", ''),
              information("date de naissance", "08/01/2001"),
              information("Profession", "Etudiant"),
              information("Adresse", "Cite Universitaire de Tetouan"),
              information("CIN", "10lx005"),
              information("Telephone", "+2120767888540"),
              information("Sexe", "Masculin"),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 270),
          child: ElevatedButton(
              onPressed: (){},
              child: Text("Modifier")
          ),
        )

      ],
    );*/
  }
   Widget information(String champ,var champInformation){
   return Padding(
     padding: const EdgeInsets.all(8.0),
     child: RichText(
       overflow: TextOverflow.clip,
         text: TextSpan(
           children: [
             TextSpan(
               text: "${champ}:",
               style: TextStyle(
                   fontSize: 20,
                   fontWeight:FontWeight.bold,
                   color: Colors.grey[700]
               ),

             ),
             TextSpan(
               text: "${champInformation}",
               style: TextStyle(
                 fontSize: 20,
                 color: Colors.grey

               )
             )
           ]
         )
     ),
   );
  }
}