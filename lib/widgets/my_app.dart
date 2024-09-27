import 'package:clinica/administrateur/medecin_details.dart';
import 'package:clinica/administrateur/medecin_form.dart';
import 'package:clinica/administrateur/rapport_screens.dart';
import 'package:clinica/authentification/welcome_page.dart';
import 'package:clinica/providers/patients.dart';
import 'package:clinica/screens/facturation_screen.dart';
import 'package:clinica/screens/ordonnances/ordonnance_screens.dart';
import 'package:clinica/screens/ordonnances/prescriptions_screens.dart';
import 'package:clinica/screens/patients/antecedent_details.dart';
import 'package:clinica/screens/patients/antecedent_form.dart';
import 'package:clinica/screens/patients/antecedent_screens.dart';
import 'package:clinica/screens/patients/consultation_details.dart';
import 'package:clinica/screens/patients/consultation_form.dart';
import 'package:clinica/screens/patients/examen/examen_screens.dart';
import 'package:clinica/screens/patients/examen/poids_screen.dart';
import 'package:clinica/screens/patients/examen/taille_screen.dart';
import 'package:clinica/screens/patients/examen/temperature_screen.dart';
import 'package:clinica/screens/patients/patient_details.dart';
import 'package:clinica/screens/patients/patients_sceen.dart';
import 'package:clinica/screens/rendez_vous_screens.dart';
import 'package:clinica/utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clinica/screens/patients/consultation_screens.dart';

import '../main.dart';
import '../screens/home/my_home_page.dart';
import '../screens/patients/examen/pression_arterielle_screen.dart';
import 'package:clinica/authentification/login_widget.dart';

import '../screens/patients/patient_form.dart';
class MyApp extends StatelessWidget {
 // final Future<FirebaseApp> _fbApp = Firebase.initializeApp();


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: Utils.messengerKey,
      navigatorKey: navigatorKey,
        title: 'Application de clinique',
        theme: ThemeData(

          primarySwatch: Colors.blue,
        ),
        home:  MainPage(),
        // home: FutureBuilder(
        //     future: _fbApp,
        //     builder: (context, snaphot) {
        //       if (snaphot.hasError) {
        //         print("An error occure${snaphot.error.toString()}");
        //       }
        //       else if (snaphot.hasData) {
        //         print("Firebase bien connecte");
        //         return MyHomePage();
        //       }
        //       else
        //         return Center(child: CircularProgressIndicator()
        //         );
        //       return
        //       Center(child: Text("une page"),);
        //     }
        // ),
        routes: {
          PatientsScreen.nameRoute: (ctx) => PatientsScreen(),
          PatientDetails.nameRoute: (ctx) =>PatientDetails(),
          ConsultationScreens.routeNamed: (ctx) => ConsultationScreens(),
          ConsultationForm.routeNamed:(ctx) =>ConsultationForm(),
          ConsultationDetails.routeNamed:(ctx)=>ConsultationDetails(),
          AntecedentScreens.routeNamed:(ctx)=>AntecedentScreens(),
          AntecedentForm.routeNamed:(ctx)=>AntecedentForm(),
          AntecedentDetails.routeNamed:(ctx)=>AntecedentDetails(),
          ExamenScreens.routeNamed:(ctx)=>ExamenScreens(),
          TailleScreen.routeNamed:(ctx)=>TailleScreen(),
          TemperatureScreen.routeNamed:(ctx)=>TemperatureScreen(),
          PoidsScreen.routeNamed:(ctx)=>PoidsScreen(),
          PressionArterielleScreen.routeNamed:(ctx)=>PressionArterielleScreen(),
          RendezVousScreens.routeNamed:(ctx)=>RendezVousScreens(),
          OrdonnanceScreens.routeNamed:(ctx)=>OrdonnanceScreens(),
          PrescriptionsScreens.routeNamed:(ctx)=>PrescriptionsScreens(),
          FacturationScreen.routeNamed: (ctx)=>FacturationScreen(),
          WelcomPage.routeNamed :(ctx)=>WelcomPage(),
         // LoginWidget.routeNamed:(ctx)=>LoginWidget()
          RappotScreens.routeNamed:(ctx)=>RappotScreens(),
          MedecinForm.routeNamed:(ctx)=> MedecinForm(),
          MedecinDeatils.nameRoute:(ctx)=>MedecinDeatils(),
          PatientForm.routeNamed:(ctx)=>PatientForm()




        }
    );
  }
}
