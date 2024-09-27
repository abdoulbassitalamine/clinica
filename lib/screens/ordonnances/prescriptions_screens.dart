import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


import '../../configurations/button_widget.dart';
import '../../configurations/pdf_api.dart';
import '../../configurations/pdf_paragraph_api.dart';

class PrescriptionsScreens extends StatefulWidget {
  static const routeNamed="/prescriptions-screens";
  const PrescriptionsScreens({Key? key}) : super(key: key);


  @override
  State<PrescriptionsScreens> createState() => _PrescriptionsScreensState();
}

class _PrescriptionsScreensState extends State<PrescriptionsScreens> {
  final _formKey = GlobalKey<FormState>();
  final _medicamentController=TextEditingController();
  final _posologieController=TextEditingController();
  int _idPrescription=0;
  late String ordonnanId;
    List<String> listeMsed=[];
   List<String> listePos=[];


  @override
  Widget build(BuildContext context) {
    final _ordonnanceId=ModalRoute.of(context)!.settings.arguments as String;
    ordonnanId=_ordonnanceId;
    final  Stream<QuerySnapshot> _prescriptionStream = FirebaseFirestore.instance.collection('prescriptions').
    where('id_ordonnance', isEqualTo: ordonnanId).snapshots();
    return Scaffold(
      appBar: AppBar(title: Text('les prescriptions'),

     actions: [
       IconButton(

         onPressed:null,
         icon: Icon(Icons.save,
         size: 30,),
       ),
     ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _prescriptionStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                semanticsLabel: "chargement",
                semanticsValue: "Patientez",
              ),
            );
          }

          return ListView(
            children: snapshot.data!.docs
                .map((DocumentSnapshot document) {
              Map<String, dynamic> data =
              document.data()! as Map<String, dynamic>;
              listeMsed.add(data['medicament']);
              listePos.add(data['posologie']);

              print(listeMsed);
              print(listePos);
              print('-------------------------------------------------');

              return ListTile(
                title:Text( data['medicament']),
                subtitle: Text(data['posologie']),
                trailing:  IconButton
                  (onPressed: (){

                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext conntex){
                        return AlertDialog(
                          title: const Text('Confirmation'),
                          content: const Text('Voulez-vous supprimer cette prescription'),
                          scrollable: true,
                          actions: [
                            TextButton(
                                onPressed: (){
                                  FirebaseFirestore.instance
                                      .collection('prescriptions')
                                      .where("id_prescription", isEqualTo: data['id_prescription'])
                                      .get()
                                      .then((value) => value.docs.forEach((document) {

                                    FirebaseFirestore.instance
                                        .collection('prescription')
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


                          TextFormField(
                            controller: _medicamentController,
                            decoration: InputDecoration(
                              labelText: 'Medicament',
                              hintText: 'Doliprane 80mg',


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
                            controller: _posologieController,
                            decoration: InputDecoration(
                              labelText: 'Posologie',
                              hintText: '2 fois par semaine',


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
        child: new Icon(Icons.add),

      ),

      bottomNavigationBar: ButtonWidget(
        text: 'Generer Une ordonnance',
        onClicked: () async {
          final pdfFile =
          await PdfApi.generateCenteredText('Dr Abdoul Bassit','01/02/2020','Issa',listeMsed,listePos);

          PdfApi.openFile(pdfFile);
        },
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
          _idPrescription=data['indice_prescription'];
        });
        FirebaseFirestore.instance.collection("prescriptions").add(
            {

              'id_ordonnance':"prescription$_idPrescription",
              'id_ordonnance':ordonnanId,
              'medicament':_medicamentController.value.text,
              'posologie':_posologieController.value.text,



            }
        );

        //_idConsultation=data['indice_consultation'];
        print("nouvelle valeur ${_idPrescription}");
        FirebaseFirestore.instance.collection( "donnees_configurations").doc("document_reference")
            .update({"indice_prescription": _idPrescription + 1}).then(
                (value) => print("DocumentSnapshot successfully updated!"),
            onError: (e) => print("Error updating document $e"));


        // ...
      },
      onError: (e) => print("Error getting document: $e"),
    );
    // [END get_data_once_get_a_document]
  }
}

