import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
List<Appointment> appointmentss = <Appointment>[];
class RendezVousScreens extends StatefulWidget {
  static const routeNamed="/rendez-vous-screens";
  const RendezVousScreens({Key? key}) : super(key: key);

  @override
  State<RendezVousScreens> createState() => _RendezVousScreensState();
}

class _RendezVousScreensState extends State<RendezVousScreens> {
  final _formKey = GlobalKey<FormState>();
  final format = DateFormat("yyyy_MM_dd_HH_mm_ss");
  final _debutController=TextEditingController();
  final _finController=TextEditingController();
  final _motifController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SfCalendar(

        appointmentTextStyle: TextStyle(
          fontSize: 20,
          color: Colors.white
        ),
        allowDragAndDrop: false,
        view: CalendarView.month,
        monthViewSettings: MonthViewSettings(
          showAgenda: true
        ),
        onTap: (CalendarAppointmentDetails){

        },
        firstDayOfWeek: 1,
        dataSource: _getCalendarDataSource(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
             addAppointement();
        },
        child: Icon(Icons.add),
      ),

    );

  }
  void addAppointement(){
    List<Appointment> appointments = <Appointment>[];
    showDialog(
        barrierDismissible: false,
        context: context,
        builder:(BuildContext context){
          return AlertDialog(
            scrollable: true,
            title: Text('Formulaire'),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    DateTimeField(
                      controller: _debutController,
                      format: format,
                      onShowPicker: (context, currentValue) async {
                        final date = await showDatePicker(
                            context: context,
                            firstDate: DateTime(1900),
                            initialDate: currentValue ?? DateTime.now(),
                            lastDate: DateTime(2100));
                        if (date != null) {
                          final time = await showTimePicker(
                            context: context,
                            initialTime:
                            TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                          );
                          return DateTimeField.combine(date, time);
                        } else {
                          return currentValue;
                        }
                      },
                    ),
                    DateTimeField(
                      controller: _finController,
                      format: format,
                      onShowPicker: (context, currentValue) async {
                        final date = await showDatePicker(
                            context: context,
                            firstDate: DateTime(1900),
                            initialDate: currentValue ?? DateTime.now(),
                            lastDate: DateTime(2100));
                        if (date != null) {
                          final time = await showTimePicker(
                            context: context,
                            initialTime:
                            TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                          );
                          return DateTimeField.combine(date, time);
                        } else {
                          return currentValue;
                        }
                      },
                    ),

                    TextFormField(
                      controller: _motifController,
                      decoration: InputDecoration(
                        labelText: 'Sujet',
                        hintText: 'Consultation avec Abdou Bassit',


                      ),
                      validator: (value) {
                        if (value == null) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              ElevatedButton(
                  child: Text("Enregistrer"),
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }
                    _formKey.currentState!.save();
                    List<String> debut;
                    List<String> fin;

                    debut=_debutController.value.text.split('_');
                    fin=_finController.value.text.split('_');
                    appointments.add(

                        Appointment(
                            startTime:DateTime(int.parse(debut[0]),
                              int.parse(debut[1]),
                              int.parse(debut[2]),
                              int.parse(debut[3]),
                              int.parse(debut[4]),
                              int.parse(debut[5]),
                            ) ,
                            endTime: DateTime(int.parse(fin[0]),
                              int.parse(fin[1]),
                              int.parse(fin[2]),
                              int.parse(fin[3]),
                              int.parse(fin[4]),
                              int.parse(fin[5]),
                            ),
                            subject: _motifController.value.text
                        )
                    );
                    setState((){
                      appointmentss=appointments;
                    });


                    Navigator.pop(context);

                  })
            ],
          );
        }
    );





  }

  _AppointmentDataSource _getCalendarDataSource() {
    List<Appointment> appointments = <Appointment>[];
    setState((){
      appointments=appointmentss;
    });

    appointments.add(Appointment(
      startTime: DateTime.now(),
      endTime: DateTime.now().add(Duration(hours: 4)),
      subject: 'Consultation avec Abdou Bassit',
      notes: 'rendez vous avec vous',
      color: Colors.blue,
      startTimeZone: '',
      endTimeZone: '',
    ));

    return _AppointmentDataSource(appointments);
  }

}


class _AppointmentDataSource extends CalendarDataSource {
  _AppointmentDataSource(List<Appointment> source){
    appointments = source;
  }

}