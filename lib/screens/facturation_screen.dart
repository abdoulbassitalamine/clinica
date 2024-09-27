import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../configurations/pdf_api.dart';



class FacturationScreen extends StatefulWidget {
  const FacturationScreen({Key? key}) : super(key: key);
  static const routeNamed="/facturation-screens";

  @override
  State<FacturationScreen> createState() => _FacturationScreenState();
}

class _FacturationScreenState extends State<FacturationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _dateController=TextEditingController();
  final _montantController=TextEditingController();
  final _securiteSocilaController=TextEditingController();
  final _nomPatientController=TextEditingController();
  final format = DateFormat("dd/MM/yyyy");
  int _idFacure=0;
  final  Stream<QuerySnapshot> _facturationStream = FirebaseFirestore.instance.collection('facturations').orderBy('id_facture',descending: true).snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:StreamBuilder<QuerySnapshot>(
        stream: _facturationStream,
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
                  ListTile(
                    leading: Text(data['id_facture'],
                      style: TextStyle(
                          color: Colors.teal
                      ),),
                    title:Text(data['date']) ,
                    subtitle: Text(data['nom_prenom']),
                    trailing:IconButton
                      (onPressed: (){

                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext conntex){
                            return AlertDialog(
                              title: const Text('Confirmation'),
                              content: const Text('Voulez-vous supprimer cette facture?'),
                              scrollable: true,
                              actions: [
                                TextButton(
                                    onPressed: (){
                                      FirebaseFirestore.instance
                                          .collection('facturations')
                                          .where("id_facture", isEqualTo: data['id_facture'])
                                          .get()
                                          .then((value) => value.docs.forEach((document) {

                                        FirebaseFirestore.instance
                                            .collection('facturations')
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 70.0),
                      child: Text('${data['montant']} dhrs',
                      style: TextStyle(
                        fontSize: 18
                      ),

                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: IconButton
                        (onPressed: () async {
                        final pdfFile =
                        await PdfApi.generateFacture("Dr Abdoul Bassit", data['date'],data['nom_prenom'], data['securite_sociale'], data['id_facture'], data['montant']);

                        PdfApi.openFile(pdfFile);
                      },

                    icon:Icon(
                            Icons.save,
                            color: Colors.blueAccent,
                          )                  ),
                    ),
                  ],
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
                          TextFormField(
                            controller: _securiteSocilaController,
                            decoration: InputDecoration(
                              labelText: 'securite sociale',
                              hintText: '1152584884',


                            ),
                            validator: (value) {
                              if (value == null) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                          ),
                          TextFormField(
                            controller: _montantController,
                            decoration: InputDecoration(
                              labelText: 'Montant',
                              hintText: '250',


                            ),
                            validator: (value) {
                              if (value == null) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
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
          _idFacure=data['indice_facture'];
        });
        FirebaseFirestore.instance.collection("facturations").add(
            {
              'id_facture':"facture$_idFacure",
              'nom_prenom':_nomPatientController.value.text,
              'date':_dateController.value.text,
              'montant':int.parse(_montantController.value.text),
              'securite_sociale':_securiteSocilaController.value.text,
              'id_medecin':'med12'



            }
        );

        //_idConsultation=data['indice_consultation'];
        print("nouvelle valeur ${_idFacure}");
        FirebaseFirestore.instance.collection( "donnees_configurations").doc("document_reference")
            .update({"indice_facture": _idFacure + 1}).then(
                (value) => print("DocumentSnapshot successfully updated!"),
            onError: (e) => print("Error updating document $e"));


        // ...
      },
      onError: (e) => print("Error getting document: $e"),
    );
    // [END get_data_once_get_a_document]
  }
}
