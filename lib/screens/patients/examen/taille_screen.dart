import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
class TailleScreen extends StatefulWidget {
  static const routeNamed="/taille-screens";
  const TailleScreen({Key? key}) : super(key: key);

  @override
  State<TailleScreen> createState() => _TailleScreenState();
}

class _TailleScreenState extends State<TailleScreen> {
  final _formKey = GlobalKey<FormState>();
  final _dateController=TextEditingController();
  final _timeController=TextEditingController();
  final _tailleController=TextEditingController();
  final format = DateFormat("dd-MMMM-yyyy");
  final formatTime = DateFormat("HH:mm");
  int _idtaille=0;
  late String patientId;
  @override
  Widget build(BuildContext context) {
    final _patientId=ModalRoute.of(context)!.settings.arguments as String;
    patientId=_patientId;
    final  Stream<QuerySnapshot> _tailleStream = FirebaseFirestore.instance.collection('tailles').
    where('patient_id', isEqualTo: _patientId).snapshots();
    return Scaffold(
      appBar: AppBar(
        title: Text("Taille"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _tailleStream,
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
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(data['date_taille']+" , "+data['heure_taille'],
                  style: TextStyle(
                    fontSize: 18
                  ),),
                  Text("${data['valeur_taille']}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                  ),),
                  Text("cm",
                    style: TextStyle(
                        fontSize: 18
                    ),
                  ),
                  IconButton
                    (onPressed: (){
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext conntex){
                          return AlertDialog(
                            title: const Text('Confirmation'),
                            content: const Text('Voulez-vous supprimer cette taille?'),
                            scrollable: true,
                            actions: [
                              TextButton(
                                  onPressed: (){
                                    FirebaseFirestore.instance
                                        .collection('tailles')
                                        .where("taille_id", isEqualTo: data['taille_id'])
                                        .get()
                                        .then((value) => value.docs.forEach((document) {

                                      FirebaseFirestore.instance
                                          .collection('tailles')
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
                            DateTimeField(
                              controller: _timeController,
                              format: formatTime,
                              decoration: InputDecoration(
                                labelText: 'Time',
                                icon: Icon(Icons.timer),
                              ),
                              validator: (value) {
                                if (value == null) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },

                              onShowPicker: (context, currentValue) async {
                                final time = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                                );
                                return DateTimeField.convert(time);
                              },
                            ),

                            TextFormField(
                              controller: _tailleController,
                              decoration: InputDecoration(
                                labelText: 'Taille',
                                icon: Icon(Icons.height ),

                              ),
                              validator: (value) {
                                if (value == null) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
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
                            // FirebaseFirestore.instance.collection("tailles").add(
                            //     {
                            //
                            //       'patient_id':_patientId,
                            //       'valeur_taille':_tailleController.value.text,
                            //       'date_taille':_dateController.value.text,
                            //       'heure_taille':_timeController.value.text,
                            //
                            //     }
                            // );
                            operation();
                            Navigator.pop(context);

                          })
                    ],
                  );
                }
            );


          },
        child: new Icon(Icons.add),

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
          _idtaille=data['indice_taille'];
        });
        FirebaseFirestore.instance.collection("tailles").add(
            {
              'taille_id':"taille$_idtaille",
              'patient_id':patientId,
              'valeur_taille':_tailleController.value.text,
              'date_taille':_dateController.value.text,
              'heure_taille':_timeController.value.text,


            }
        );

        //_idConsultation=data['indice_consultation'];
        print("nouvelle valeur ${_idtaille}");
        FirebaseFirestore.instance.collection( "donnees_configurations").doc("document_reference")
            .update({"indice_taille": _idtaille + 1}).then(
                (value) => print("DocumentSnapshot successfully updated!"),
            onError: (e) => print("Error updating document $e"));


        // ...
      },
      onError: (e) => print("Error getting document: $e"),
    );
    // [END get_data_once_get_a_document]
  }
}
