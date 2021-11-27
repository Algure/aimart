import 'package:aimart/data_objects/mart_item.dart';
import 'package:aimart/pages/item_description_page.dart';
import 'package:aimart/utilities/constants.dart';
import 'package:flutter/material.dart';

class  MartListItem extends StatelessWidget {

  MartItem martItem;

  MartListItem({required this.martItem});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> ItemDescriptionPage(item:martItem)));
        },
        child: Material(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Colors.white,
          elevation: 8,
          child: Container(
            decoration: BoxDecoration(
            ),
            constraints: BoxConstraints(
              minHeight: 170,
              maxHeight: 250,
              maxWidth: 400
            ),
            padding: EdgeInsets.all(10),
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
                      Container(
                        constraints:BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width < 500? 150 : 200
                        ),
                        child: Text(martItem.name??'',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 15),),
                      ),
                      SizedBox(height: 10,),
                      Text('# '+ (martItem.price??''),
                          maxLines: 1, style: TextStyle(color: THEME_COLOR, fontWeight: FontWeight.w500, fontSize: 12),),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
