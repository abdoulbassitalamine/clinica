import 'package:clinica/providers/examen_clinique.dart';

class ExamenComplementaire{
  late String resultat_examen_complementaire;
  String? photo_resultat;
  late int num_exam;
  late String desc_exam;
  ExamenComplementaire({
    required this.num_exam,
    required this.desc_exam,
    this.photo_resultat,
    required this.resultat_examen_complementaire

});

}