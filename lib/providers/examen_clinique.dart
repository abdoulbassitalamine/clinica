import 'package:clinica/providers/examen.dart';
import 'package:flutter/material.dart';

class ExamenClinique {
  late int num_exam;
  late String desc_exam;

   double ?taille_patient;
   double ?tension_arterielle;
   double? poids;
   double? temperature;
   late int num;
   late String desc;

   ExamenClinique({
     required this.num_exam,
     required this.desc_exam,
     this.taille_patient,
     this.poids,
     this.temperature,
     this.tension_arterielle
}) ;


}