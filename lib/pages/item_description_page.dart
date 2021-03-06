import 'package:aimart/data_objects/mart_item.dart';
import 'package:aimart/utilities/constants.dart';
import 'package:flutter/material.dart';

class ItemDescriptionPage extends StatefulWidget {

  MartItem item;

  ItemDescriptionPage({required this.item});

  @override
  _ItemDescriptionPageState createState() => _ItemDescriptionPageState();
}

class _ItemDescriptionPageState extends State<ItemDescriptionPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          padding: EdgeInsets.all(25),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back, color: THEME_COLOR,),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: 250,
                  constraints: BoxConstraints(
                    maxWidth: 400
                  ),
                  child: ClipRRect(
                    child: Image.network(widget.item.picUrl??'', fit: BoxFit.scaleDown,
                      height: double.maxFinite, width: double.maxFinite,),
                  ),
                ),
                SizedBox(height: 25,),
                Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    constraints: BoxConstraints(
                        maxWidth:800
                    ),
                    child: Text(widget.item.name??'', textAlign: TextAlign.center, maxLines: 2,
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 13,),)),
                SizedBox(height: 25,),
                Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    constraints: BoxConstraints(
                        maxWidth: 800
                    ),
                    child: Text(widget.item.description??'', textAlign: TextAlign.center, maxLines: 25, style: TextStyle(color: Colors.black, fontSize: 13,),)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
