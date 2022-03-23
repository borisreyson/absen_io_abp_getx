import 'package:face_id_plus/screens/pages/cuti/list_roster.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class RosterCuti extends StatefulWidget {
  const RosterCuti({ Key? key }) : super(key: key);

  @override
  State<RosterCuti> createState() => _RosterCutiState();
}

class _RosterCutiState extends State<RosterCuti> {

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffffffff),
         elevation: 0,
         leading: InkWell(
         splashColor: const Color(0xff000000),
         child: const Icon(
          Icons.arrow_back_ios_new,
          color: Color(0xff000000),
        ),
        onTap: () {
          Navigator.maybePop(context);
        },
      ),
      title: const Text(
        "Roster Cuti",
        style: TextStyle(color: Colors.black),
      ),
      ),
    
    body: ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: (){
                          Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => const ListRoster()));
                        }, child: Text("List Roster")
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: (){
                    
                        }, child: Text("Pengajuan Cuti")
                      ),
                    ),
                  ],
                ),
              ),
              TableCalendar(
                firstDay: DateTime.utc(2022, 3, 1),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: _focusedDay,
                calendarFormat: _calendarFormat,
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  if (!isSameDay(_selectedDay, selectedDay)) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  }

                  if(_selectedDay == selectedDay){
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.green,
                        content: Text("APA",style: TextStyle(color: Colors.white))));
                  } 
                },
                onFormatChanged: (format) {
                  if (_calendarFormat != format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  }
                },
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
              ),
            ],
          ),
        )
      ],
    )
    );
  }
}