import 'package:flutter/material.dart';
import 'package:clinica/configurations/date_time.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ConsultationForm extends StatefulWidget {
  static const routeNamed='/consultation-form';

  @override
  State<ConsultationForm> createState() => _ConsultationFormState();
}

class _ConsultationFormState extends State<ConsultationForm> {
    int _idConsultation=0;
    late String patientId;

  // late String _date;
  // late String _time;
  // late String _motif;
 // late String _diagnostic;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // final _idConsultationController=TextEditingController();
  // final _idPatientController=TextEditingController();
  final _dateController=TextEditingController();
  final _timeController=TextEditingController();
  final _motifController=TextEditingController();
  final _diagnosticController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _idPatient=ModalRoute.of(context)!.settings.arguments as String;
    patientId=_idPatient;
    return Scaffold(
      appBar: AppBar(
        title: Text("Formulaire"),
      ),
    body: Padding(
      padding: EdgeInsets.all(16),

      child: Form(
        key: _formKey,
        child: ListView(

          children: [

            Row(
              children: [
                Flexible(
                  flex: 3,
                  child:  BasicDateField(controller: _dateController,)

                  /*
                    child: TextFormField(

                      controller: _idConsultationController,
                      onSaved: (value){
                        _date=value!;
                      },
                      keyboardType: TextInputType.datetime,

                      decoration: InputDecoration(
                        labelText: 'Date'
                      ),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Date Required';
                        }

                        return null;
                      },

                    )*/
                ),
                Flexible(
                    child: IconButton(
                      icon: Icon(
                        Icons.calendar_today
                      ),
                      onPressed: null,
                    )
                ),
                Flexible(
                  flex: 2,
                  child: BasicTimeField(controller: _timeController,),
                ),
                  
                //     child: TextFormField(
                //       decoration: InputDecoration(
                //           labelText: 'Time'
                //       ),
                //     )
                // ),
                Flexible(
                    child: IconButton(
                      icon: Icon(
                          Icons.timer
                      ),
                      onPressed:null,
                    )
                ),

              ],
            ),
            TextFormField(
              controller: _motifController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Motif"
              ),
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },

            ),
            SizedBox(
              height: 30,
            ),

            Row(
              children: [
                Flexible(
                    child: Text("Diagnostic:    ")
                ),
                Flexible(
                  flex: 4,
                    child: TextFormField(
                      controller: _diagnosticController,
                      keyboardType: TextInputType.multiline,
                      minLines: 2,
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
                // operation();


                 FirebaseFirestore.instance.collection("consultations").add(
                   {
                     'date_consulation':_dateController.value.text,
                     'diagnostic':_diagnosticController.value.text,
                     'motif':_motifController.value.text,
                     'numero_consultation':_idConsultation,
                     'id_patient':_idPatient
                   }
                 );


                 print(_dateController.text);
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
           _idConsultation=data['indice_consultation'];
         });
         FirebaseFirestore.instance.collection("consultations").add(
             {
               'date_consulation':_dateController.value.text,
               'heure_consultation':_timeController.value.text,
               'diagnostic':_diagnosticController.value.text,
               'motif':_motifController.value.text,
               'numero_consultation':_idConsultation,
               'id_patient':patientId
             }
         );

         //_idConsultation=data['indice_consultation'];
         print("nouvelle valeur ${_idConsultation}");
         FirebaseFirestore.instance.collection( "donnees_configurations").doc("document_reference")
             .update({"indice_consultation": _idConsultation + 1}).then(
                 (value) => print("DocumentSnapshot successfully updated!"),
             onError: (e) => print("Error updating document $e"));

         
         // ...
       },
       onError: (e) => print("Error getting document: $e"),
     );
     // [END get_data_once_get_a_document]
   }

}
