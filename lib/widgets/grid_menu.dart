import 'package:clinica/screens/facturation_screen.dart';
import 'package:clinica/screens/ordonnances/ordonnance_screens.dart';
import 'package:clinica/screens/ordonnances/prescriptions_screens.dart';
import 'package:clinica/screens/patients/patients_sceen.dart';
import 'package:clinica/screens/rendez_vous_screens.dart';
import 'package:flutter/material.dart';
class GridMenu extends StatelessWidget {
  const GridMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(

      shrinkWrap:true,

        padding: EdgeInsets.only(top: 0),
        crossAxisCount: 2,
        children: [
          Card(
            margin: EdgeInsets.all(8),
            child:  InkWell(
              onTap: (){

                Navigator.of(context).pushNamed(PatientsScreen.nameRoute);

              },
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(
                      child: Container(

                        height: MediaQuery.of(context).size.width*0.2,
                        child: Image.asset("images/malade.png"),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text('Patient',
                      style: TextStyle(
                        fontSize: 20,

                      ),)
                  ],
                ),
              ),
            ),
          ),
          InkWell(
            onTap: (){
              Navigator.of(context).pushNamed(OrdonnanceScreens.routeNamed);
            },
            child: Card(


              margin: EdgeInsets.all(8),
              child:  InkWell(
                onTap: null,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                    children: [
                      Center(
                        child: Container(

                          height: MediaQuery.of(context).size.width*0.2,
                          child: Image.asset("images/medicine.png",
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text('Ordonnace',
                        style: TextStyle(
                          fontSize: 20,

                        ),)
                    ],
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: ()=>Navigator.of(context).pushNamed(RendezVousScreens.routeNamed),
            child: Card(
              margin: EdgeInsets.all(8),
              child:  InkWell(
                onTap: null,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                    children: [
                      Center(
                        child: Container(

                          height: MediaQuery.of(context).size.width*0.2,
                          child: Image.asset("images/calender.png",
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text('Rendez-vous',
                        style: TextStyle(
                          fontSize: 20,

                        ),)
                    ],
                  ),
                ),
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.all(8),
            child:  InkWell(
              onTap: ()=>Navigator.of(context).pushNamed(FacturationScreen.routeNamed),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(
                      child: Container(

                        height: MediaQuery.of(context).size.width*0.2,
                        child: Image.asset("images/money.png",
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text('Facturation',
                      style: TextStyle(
                        fontSize: 20,

                      ),)
                  ],
                ),
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.all(8),
            child:  InkWell(
              onTap: null,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(
                      child: Container(

                        height: MediaQuery.of(context).size.width*0.2,
                        child: Image.asset("images/rapport.png",
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text('Rapport',
                      style: TextStyle(
                        fontSize: 20,

                      ),)
                  ],
                ),
              ),
            ),
          ),
        ]
    );
  }
}
