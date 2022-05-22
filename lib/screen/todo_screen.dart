import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class TodoScreen extends StatefulWidget {
  const TodoScreen({Key? key}) : super(key: key);

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  var todoTitleController = TextEditingController();
  var todoDescriptionController = TextEditingController();
  var todoDateController = TextEditingController();

  var _selectedValue;
  var _categories;

  DateTime? _date;
  String _dropdownValue = "Personel";
  List<String> dropDownOptions = [
    "Personel",
    "Education",
    "Work",
    "Health",
  ];

  void dropdownCallback(String? selectedValue) {
    if (selectedValue is String) {
      setState(() {
        _dropdownValue = selectedValue;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    _dateString(){
      if(_date == null){
        return 'Please choose a date';
      }
      else{
        return '${_date?.day} - ${_date?.month} - ${_date?.year}';
      }
    }
    return Scaffold(
      appBar: AppBar(
        title : Text('Create Todo'),
      ),
      body: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[



            TextField(
              controller: todoTitleController,
              decoration: InputDecoration(
                labelText: 'Title',
                hintText: 'Write todo title',
              ),
            ),
            TextField(
              controller: todoDescriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                hintText: 'Write todo description',
              ),
            ),

            // TAKVİM BUTONU

            Text(_dateString()),
            ElevatedButton.icon(
                onPressed:() async{

                  final result = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2010),
                    lastDate: DateTime(2050),
                  );
                  if(result != null){
                    setState((){
                      _date = result;
                    });
                  };
                },
                icon: const Icon(Icons.calendar_today),
                label: const Text('Choose Date')),

            Text("Selected value: $_dropdownValue"),
            DropdownButton(
              items: dropDownOptions
                  .map<DropdownMenuItem<String>>((String mascot) {
                return DropdownMenuItem<String>(
                    child: Text(mascot), value: mascot);
              }).toList(),

              value: _dropdownValue,
              onChanged: dropdownCallback,
              // Customizatons
              //iconSize: 42.0,
              //iconEnabledColor: Colors.green,
              //icon: const Icon(Icons.flutter_dash),
              //isExpanded: true,
              style: const TextStyle(
                color: Colors.blue,
              ),
            ),


          ],
        ),

      ),
    );
  }
}
