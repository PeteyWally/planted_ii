/*  lib  widgets  FLEXIBLE GRID WIJ  */

import 'package:flutter/material.dart';
import '/style/text_style.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../models/model_category.dart';

class FlexibleWij extends StatelessWidget {
  final CategoryModel category;
  final double width;

  const FlexibleWij({
    super.key,
    required this.category,
    required this.width,
  });

//option with dialog
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey[100],
      width: width,
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          IconButton(
            icon: category.icon,
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Adjust Size Params...'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Close'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
          if (width > 100) // Adjust this threshold as needed
            Expanded(
              child: Text(
                category.name,
                style: TextStyle(fontSize: 16),
                overflow: TextOverflow.ellipsis,
              ),
            ),
        ],
      ),
    );

/* OPTION 1 */ //Flexible to get total widget size/hours in the day
    // return Flexible(
    //     flex: (item.sizeTime).toInt(),

    //   //Container to wrap in color
    //     child: Padding(
    //       padding: const EdgeInsets.all(3.0),

/* OPTION 2 */
    // return Container(
    //   width: width,
    //   padding: const EdgeInsets.all(3.0),

/* CONSTANT goes with 1 or 2 */
    //   child: ElevatedButton(
    //     style: ButtonStyling.flexButtonStyle,
    //     onPressed: null,
    //     child: Row(
    //       children: [
    //         item.icon,
    //         const SizedBox(width: 4.0),
    //         Expanded(
    //           child: AutoSizeText(
    //             maxLines: 1,
    //             minFontSize: 11,
    //             item.name,
    //             overflow: TextOverflow.ellipsis,
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );

/* widget build */
  }
}
