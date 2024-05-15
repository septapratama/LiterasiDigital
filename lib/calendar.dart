import 'package:test123/component/custom_appbar.dart';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:test123/riwayatCalendar.dart';

import '../component/custom_button.dart';
import '../component/custom_colors.dart';

class AksiCalendarPage extends StatefulWidget {
  @override
  _AksiCalendarPageState createState() => _AksiCalendarPageState();
}

class _AksiCalendarPageState extends State<AksiCalendarPage> {
  DateTime _selectedDay =
      DateTime.now(); // Inisialisasi dengan tanggal saat ini
  DateTime _focusedDay = DateTime.now();
  Map<DateTime, List> _events = {};

  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  TextEditingController _eventController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  String? _selectedCategory;

  // List pilihan kategori acara
  final List<String> _categories = [
    'Acara umum',
    'Acara penting',
    'Acara keluarga',
  ];
  @override
  void initState() {
    super.initState();
    _dateController = TextEditingController(
        text: DateFormat('yyyy-MM-dd').format(DateTime.now()));
  }

  @override
  void dispose() {
    _dateController.dispose();
    _timeController.dispose();
    _eventController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectTime(BuildContext context) async {
    final DateTime now = DateTime.now();
    final TimeOfDay initialTime = TimeOfDay(hour: now.hour, minute: now.minute);
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );
    if (picked != null) {
      final DateTime selectedDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        picked.hour,
        picked.minute,
      );

      final DateTime minDateTime = now.add(Duration(minutes: 5));

      if (selectedDateTime.isAfter(minDateTime)) {
        setState(() {
          _timeController.text = picked.format(context);
        });
      } else {
        // Show a message or handle invalid time selection
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Invalid Time"),
              content:
                  Text("Tolong pilih waktu minimal 5 menit dari sekarang."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("OK"),
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Aksi Calendar Pintar',
        buttonOnPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RiwayatCalendar()),
          );
        },
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
                    controller: _dateController,
                    readOnly: true, // Mengaktifkan mode hanya baca
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
                    controller: _timeController,
                    readOnly: true,
                    onTap: () {
                      _selectTime(context);
                    },
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
                child: DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                  items: _categories.map((String category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value;
                    });
                  },
                  hint: Text('Pilih Kategori Acara'),
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
                    controller: _eventController,
                    minLines: 3,
                    maxLines: 5,
                    maxLength: 20,
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
                    controller: _descriptionController,
                    minLines: 3,
                    maxLines: 5,
                    maxLength: 50,
                    keyboardType: TextInputType.multiline,
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
                  // Widgets lainnya di sini
                  SizedBox(height: 16.0),
                  Center(
                    child: ElevatedButton(
                      style: CustomButton.overallButtonStyle(),
                      onPressed: () {
                        setState(() {
                          //isi fungsi disini
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 100.0),
                        child: Text(
                          'Simpan',
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
