import 'package:clinica/providers/patient.dart';
import 'package:flutter/material.dart';
class Patients with ChangeNotifier{
  List<Patient> _listPatient=[];

  List<Patient> get listPatient => _listPatient;


  void addPatient(Patient pt){
    _listPatient.add(pt);
    notifyListeners();
  }

}