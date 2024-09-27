
import 'package:clinica/screens/patients/patient_details.dart';
import 'package:clinica/screens/patients/patient_form.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/svg.dart';

import 'package:animations/animations.dart';
import '../../widgets/search_widget.dart';
List allPatient=[];
class PatientsScreen extends StatefulWidget {
  static const nameRoute='/patients-screens';



  @override
  State<PatientsScreen> createState() => _PatientsScreenState();
}

class _PatientsScreenState extends State<PatientsScreen> {
  late List patients;
  String query = '';

  @override
  // void initState() {
  //   super.initState();
  //   patients=allPatient;
  //   //allPatient = [];
  // }

  @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  // }

  @override
  final Stream<QuerySnapshot> _patientStream = FirebaseFirestore.instance
      .collection('patients').snapshots();


  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery
        .of(context)
        .size
        .width;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Liste des patients"),

      ),

      body: Column(
        children: [
          buildSearch(),
          /*    Padding(
            padding: const EdgeInsets.only(top: 18.0,
            bottom: 18),
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
               // borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 50,
                    color: Colors.blue.withOpacity(0.40),
                  ),
                ],
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        hintText: "rechercher un patient",
                        hintStyle: TextStyle(
                          color: Colors.blue.withOpacity(0.5),
                        ),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,

                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: (){

                    },

                      icon: SvgPicture.asset("icons/search.svg")),
                ],
              ),
            ),
          ),*/
          Container(
            height: 35,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.teal,

            ),
            child: Center(child: Text('Patients',
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.white
              ),),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _patientStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                // if (!allPatient.isEmpty) {
                //   allPatient = [];
                // }
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                snapshot.data!.docs.forEach((document) {
                  Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
                  allPatient.add(data);
                });
                // return ListView.builder(
                //     itemCount: patients.length,
                //     itemBuilder: (context, index) {
                //       final patient = patients[index];
                //       return InkWell(
                //         child: ListTile(
                //           title: Text(patient['nom']),
                //           subtitle: Text(patient['prenom']),
                //           trailing: IconButton(
                //             onPressed: ()=>  showDialog(
                //                 barrierDismissible: false,
                //                 context: context,
                //                 builder: (BuildContext context){
                //                   return AlertDialog(
                //                     title: const Text('Confirmation'),
                //                     content: const Text('confirmer'),
                //                     scrollable: true,
                //                     actions: [
                //                       TextButton(
                //                           onPressed: (){
                //                             FirebaseFirestore.instance
                //                                 .collection('patients')
                //                                 .where("num_fiche_patient", isEqualTo: patient['num_fiche_patient'])
                //                                 .get()
                //                                 .then((value) => value.docs.forEach((document) {
                //
                //                               FirebaseFirestore.instance
                //                                   .collection('patients')
                //                                   .doc(document.id)
                //                                   .delete()
                //                                   .then((_) {
                //                                 print("success!");
                //                               });
                //                             }));
                //                             Navigator.of(context).pop();
                //
                //                           },
                //                           child:Text('Oui') ),
                //                       TextButton(
                //                           onPressed: ()=>    Navigator.of(context).pop(),
                //                           child: Text('Non'))
                //                     ],
                //                   );
                //
                //
                //                 }
                //             )
                //             ,
                //             icon:Icon(
                //               Icons.delete,
                //
                //             ),
                //           ),
                //
                //         ),
                //         onTap: () {
                //           Navigator.of(context).pushNamed(PatientDetails
                //               .nameRoute,
                //               arguments: patient['num_fiche_patient']);
                //         },
                //       );
                //     }
                // );

                  return ListView(
                  children: snapshot.data!.docs
                      .map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;

                   allPatient.add(data);
                   print("Mes données:\n");print(allPatient);
                    return InkWell(
                      onTap:(){
                        Navigator.of(context).pushNamed( PatientDetails.nameRoute,arguments:data['num_fiche_patient']  );
                      },
                      child: ListTile(

                        title: Text(data['nom']),
                        subtitle: Text(data['prenom']),
                        trailing:IconButton(
                                onPressed: ()=>  showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (BuildContext context){
                                      return AlertDialog(
                                        title: const Text('Confirmation'),
                                        content: const Text('confirmer'),
                                        scrollable: true,
                                        actions: [
                                          TextButton(
                                              onPressed: (){
                                                FirebaseFirestore.instance
                                                    .collection('patients')
                                                    .where("num_fiche_patient", isEqualTo: data['num_fiche_patient'])
                                                    .get()
                                                    .then((value) => value.docs.forEach((document) {

                                                  FirebaseFirestore.instance
                                                      .collection('patients')
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

                            ),



                    );
                  })
                      .toList()
                      .cast(),
                );

              },
            ),
          ),

        ],
      ),
      bottomNavigationBar: Padding(

        padding: const EdgeInsets.only(
            right: 150,
            left: 150
        ),
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamed(PatientForm.routeNamed);
          },
          child: Text("Ajouter"),

        ),
      ),

    );
  }

  Widget buildSearch() =>
      SearchWidget(
        text: query,
        hintText: 'Rechercher un patient',
        onChanged: searchBook,
      );

  void searchBook(String query) {
    final books = allPatient.where((pat) {
      final titleLower = pat['nom'].toLowerCase();
      final authorLower = pat['prenom'].toLowerCase();
      final searchLower = query.toLowerCase();

      return titleLower.contains(searchLower) ||
          authorLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      this.patients = books;
    });
  }
}