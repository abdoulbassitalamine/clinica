import 'package:clinica/screens/patients/examen/poids_screen.dart';
import 'package:clinica/screens/patients/examen/taille_screen.dart';
import 'package:clinica/screens/patients/examen/temperature_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'pression_arterielle_screen.dart';
class ExamenScreens extends StatefulWidget {
  static const routeNamed="/exament-screens";
  const ExamenScreens({Key? key}) : super(key: key);

  @override
  State<ExamenScreens> createState() => _ExamenScreensState();
}

class _ExamenScreensState extends State<ExamenScreens> {
  @override
  Widget build(BuildContext context) {
    final _patientId=ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text("Examen"),
          
      ),
      body: GridView.count(
          crossAxisCount: 3,
        children: [
          Card(
            margin: EdgeInsets.all(8),
            child:  InkWell(
              onTap: (){
                Navigator.of(context).pushNamed(TailleScreen.routeNamed,arguments: _patientId);
              },
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(
                      child: Container(

                        height: MediaQuery.of(context).size.width*0.2,
                        child: SvgPicture.asset('icons/measureheight.svg')
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text('Taille',
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
              onTap: (){
                Navigator.of(context).pushNamed(PoidsScreen.routeNamed,arguments: _patientId);
              },
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(
                      child: Container(

                          height: MediaQuery.of(context).size.width*0.2,
                          child: SvgPicture.asset('icons/body_weight_scales.svg')
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text('Poids',
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
              onTap: (){
                Navigator.of(context).pushNamed(TemperatureScreen.routeNamed,arguments: _patientId);
              },
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(
                      child: Container(

                          height: MediaQuery.of(context).size.width*0.2,
                          child: SvgPicture.asset('icons/temperature_thermometer.svg')
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text('Temperature',
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
              onTap: (){
                Navigator.of(context).pushNamed(PressionArterielleScreen.routeNamed,arguments: _patientId);
              },
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(
                      child: Container(

                          height: MediaQuery.of(context).size.width*0.2,
                          child: SvgPicture.asset('icons/blood_pressure_monitor.svg')
                      ),
                    ),
                    SizedBox(height: 10,),
                    Expanded(
                      child: Text('Pression',
                        style: TextStyle(
                          fontSize: 20,

                        ),),
                    )
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
                          child: SvgPicture.asset('icons/medical_device.svg')
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text('Complementaire',
                      style: TextStyle(
                        fontSize: 15,

                      ),)
                  ],
                ),
              ),
            ),
          ),

        ],
      )
        
      
    );
  }
}
