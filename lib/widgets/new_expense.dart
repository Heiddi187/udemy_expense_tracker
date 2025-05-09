import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:udemy_s6/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController =
      TextEditingController(); //always use dispose when TextEdit.. is used
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.other;

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder:
            (ctx) => AlertDialog(
              title: Text("Invalid input"),
              content: Text(
                "One of title, amount, date or category was not entered",
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child: Text("OK"),
                ),
              ],
            ),
      );
      return;
    }
    widget.onAddExpense(
      Expense(
        date: _selectedDate!,
        title: _titleController.text,
        amount: enteredAmount,
        category: _selectedCategory,
      ),
    );
    Navigator.pop(context);
  }

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
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(
      builder: (ctx, constraints) {
        final width = constraints.maxWidth;

        return SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 60, 16, keyboardSpace + 16),
              child: Column(
                children: [
                  if (width >= 600)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextField(
                            keyboardType: TextInputType.text,
                            controller:
                                _titleController, //_saveTitleInput when used alt method,
                            maxLength: 50,
                            decoration: InputDecoration(label: Text("Title")),
                          ),
                        ),
                        SizedBox(width: 10),
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
                      ],
                    )
                  else
                    TextField(
                      keyboardType: TextInputType.text,
                      controller:
                          _titleController, //_saveTitleInput when used alt method,
                      maxLength: 50,
                      decoration: InputDecoration(label: Text("Title")),
                    ),
                  if (width >= 600)
                    Row(
                      children: [
                        DropdownButton(
                          value: _selectedCategory,
                          items:
                              Category.values
                                  .map(
                                    (category) => DropdownMenuItem(
                                      value: category,
                                      child: Text(category.name.toUpperCase()),
                                    ),
                                  )
                                  .toList(),
                          onChanged: (value) {
                            if (value == null) {
                              return;
                            }
                            setState(() {
                              _selectedCategory = value;
                            });
                          },
                        ),
                        SizedBox(width: 10),
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
                    )
                  else
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
                  SizedBox(height: 20),
                  if (width >= 600)
                    Row(
                      children: [
                        Spacer(),
                        ElevatedButton(
                          onPressed:
                              _submitExpenseData, // () {print(_enteredTitle)} with alt method;
                          child: Text("save expense"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("cancel"),
                        ),
                      ],
                    )
                  else
                    Row(
                      children: [
                        DropdownButton(
                          value: _selectedCategory,
                          items:
                              Category.values
                                  .map(
                                    (category) => DropdownMenuItem(
                                      value: category,
                                      child: Text(category.name.toUpperCase()),
                                    ),
                                  )
                                  .toList(),
                          onChanged: (value) {
                            if (value == null) {
                              return;
                            }
                            setState(() {
                              _selectedCategory = value;
                            });
                          },
                        ),
                        Spacer(),
                        ElevatedButton(
                          onPressed:
                              _submitExpenseData, // () {print(_enteredTitle)} with alt method;
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
            ),
          ),
        );
      },
    );
  }
}
