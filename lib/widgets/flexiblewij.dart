/*  lib  widgets  FLEXIBLE GRID WIJ  */

import 'package:flutter/material.dart';
import '/style/text_style.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../models/model_category.dart';

// const double totalHours = 24;
// double calculateTotalNoHours(List<CategoryModel> blocks, int totalHours) {
//   double totalDoHours = blocks.fold(0, (sum, block) => sum + CategoryModel.sizeTime);
//   return totalHours - totalDoHours;
// }

class FlexibleWij extends StatelessWidget {

  final CategoryModel item;
  final double width;

  FlexibleWij({
    required this.item,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return 
//Flexible to get total widget size/hours in the day
      Flexible(
        flex: (item.sizeTime).toInt(),
      
      //Container to wrap in color
        child: Padding(
          padding: const EdgeInsets.all(3.0),
      //Row to hold widgets
          child: ElevatedButton(
            style: ButtonStyling.flexButtonStyle,
            onPressed: (null),
            child: Row(
              children: [
              item.icon,
              
              const SizedBox(width: 4.0),
              Expanded(
                child: AutoSizeText(
                  maxLines: 1,
                  minFontSize: 11,
                  item.name,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
                    ],),
          ),
        )
          );
  }
}