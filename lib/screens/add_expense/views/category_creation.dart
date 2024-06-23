import 'dart:async';
import 'dart:math';
import 'package:expense_repository/expense_repository.dart';
import 'package:firstapp/screens/add_expense/blocs/create_categorybloc/create_category_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:uuid/uuid.dart';

Future getCategoryCreation(BuildContext context) {

  List<String> myCategoriesIcons = [
    'beauty',
    'daily',
    'electronics',
    'entertainment',
    'food',
    'home',
    'pet',
    'shopping',
    'sport',
    'transportation',
  ];

  return showDialog(
    context: context,
    builder: (ctx) {
      bool isExpended = false;
      String iconSelected = '';
      Color categoryColor = Colors.grey.shade400;
      TextEditingController categoryNameController = TextEditingController();
      TextEditingController categoryIconController = TextEditingController();
      TextEditingController categoryColorController = TextEditingController();
      bool isLoading = false;
      Category category = Category.empty;

      return BlocProvider.value(
        value: context.read<CreateCategoryBloc>(),
        child: StatefulBuilder(
          builder: (ctx, setState){
          return BlocListener<CreateCategoryBloc,CreateCategoryState>(
            listener: (context,state) {
              if(State is CreateCategorySuccess) {
                Navigator.pop(ctx, category);
              } else if (state is CreateCategoryLoading) {
                setState(() {
                  isLoading = true;
                });
              }
            },
            child: AlertDialog(
                title: const Text('Create a Category'),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: categoryNameController,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          isDense: true,
                          filled: true,
                          fillColor: Colors.grey[400],
                          hintText: 'Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16,),
                      TextFormField(
                        controller: categoryIconController,
                        onTap: () {
                          setState(() {
                            isExpended = !isExpended;
                          });
                        },
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          isDense: true,
                          filled: true,
                          suffixIcon: const Icon(CupertinoIcons.chevron_compact_down, size: 12,),
                          fillColor: Colors.grey[400],
                          hintText: 'Icon',
                          border: OutlineInputBorder(
                            borderRadius: isExpended
                                ? const BorderRadius.vertical(
                                    top: Radius.circular(12),
                                  )
                                : BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      isExpended
                          ? Container(
                              width: MediaQuery.of(context).size.width,
                              height: 200,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade400,
                                borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(12),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(17.0),
                                child: GridView.builder(
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    crossAxisSpacing: 17.0,
                                    mainAxisSpacing: 17.0,
                                  ),
                                  itemCount: myCategoriesIcons.length,
                                  itemBuilder: (context, int i) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          iconSelected = myCategoriesIcons[i];
                                        });
                                      },
                                      child: Container(
                                        width: 60,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          border: iconSelected == myCategoriesIcons[i]
                                              ? Border.all(
                                                  width: 2,
                                                  color: Colors.grey.shade900,
                                                )
                                              : null,
                                          borderRadius: BorderRadius.circular(8),
                                          image: DecorationImage(
                                            image: AssetImage(
                                              'assets/${myCategoriesIcons[i]}.png',
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            )
                          : const SizedBox(height: 16,),
                      TextFormField(
                        controller: categoryColorController,
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (ctx2) {
                              return AlertDialog(
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ColorPicker(
                                      pickerColor: categoryColor,
                                      onColorChanged: (value) {
                                        setState(() {
                                          categoryColor = value;
                                        });
                                      },
                                    ),
                                    const SizedBox(height: 16,),
                                    Container(
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
                                      width: double.infinity,
                                      height: 50,
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.pop(ctx2);
                                        },
                                        style: TextButton.styleFrom(
                                          backgroundColor: Colors.transparent,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                        ),
                                        child: const Text(
                                          'Save Color',
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Color.fromARGB(255, 202, 201, 201),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        textAlignVertical: TextAlignVertical.center,
                        readOnly: true,
                        decoration: InputDecoration(
                          isDense: true,
                          filled: true,
                          fillColor: categoryColor,
                          hintText: 'Color',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12,),
                      Container(
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
                        width: double.infinity,
                        height: 50,
                        child: isLoading == true
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : TextButton(
                            onPressed: () {
                              //Create Categoroy Object and pop
                              setState(() {
                                category.categoryId = const Uuid().v1();
                                category.name = categoryNameController.text;
                                category.icon = iconSelected;
                                category.color = categoryColor.value;
                                },
                              );
                              
                              context.read<CreateCategoryBloc>().add(CreateCategory(category));
                              Navigator.pop(context);
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: const Text(
                              'Save Category',
                              style: TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(255, 202, 201, 201),
                              ),
                            ),
                          ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    }
  );
}
  