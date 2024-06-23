import 'package:flutter/material.dart';
import 'package:firstapp/data/data.dart';

class RegardsScreen extends StatelessWidget {
   
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Regards',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            SizedBox(height: 12), // Add some space between title and grid
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1 / 1.5,
                ),
                itemCount: catData.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade400,
                          blurRadius: 5,
                          offset: Offset(1, 1),
                        )
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0), // Padding inside each grid item
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/${catData[index]['image']}.png',
                            height: 110, // Adjust image size as needed
                          ),
                          SizedBox(height: 8), // Add space between image and text
                          Text(
                            catData[index]['name'],
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 4), // Add space between name and subtitle
                          Text(
                            catData[index]['subtitle'],
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400
                            ),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    )
                  );
                }
              ),
            )
          ]
        )
      ),
    );     
  }
}
