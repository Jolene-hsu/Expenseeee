import 'dart:math';
import 'package:expense_repository/expense_repository.dart';
import 'package:firstapp/data/data.dart';
import 'package:firstapp/screens/add_expense/blocs/create_expense_bloc/create_expense_bloc.dart';
import 'package:firstapp/screens/add_expense/blocs/get_categories_bloc/get_categories_bloc.dart';
import 'package:firstapp/screens/add_expense/views/category_creation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  TextEditingController expenseController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  DateTime selectDate = DateTime.now();
  Color categoryColor = Colors.grey.shade400;
  late Expense expense;
  bool isLoading = false;

  @override
  void initState() {
    dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    expense = Expense.empty;
    expense.expenseId = const Uuid().v1();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Add Expenses",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 16,),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: TextFormField(
                  controller: expenseController,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[400],
                    prefixIcon: Icon(
                      Icons.attach_money_rounded,
                      color: Colors.grey[800],
                      size: 24,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32,),
              TextFormField(
                controller: categoryController,
                textAlignVertical: TextAlignVertical.center,
                readOnly: true,
                onTap: () {

                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[400],
                  prefixIcon: Icon(
                    Icons.list,
                    color: Colors.grey[900],
                    size: 24,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () async{
                      var test = await getCategoryCreation(context);
                      print(test);
                    },
                    icon: const Icon(
                      FontAwesomeIcons.plus,
                      size: 16,
                      color: Colors.grey,
                    ),
                  ),
                  hintText: 'Category',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(12)
                    ),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.white30,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(12)
                  )
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, int i) {
                      return Card(
                        child: ListTile(
                          onTap: () {
                            setState(() {
                              //expense.category = state.categories[i];
                              categoryController.text = expense.category.name;
                            });
                          },
                          leading: Image.asset(
                            'assets/${myTransactionsData[i]['icon']}.png',
                            scale: 13,
                          ),
                          title: Text(myTransactionsData[i]['name']),
                          tileColor: Color(myTransactionsData[i]['color'].value),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      );
                    },
                  )
                ),
              ),

              // Container(
              //   height: 200,
              //   width: MediaQuery.of(context).size.width,
              //   decoration: const BoxDecoration(
              //     color: Colors.white30,
              //     borderRadius: BorderRadius.vertical(
              //       bottom: Radius.circular(12)
              //     )
              //   ),
              //   child: Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: BlocBuilder<GetCategoriesBloc, GetCategoriesState>(
              //       builder: (context, state) {
              //         if (state is GetCategoriesLoading) {
              //           return const Center(
              //             child: CircularProgressIndicator(),
              //           );
              //         } else if (state is GetCategoriesSuccess) {
              //           return ListView.builder(
              //             itemCount: state.categories.length,
              //             itemBuilder: (context, int i) {
              //               return Card(
              //                 child: ListTile(
              //                   leading: Image.asset(
              //                     'assets/${state.categories[i].icon}.png',
              //                     scale: 12,
              //                   ),
              //                   title: Text(state.categories[i].name),
              //                   tileColor: Color(state.categories[i].color),
              //                   shape: RoundedRectangleBorder(
              //                     borderRadius: BorderRadius.circular(8),
              //                   ),
              //                 ),
              //               );
              //             },
              //           );
              //         } else if (state is GetCategoriesFailure) {
              //           return Center(
              //             child: Text('Failed to load categories'),
              //           );
              //         } else {
              //           return Container();
              //         }
              //       },
              //     ),
              //   ),
              // ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: dateController,
                textAlignVertical: TextAlignVertical.center,
                readOnly: true,
                onTap: () async {
                  DateTime? newDate = await showDatePicker(
                    context: context,
                    initialDate: selectDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );

                  if (newDate != null) {
                    setState(() {
                      dateController.text = DateFormat('yyyy-MM-dd').format(newDate);
                      selectDate = newDate;
                    });
                  }
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[400],
                  prefixIcon: Icon(
                    Icons.calendar_month_outlined,
                    color: Colors.grey[900],
                    size: 24,
                  ),
                  hintText: 'Date',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 32,),
              Container(
                width: 150,
                height: kToolbarHeight,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.tertiary,
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.secondary,
                    ],
                    transform: const GradientRotation(pi / 4),
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      expense.amount = int.parse(expenseController.text);
                    });
                    context.read<CreateExpenseBloc>().add(CreateExpense(expense));
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 202, 201, 201),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
