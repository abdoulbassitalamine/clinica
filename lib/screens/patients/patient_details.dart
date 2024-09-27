
import 'package:clinica/screens/patients/personnel_information.dart';
import 'package:clinica/screens/patients/tab_patient_details_screens.dart';
import 'package:flutter/material.dart';

import 'medical_information.dart';

class PatientDetails extends StatefulWidget {
  static const nameRoute='/patient-details';

  @override
  State<PatientDetails> createState() => _PatientDetaisState();
}

class _PatientDetaisState extends State<PatientDetails> {
  @override
  Widget build(BuildContext context) {
    final name=ModalRoute.of(context)?.settings.arguments as String;
    print(name);
    return  DefaultTabController(length: 2,
        child: Scaffold(
          appBar: AppBar(
              title: Text("Details du patients"),
              bottom:TabBar(tabs: [
                Tab(text: "Information pesonnel",),
                Tab(text: 'Dossier Medical',)
              ],) ),
          body: TabBarView(
            children: [
              PersonnelInformation(id: name,),
              MedicalInformation(patientId: name,)


            ],

          ),

        )
    );
  }
}
