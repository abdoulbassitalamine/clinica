import 'dart:io';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class PdfApi {
  static Future<File> generateFacture(String nameDoctor,String date,String nomPatient,String securiteSociale ,String id_Facture,int montant) async {
    final pdf = Document();
    final imageJpg =
    (await rootBundle.load('images/examen.png')).buffer.asUint8List();
    final imageSvg = await rootBundle.loadString('icons/heart_pulse.svg');


    pdf.addPage(Page(
      pageFormat: PdfPageFormat.a3,
      build: (context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Header(child: Text(nameDoctor,
                  style: TextStyle(
                    fontSize: 23,

                  ))),
              Positioned(

                left: 350,
                bottom:0,
                top: 10,
                right: 0,

                child: SvgImage(svg: imageSvg,
                width: 40,
                height: 50,

                ),
              )


            ]

          ),


          SizedBox(height: 40),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(" N° facture:${id_Facture}",
              style: TextStyle(
                fontSize: 20
              )),
              Text("Tetouan le ,${date}")
            ]

          ),
          SizedBox(height: 40),
          Text(" N° securite sociale:${securiteSociale}",
              style: TextStyle(
                  fontSize: 20
              )),
          SizedBox(height: 30),
          Text(" nom et preonom:${nomPatient}",
              style: TextStyle(
                  fontSize: 20
              )),
          SizedBox(height: 30),
          Padding(
           child: Row(
             children: [
               Text(" Montant :",
                   style: TextStyle(
                       fontSize: 20,
                     decoration: TextDecoration.underline
                   )),
               Text("${montant} Drhs",
                   style: TextStyle(
                       fontSize: 20,
                       //decoration: TextDecoration.underline
                   )),
             ]
           ), padding: EdgeInsets.only(left: 260)
         )





         // Image(MemoryImage(imageJpg), fit: BoxFit.cover),



        ]
      ),

    ));

    return saveDocument(name: 'my_example.pdf', pdf: pdf);
  }

  static Future<File> generateCenteredText(String nameDoctor,String date,String nomPatient,List<String> med ,List<String> pos) async {
    final pdf = Document();
    final imageJpg =
    (await rootBundle.load('images/examen.png')).buffer.asUint8List();
    final imageSvg = await rootBundle.loadString('icons/heart_pulse.svg');


    pdf.addPage(Page(
      pageFormat: PdfPageFormat.a3,
      build: (context) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
                children: [
                  Header(child: Text(nameDoctor,
                      style: TextStyle(
                        fontSize: 23,

                      ))),
                  Positioned(

                    left: 350,
                    bottom:0,
                    top: 10,
                    right: 0,

                    child: SvgImage(svg: imageSvg,
                      width: 40,
                      height: 50,

                    ),
                  )


                ]

            ),


            SizedBox(height: 40),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(" Nome et prenom:${nomPatient}",
                      style: TextStyle(
                          fontSize: 20
                      )),
                  Text("Tetouan le ,${date}")
                ]


            ),
            SizedBox(height: 40),
            // Image(MemoryImage(imageJpg), fit: BoxFit.cover),
            Expanded
              (child:ListView.builder(
                itemBuilder: (context,index){
                  return

                    Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(med[index],style:TextStyle(

                                  fontSize: 25
                              ) ),
                              Text(pos[index],style:TextStyle(

                                  fontSize: 20
                              ))
                            ]

                        )

                    );
                },
                itemCount: pos.length
            )

            )


          ]
      ),

    ));

    return saveDocument(name: 'my_example.pdf', pdf: pdf);
  }


  static Future<File> saveDocument({
    required String name,
    required Document pdf,
  }) async {
    final bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');

    await file.writeAsBytes(bytes);

    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;

    await OpenFile.open(url);
  }
}
