import 'dart:math';

import 'package:firstapp/data/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const SizedBox(height: 20,),
            Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width/2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors:[
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.secondary,
                  Theme.of(context).colorScheme.tertiary
                ],
                transform: const GradientRotation(pi/4),
              ),
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  blurRadius: 3,
                  color: Colors.grey.shade900,
                  offset: Offset(3,3)
                )
              ]
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Total Balance',
                  style: TextStyle(
                    fontSize: 16,
                    color:Colors.white,
                    fontWeight: FontWeight.w600
                  ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "\$4800.00",
                    style: TextStyle(
                      fontSize: 40,
                      color:Colors.white,
                      fontWeight: FontWeight.bold
                  ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                          Container(
                            width: 25,
                            height: 25,
                            decoration: BoxDecoration(
                              color: Colors.white30,
                              shape: BoxShape.circle
                            ),
                            child: Center(
                              child: Icon(
                                CupertinoIcons.arrow_down,
                                 size: 12,
                                 )                           
                              ),
                          ),
                          const SizedBox(width: 8),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Income',
                              style: TextStyle(
                                fontSize: 14,
                                color:Colors.white,
                                fontWeight: FontWeight.w400
                              ),
                              ),
                              Text( "\$2500.00",
                              style: TextStyle(
                                fontSize: 14,
                                color:Colors.white,
                                fontWeight: FontWeight.w600
                              ),
                              ),
                            ],
                          )
                        ],
                      ),
                        Row(children: [
                          Container(
                            width: 25,
                            height: 25,
                            decoration: BoxDecoration(
                              color: Colors.white30,
                              shape: BoxShape.circle
                            ),
                            child: Center(
                              child: Icon(
                                CupertinoIcons.arrow_down,
                                 size: 12,
                                 )                           
                              ),
                          ),
                          const SizedBox(width: 8),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Expenses',
                              style: TextStyle(
                                fontSize: 14,
                                color:Colors.white,
                                fontWeight: FontWeight.w400
                              ),
                              ),
                              Text( "\$800.00",
                              style: TextStyle(
                                fontSize: 14,
                                color:Colors.white,
                                fontWeight: FontWeight.w600
                              ),
                              ),
                            ],
                          )
                        ],)
                      ],
                      )
                )
              ],),
            ),
            const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Text('Transactions',
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.onBackground,
                  fontWeight: FontWeight.bold
                  ),
                ),
                GestureDetector(
                  onTap: () {

                  },
                child: Text('View All',
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.outline,
                  fontWeight: FontWeight.w400
                  ),
                )
              ) 
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
            child: ListView.builder(
              itemCount: myTransactionsData.length,
              itemBuilder: (context,int i){
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Container(
                  decoration: BoxDecoration(color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(12)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: myTransactionsData[i]['color'], 
                                    ),
                                  ),
                                  Container(
                                    width: 32, 
                                    height: 32, 
                                    decoration: BoxDecoration(
                                      //shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: AssetImage(
                                          'assets/${myTransactionsData[i]['icon']}.png',
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 12),
                              Text(
                                myTransactionsData[i]['name'],
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context).colorScheme.onBackground,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                            ]      
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                myTransactionsData[i]['totalAmount'],
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context).colorScheme.onBackground,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                              Text(
                                myTransactionsData[i]['date'],
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context).colorScheme.outline,
                                  fontWeight: FontWeight.w400
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  )
                 );
                }
              ) 
            )
          ],
        )      
      ),
    );
  }
}