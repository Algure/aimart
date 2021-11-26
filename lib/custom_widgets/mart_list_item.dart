import 'package:aimart/data_objects/mart_item.dart';
import 'package:aimart/utilities/constants.dart';
import 'package:flutter/material.dart';

class  MartListItem extends StatelessWidget {

  MartItem martItem;

  MartListItem({required this.martItem});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      color: Colors.white,
      child: Container(
        decoration: BoxDecoration(
        ),
        constraints: BoxConstraints(
          minHeight: 170,
          maxHeight: 250,
          maxWidth: 400
        ),
        child: Row(
          mainAxisAlignment:  MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              child: Image.network(martItem.picUrl??'', height: double.maxFinite, width: 150, fit: BoxFit.scaleDown,),
            ),
            SizedBox(width: 15,),
            Container(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(martItem.name??'', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 18),),
                  SizedBox(height: 10,),
                  Text('# '+ (martItem.price??''), style: TextStyle(color: THEME_COLOR, fontWeight: FontWeight.w500, fontSize: 15),),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
