import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class ConsultationDetails extends StatelessWidget {
  static const routeNamed='/consultation-details';
  const ConsultationDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _idConsultation=ModalRoute.of(context)!.settings.arguments as int;
    final  Stream<QuerySnapshot> _consultationStream = FirebaseFirestore.instance.collection('consultations')
        .where('numero_consultation', isEqualTo: _idConsultation).snapshots();
    return Scaffold(
      appBar: AppBar(
        title: Text('Consultation details'),
      ),
      body:  StreamBuilder<QuerySnapshot>(
        stream: _consultationStream,
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
              return Padding(
                padding: EdgeInsets.only(top: 40),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100]
                  ),
                  height: MediaQuery.of(context).size.height*0.4,
                  width:MediaQuery.of(context).size.width*0.9 ,
                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Center(child: Text('Details'),),
                      information("Date de consultation", data['date_consulation']),
                      information("Heure de consultation", data['heure_consultation']),
                      information('Motif', data['motif']),
                      information("Diagnostic", data['diagnostic'])

                    ],
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
                        color: Colors.grey[700]

                    )
                )
              ]
          )
      ),
    );
  }
}
