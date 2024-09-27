import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class AntecedentDetails extends StatelessWidget {
  static const routeNamed='/antecedent-details';
  const AntecedentDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _idAntecedent=ModalRoute.of(context)!.settings.arguments as String;
    final  Stream<QuerySnapshot> _antecedentStream = FirebaseFirestore.instance.collection('antecedents')
        .where('id_antecedent', isEqualTo: _idAntecedent).snapshots();
    return Scaffold(
      appBar: AppBar(title: Text('details'),),
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
              return Padding(
                padding: EdgeInsets.only(top: 40),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[100]
                  ),
                  height: MediaQuery.of(context).size.height*0.3,
                  width:MediaQuery.of(context).size.width*0.9 ,
                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Center(child: Text('Details'),),
                      information("Nom de l\'antecedent", data['titre']),
                      information("Description", data['description_antecedent']),


                    ],
                  ),
                ),

              );
            })
                .toList()
                .cast(),
          );
        },
      ),
    );
  }
  Widget information(String champ,var champInformation){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RichText(
          overflow: TextOverflow.clip,
          text: TextSpan(
              children: [
                TextSpan(
                  text: "${champ}:\n",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight:FontWeight.bold,
                      color: Colors.blue
                  ),

                ),
                TextSpan(
                    text: "${champInformation}",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey[700]

                    )
                )
              ]
          )
      ),
    );
  }
}
