class Patient{
  late String num_fiche_patient;
  late String nom;
  late String prenom;
  late String cin;
  late String date_naissance;
  late String profesion;
  late String adresse;
   String? telephone;
  late String sexe ;
   String id_medeicn;

  Patient({
    required this.num_fiche_patient,
    required this.nom,
    required this.prenom,
    required this.cin,
    required this.date_naissance,
    required this.profesion,
    this.telephone,
    required this.sexe,
    required this.adresse,
    required this.id_medeicn

});




}