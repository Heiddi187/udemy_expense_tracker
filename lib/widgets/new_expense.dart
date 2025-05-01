import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:udemy_s6/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController =
      TextEditingController(); //always use dispose when TextEdit.. is used
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  @override
  void dispose() {
    // dispose is called automatically when the state is removed
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }
  /* alternative way to use the input
  String _enteredTitle = "";

  void _saveTitleInput(String inputValue) {
    _enteredTitle = inputValue;
  }
  */

  void _presentDatePicker() async {
    final todaysDate = DateTime.now();
    final firstDateAvail = DateTime(
      todaysDate.year - 1,
      todaysDate.month,
      todaysDate.day,
    );
    final lastDateAvail = DateTime(
      todaysDate.year + 1,
      todaysDate.month,
      todaysDate.day,
    );
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: todaysDate,
      firstDate: firstDateAvail,
      lastDate: lastDateAvail,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            keyboardType: TextInputType.text,
            controller:
                _titleController, //_saveTitleInput when used alt method,
            maxLength: 50,
            decoration: InputDecoration(label: Text("Title")),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    label: Text("Amount"),
                    prefixText: "\$ ",
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _selectedDate == null
                          ? "No date selected"
                          : formatter.format(_selectedDate!),
                    ),
                    IconButton(
                      onPressed: _presentDatePicker,
                      icon: Icon(Icons.calendar_month),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  print(_amountController.text);
                  print(
                    _titleController.text,
                  ); //print(_enteredTitle) with alt method;
                },
                child: Text("save expense"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("cancel"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
