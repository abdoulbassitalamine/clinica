import 'package:clinica/screens/patients/patients_sceen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
final user = FirebaseAuth.instance.currentUser!;

class PatientForm extends StatefulWidget {
  const PatientForm({Key? key}) : super(key: key);
  static const routeNamed="/patient-form";

  @override
  State<PatientForm> createState() => _PatientFormState();
}

class _PatientFormState extends State<PatientForm> {

  int _idPatient=0;
  final format = DateFormat("dd/MM/yyyy");
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _nomController=TextEditingController();
  final _prenomController=TextEditingController();
  final _dateDeNaissanceController=TextEditingController();
  final _cinController=TextEditingController();
  final _adresseController=TextEditingController();
  final _professionController=TextEditingController();
  final _sexeController=TextEditingController();
  final _telephoneController=TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ajout de patient'),),
      body: Padding(
        padding: const EdgeInsets.only(left: 15,right: 15,top: 40),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(

                keyboardType: TextInputType.text,
                controller: _nomController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    labelText: "Nom"
                ),
              ),
              TextFormField(

                keyboardType: TextInputType.text,
                controller: _prenomController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    labelText: "Prenom"
                ),
              ),
              TextFormField(

                keyboardType: TextInputType.text,
                controller: _cinController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    labelText: "CIN"
                ),
              ),
              TextFormField(

                keyboardType: TextInputType.text,
                controller: _adresseController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    labelText: "Adresse"
                ),
              ),
              TextFormField(

                keyboardType: TextInputType.text,
                controller: _professionController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    labelText: "Profession"
                ),
              ),
              TextFormField(

                keyboardType: TextInputType.text,
                controller: _sexeController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    labelText: "Sexe"
                ),
              ),
              TextFormField(

                keyboardType: TextInputType.number,
                controller: _telephoneController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    labelText: "Telephone"
                ),
              ),
              DateTimeField(
                controller: _dateDeNaissanceController,
                decoration: InputDecoration(
                  labelText: 'Date de naissance',
                  icon: Icon(Icons.calendar_today),
                ),
                validator: (value) {
                  if (value == null ) {
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



              Padding(
                padding: const EdgeInsets.all(100.0),
                child: ElevatedButton(
                    onPressed   : (){
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }

                      _formKey.currentState!.save();
                      operation();



                      // print(_dateController.text);
                     Navigator.of(context).pop();




                    },
                    child: Text("Ajouter")
                ),
              )
            ],
          ),
        ),
      ) ,
    );
  }
  void operation() {
    // [START get_data_once_get_a_document]
    final docRef = FirebaseFirestore.instance.collection("donnees_configurations").doc("document_reference");
    docRef.get().then(
          (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        setState((){
          _idPatient=data['indice_patient'];
        });
        FirebaseFirestore.instance.collection("patients").add(
            {
              'nom':_nomController.value.text,
              'prenom':_prenomController.value.text,
              'date_de_naissance':_dateDeNaissanceController.value.text,
              'cin':_cinController.value.text,
              'adresse':_adresseController.value.text,
              'profession':_professionController.value.text,
              'sexe':_sexeController.value.text,
              'telephone':_telephoneController.value.text,
              'num_fiche_patient':"patient$_idPatient",
              "id_medecin":user.uid


            }
        );

        //_idConsultation=data['indice_consultation'];
        print("nouvelle valeur ${_idPatient}");
        FirebaseFirestore.instance.collection( "donnees_configurations").doc("document_reference")
            .update({"indice_patient": _idPatient + 1}).then(
                (value) => print("DocumentSnapshot successfully updated!"),
            onError: (e) => print("Error updating document $e"));


        // ...
      },
      onError: (e) => print("Error getting document: $e"),
    );
    // [END get_data_once_get_a_document]
  }
}
