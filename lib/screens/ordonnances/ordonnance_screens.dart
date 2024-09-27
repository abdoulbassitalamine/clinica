import 'package:clinica/screens/ordonnances/prescriptions_screens.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
class OrdonnanceScreens extends StatefulWidget {
  static const routeNamed="/ordonnance-screens";
  const OrdonnanceScreens({Key? key}) : super(key: key);

  @override
  State<OrdonnanceScreens> createState() => _OrdonnanceScreensState();
}

class _OrdonnanceScreensState extends State<OrdonnanceScreens> {
  final _formKey = GlobalKey<FormState>();
  final _dateController=TextEditingController();
  final _nomPatientController=TextEditingController();
  final format = DateFormat("dd/MM/yyyy");
  int _idOrdonnnance=0;
  final  Stream<QuerySnapshot> _ordnnanceStream = FirebaseFirestore.instance.collection('ordonnances').orderBy('id_ordonnance',descending: true).snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ordonnance'),),
      body: StreamBuilder<QuerySnapshot>(
        stream: _ordnnanceStream,
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
                   onTap: (){
                     Navigator.of(context).pushNamed(PrescriptionsScreens.routeNamed,arguments:data['id_ordonnance'] );
                   },
                   child: ListTile(
                     leading: Text(data['id_ordonnance'],
                     style: TextStyle(
                       color: Colors.teal
                     ),),
                     title:Text(data['date_ordonnance']) ,
                     subtitle: Text(data['nom_prenom_patient']),
                     trailing:IconButton
                       (onPressed: (){

                       showDialog(
                           barrierDismissible: false,
                           context: context,
                           builder: (BuildContext conntex){
                             return AlertDialog(
                               title: const Text('Confirmation'),
                               content: const Text('Voulez-vous supprimer cette ordonnance?'),
                               scrollable: true,
                               actions: [
                                 TextButton(
                                     onPressed: (){
                                       FirebaseFirestore.instance
                                           .collection('ordonnances')
                                           .where("id_ordonnance", isEqualTo: data['id_ordonnance'])
                                           .get()
                                           .then((value) => value.docs.forEach((document) {

                                         FirebaseFirestore.instance
                                             .collection('ordonnances')
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
                       );


                     },
                         icon:Icon(
                           Icons.clear,
                           color: Colors.red,
                         )                  ),

                   ),
                 ),
                 Divider(
                   thickness: 3,
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
        onPressed: (){
          showDialog(
              barrierDismissible: false,
              context: context,
              builder:(BuildContext context){
                return AlertDialog(
                  scrollable: true,
                  title: Text('Formulaire'),
                  content: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          DateTimeField(
                            controller: _dateController,
                            decoration: InputDecoration(
                              labelText: 'Date',
                              icon: Icon(Icons.calendar_today),
                            ),
                            validator: (value) {
                              if (value == null) {
                                return 'Please enter some text';
                              }
                              return null;
                            },


                            format:format ,
                            onShowPicker: (context, currentValue) {
                              return showDatePicker(
                                  context: context,
                                  firstDate: DateTime(1900),
                                  initialDate: currentValue ?? DateTime.now(),
                                  lastDate: DateTime(2100));
                            },
                          ),


                          TextFormField(
                            controller: _nomPatientController,
                            decoration: InputDecoration(
                              labelText: 'Nom et Prenom du patient',
                              hintText: 'Ali Moussa',


                            ),
                            validator: (value) {
                              if (value == null) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                          ),
                        ],
                      ),
                    ),
                  ),
                  actions: [
                    ElevatedButton(
                        child: Text("Enregistrer"),
                        onPressed: () {
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }
                          _formKey.currentState!.save();

                          operation();
                          Navigator.pop(context);

                        })
                  ],
                );
              }
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
  void operation() {
    // [START get_data_once_get_a_document]
    final docRef = FirebaseFirestore.instance.collection("donnees_configurations").doc("document_reference");
    docRef.get().then(
          (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        setState((){
          _idOrdonnnance=data['indice_ordonnance'];
        });
        FirebaseFirestore.instance.collection("ordonnances").add(
            {
              'id_ordonnance':"ordonnance$_idOrdonnnance",
              'nom_prenom_patient':_nomPatientController.value.text,
              'date_ordonnance':_dateController.value.text,



            }
        );

        //_idConsultation=data['indice_consultation'];
        print("nouvelle valeur ${_idOrdonnnance}");
        FirebaseFirestore.instance.collection( "donnees_configurations").doc("document_reference")
            .update({"indice_ordonnance": _idOrdonnnance + 1}).then(
                (value) => print("DocumentSnapshot successfully updated!"),
            onError: (e) => print("Error updating document $e"));


        // ...
      },
      onError: (e) => print("Error getting document: $e"),
    );
    // [END get_data_once_get_a_document]
  }
}
