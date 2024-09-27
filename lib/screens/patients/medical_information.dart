import 'package:clinica/screens/patients//consultation_screens.dart';
import 'package:clinica/screens/patients/examen/examen_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:clinica/screens/patients/antecedent_screens.dart';

class MedicalInformation extends StatelessWidget {
  String patientId;
  MedicalInformation({Key? key,required this.patientId}) : super(key: key);

  @override
  Widget build(BuildContext context) {

  final  double w=MediaQuery.of(context).size.width;
  final  double h=MediaQuery.of(context).size.height;
  return Container(
    height: h,
    width: w,
    decoration: BoxDecoration(),
    child: Column(

      children: [

       GestureDetector(
           child: dossier_item("Consultation", "images/consultation.png", h, w),
         onTap: (){
             Navigator.of(context).pushNamed(ConsultationScreens.routeNamed,arguments: patientId);
         },
       ),
        GestureDetector(
            child: dossier_item("Antecédent", "images/antecedent.png", h, w),
          onTap: (){
            Navigator.of(context).pushNamed(AntecedentScreens.routeNamed,arguments: patientId);
          },

        ), // GestureDetector(
        //     child: dossier_item("Acte opératoire", "images/surgery.jpg", h, w),
        //     onTap: ()=>Navigator.of(context).pushNamed(ExamenScreens.routeNamed,arguments:patientId)  ),
        GestureDetector(
            child: dossier_item("Examen", "images/examen.png", h, w),
          onTap: ()=>Navigator.of(context).pushNamed(ExamenScreens.routeNamed,arguments:patientId)  ),


      ],
    )
  );
  }
  Widget dossier_item(String nom,String icone,double h,double w){
    return   Container(
      height: w*0.13,
      width: w*0.9,
      margin: EdgeInsets.only(top: 40),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blue.withOpacity(0.9)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: h*0.05,
            child: Image.asset(icone),
          ),

          Text(nom,
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.white
            ),),
          Container(

            height: h*0.05,
            child: Image.asset("images/right_arrow.png"),
          )

        ],
      ),
    );
  }
}
