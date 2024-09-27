import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'antecedent_details.dart';
import 'antecedent_form.dart';
class AntecedentScreens extends StatefulWidget {
  static const routeNamed="/antecedent-screens";
  const AntecedentScreens({Key? key}) : super(key: key);

  @override
  State<AntecedentScreens> createState() => _AntecedentScreensState();
}

class _AntecedentScreensState extends State<AntecedentScreens> {

  @override
  Widget build(BuildContext context) {
    final _patientId=ModalRoute.of(context)?.settings.arguments as String;
    final  Stream<QuerySnapshot> _antecedentStream = FirebaseFirestore.instance.collection('antecedents').
    where('id_patient', isEqualTo: _patientId).snapshots();
    return Scaffold(
      appBar: AppBar(
        title: Text('Antécédent'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _antecedentStream,
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
                children: [
                  InkWell(
                    onTap:(){
                     Navigator.of(context).pushNamed( AntecedentDetails.routeNamed,arguments: data['id_antecedent'] );
                    },
                    child: ListTile(
                      trailing:    IconButton
                        (onPressed: (){
                        FirebaseFirestore.instance
                            .collection('antecedents')
                            .where("id_antecedent", isEqualTo: data['id_antecedent'])
                            .get()
                            .then((value) => value.docs.forEach((document) {

                          FirebaseFirestore.instance
                              .collection('antecedents')
                              .doc(document.id)
                              .delete()
                              .then((_) {
                            print("success!");
                          });
                        }));

                      },
                        icon: Icon(
                            Icons.delete,
                          color: Colors.red,
                        ),
                      ),

                      title: Text(data['titre'],
                        style: TextStyle(
                            fontWeight:FontWeight.bold,
                            fontSize: 20
                        ),),

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
          Navigator.of(context).pushNamed(AntecedentForm.routeNamed,arguments: _patientId);
        },
        child: new Icon(Icons.add),
      ),
    );
  }
}
