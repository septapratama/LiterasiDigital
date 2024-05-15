import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:test123/riwayatCalendar.dart';

import '../component/custom_button.dart';
import '../component/custom_colors.dart';

class ShowCalendar extends StatefulWidget {
  @override
  _AksiCalendarPageStateShow createState() => _AksiCalendarPageStateShow();
}

class _AksiCalendarPageStateShow extends State<ShowCalendar> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  Map<DateTime, List> _events = {};
  TextEditingController _timeController = TextEditingController();
  TextEditingController _eventController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  String? _selectedCategory;

  final List<String> _categories = [
    'Acara umum',
    'Acara penting',
    'Acara keluarga',
  ];

  @override
  Widget build(BuildContext context) {
    TextEditingController _dateController = TextEditingController(
      text: DateFormat('yyyy-MM-dd').format(DateTime.now()),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Aksi Calendar Pintar'),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RiwayatCalendar()),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TableCalendar(
                firstDay: DateTime.now(),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: _focusedDay,
                availableGestures: AvailableGestures.horizontalSwipe,
                availableCalendarFormats: const {
                  CalendarFormat.month:
                      'Month', // Hanya menampilkan format bulanan
                },
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                    _dateController.text =
                        DateFormat('yyyy-MM-dd').format(selectedDay);
                  });
                },
                eventLoader: (day) {
                  return _events[day] ?? [];
                },
              ),
              SizedBox(height: 16.0),
              Text(
                'Tanggal',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Poppins_Bold',
                ),
              ),
              SizedBox(height: 8),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: customColor.primaryColors,
                    width: 1.25,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 8.0,
                  ),
                  child: TextFormField(
                    enabled: false,
                    controller: _dateController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      hintText: 'Input Tanggal Anda',
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Waktu',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Poppins_Bold',
                ),
              ),
              SizedBox(height: 8),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: customColor.primaryColors,
                    width: 1.25,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 8.0,
                  ),
                  child: TextFormField(
                    enabled: false,
                    controller: _timeController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      hintText: 'Input Waktu Anda',
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Kategori Acara',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Poppins_Bold',
                ),
              ),
              SizedBox(height: 8),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: customColor.primaryColors,
                    width: 1.25,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                child: TextFormField(
                  enabled: false,
                  controller: TextEditingController(text: _selectedCategory),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    hintText: 'Pilih Kategori Acara',
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Acara',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Poppins_Bold',
                ),
              ),
              SizedBox(height: 8),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: customColor.primaryColors,
                    width: 1.25,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 8.0,
                  ),
                  child: TextFormField(
                    enabled: false,
                    controller: _eventController,
                    minLines: 3,
                    maxLines: 5,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      hintText: 'Input Acara Anda',
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Deskripsi',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Poppins_Bold',
                ),
              ),
              SizedBox(height: 8),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: customColor.primaryColors,
                    width: 1.25,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 8.0,
                  ),
                  child: TextFormField(
                    enabled: false,
                    controller: _descriptionController,
                    minLines: 3,
                    maxLines: 5,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      hintText: 'Input Deskripsi Anda',
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(height: 16.0),
                  Center(
                    child: ElevatedButton(
                  style: CustomButton.overallButtonStyle(),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RiwayatCalendar()));
                    // Handle button press here
                  },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 100.0),
                        child: Text(
                          'Kembali',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Poppins_Bold',
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
