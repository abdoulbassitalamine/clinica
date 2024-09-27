
import 'package:clinica/screens/patients/medical_information.dart';
import 'package:clinica/screens/patients/personnel_information.dart';
import 'package:flutter/material.dart';

class TabPatientDetailsScreens extends StatefulWidget {


  @override
  State<TabPatientDetailsScreens> createState() => _TabPatientDetailsScreensState();
}

class _TabPatientDetailsScreensState extends State<TabPatientDetailsScreens> {
  @override
  Widget build(BuildContext context) {

    return DefaultTabController(length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Details du patients"),
          bottom:TabBar(tabs: [
            Tab(text: "Information pesonnel",),
            Tab(text: 'Dossier Medical',)
          ],) ),
          body: TabBarView(
            children: [
              PersonnelInformation(id: 'le nomm',),
              MedicalInformation(patientId: 'le nom',)


            ],

          ),

        )
    );
  }
}
