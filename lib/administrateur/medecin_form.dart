import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class MedecinForm extends StatefulWidget {
  const MedecinForm({Key? key}) : super(key: key);
  static const routeNamed="/medecin-form";

  @override
  State<MedecinForm> createState() => _MedecinFormState();
}

class _MedecinFormState extends State<MedecinForm> {
  int _idMedecin=0;
  late String medecinId;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _nomController=TextEditingController();
  final _prenomController=TextEditingController();
  final _emailController=TextEditingController();
  final _specicilteController=TextEditingController();
  final _telephoneController=TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Ajout'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),

        child: Form(
          key: _formKey,
          child: ListView(

            children: [

              TextFormField(
                controller: _nomController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    labelText: "Nom"
                ),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },

              ),
              TextFormField(
                controller: _prenomController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    labelText: "Prenom"
                ),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },

              ),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    labelText: "email"
                ),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },

              ),
              TextFormField(
                controller: _telephoneController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "numero"
                ),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },

              ),
              TextFormField(
                controller: _specicilteController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    labelText: "Specialite"
                ),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },

              ),
              Padding(
                padding: const EdgeInsets.all(100.0),
                child: ElevatedButton(
                    onPressed   : (){
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }

                      _formKey.currentState!.save();
                      operation();


                      // FirebaseFirestore.instance.collection("consultations").add(
                      //   {
                      //     'date_consulation':_dateController.value.text,
                      //     'diagnostic':_diagnosticController.value.text,
                      //     'motif':_motifController.value.text,
                      //     'numero_consultation':_idConsultation,
                      //     'id_patient':_idPatient
                      //   }
                      // );


                      Navigator.pop(context);




                    },
                    child: Text("Sauvegarder")
                ),
              )

            ],
          ),
        ),

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
          _idMedecin=data['indice_medecin'];
        });
        FirebaseFirestore.instance.collection("medecin").add(
            {
              'nom':_nomController.value.text,
              'prenom':_prenomController.value.text,
              'email':_emailController.value.text,
              'specialite':_specicilteController.value.text,
              'Telephone':_telephoneController.value.text,
              'id_medecin':"medecin ${_idMedecin}"
            }
        );

        //_idConsultation=data['indice_consultation'];
        print("nouvelle valeur ${_idMedecin}");
        FirebaseFirestore.instance.collection( "donnees_configurations").doc("document_reference")
            .update({"indice_medecin": _idMedecin + 1}).then(
                (value) => print("DocumentSnapshot successfully updated!"),
            onError: (e) => print("Error updating document $e"));


        // ...
      },
      onError: (e) => print("Error getting document: $e"),
    );
    // [END get_data_once_get_a_document]
  }
}

