import 'package:clinica/screens/patients/consultation_details.dart';
import 'package:clinica/screens/patients/consultation_form.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ConsultationScreens extends StatefulWidget {
   static const routeNamed="/consultation";

  @override
  State<ConsultationScreens> createState() => _ConsultationScreensState();
}

class _ConsultationScreensState extends State<ConsultationScreens> {


  @override
  Widget build(BuildContext context) {
    final _patientId=ModalRoute.of(context)!.settings.arguments as String;
    final  Stream<QuerySnapshot> _consultationStream = FirebaseFirestore.instance.collection('consultations').
    where('id_patient', isEqualTo: _patientId).snapshots();
    return Scaffold(
      appBar: AppBar(
        title: Text('Consultation'),
      ),
      body:  StreamBuilder<QuerySnapshot>(
        stream: _consultationStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return  CircularProgressIndicator();
          }


            return ListView(
              children: snapshot.data!.docs
                  .map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
                return Column(
                  children: [
                    InkWell(
                      onTap:(){
                        Navigator.of(context).pushNamed( ConsultationDetails.routeNamed,arguments: data['numero_consultation'] );
                      },
                      child: ListTile(
                        trailing:    IconButton
                          (onPressed: (){
                          FirebaseFirestore.instance
                              .collection('consultations')
                              .where("numero_consultation", isEqualTo: data['numero_consultation'])
                              .get()
                              .then((value) => value.docs.forEach((document) {

                            FirebaseFirestore.instance
                                .collection('consultations')
                                .doc(document.id)
                                .delete()
                                .then((_) {
                              print("success!");
                            });
                          }));

                        },
                          icon: Icon(
                              Icons.delete
                          ),
                        ),

                        title: Text(data['date_consulation'],
                          style: TextStyle(
                              fontWeight:FontWeight.bold,
                              fontSize: 20
                          ),),
                        subtitle: Text(data['motif']),
                      ),
                    ),
                    Divider(
                      height: 10,
                      color: Colors.black,
                      thickness: 1,
                    )
                  ],
                );
              })
                  .toList()
                  .cast(),
            );



        },
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Increment',
        onPressed: () {
          Navigator.of(context).pushNamed(ConsultationForm.routeNamed,arguments: _patientId);
        },
        child: new Icon(Icons.add),
      ),
    );
  }
}
