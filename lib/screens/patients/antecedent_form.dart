import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class AntecedentForm extends StatefulWidget {
  static const routeNamed="/antecedent-form";
  const AntecedentForm({Key? key}) : super(key: key);

  @override
  State<AntecedentForm> createState() => _AntecedentFormState();
}

class _AntecedentFormState extends State<AntecedentForm> {
  int _idAntecedent=0;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _titreController=TextEditingController();
  final _descriptionController=TextEditingController();
  late String patientId;

  @override
  Widget build(BuildContext context) {
    final _patientId=ModalRoute.of(context)!.settings.arguments as String;
    patientId=_patientId;
    return Scaffold(
      appBar: AppBar(),
      body:Padding(
        padding: const EdgeInsets.only(left: 15,right: 15,top: 40),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(

                keyboardType: TextInputType.text,
                controller: _titreController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: "Nom antecedent"
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Flexible(
                    flex: 2,
                      child: Text("Description:",
                      style: TextStyle(
                        fontSize: 18
                      ),)
                  ),
                  Flexible(
                      flex: 4,
                      child: TextFormField(
                        controller: _descriptionController,
                        keyboardType: TextInputType.multiline,
                        minLines: 1,
                        maxLines: 10,
                        decoration: InputDecoration(
                            border: OutlineInputBorder()
                        ),
                      )
                  )
                ],
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
                      Navigator.pop(context);




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
          _idAntecedent=data['indice_antecedent'];
        });
        FirebaseFirestore.instance.collection("antecedents").add(
            {
              'id_antecedent':"antecedent$_idAntecedent",
              'id_patient':patientId,
              'titre':_titreController.value.text,
              'description_antecedent':_descriptionController.value.text

            }
        );

        //_idConsultation=data['indice_consultation'];
        print("nouvelle valeur ${_idAntecedent}");
        FirebaseFirestore.instance.collection( "donnees_configurations").doc("document_reference")
            .update({"indice_antecedent": _idAntecedent + 1}).then(
                (value) => print("DocumentSnapshot successfully updated!"),
            onError: (e) => print("Error updating document $e"));


        // ...
      },
      onError: (e) => print("Error getting document: $e"),
    );
    // [END get_data_once_get_a_document]
  }
}

