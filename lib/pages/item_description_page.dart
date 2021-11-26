import 'package:aimart/data_objects/mart_item.dart';
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
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      padding: EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            height: 250,
            constraints: BoxConstraints(
              maxWidth: 400
            ),
            child: ClipRRect(
              child: Image.network(widget.item.picUrl??'', fit: BoxFit.scaleDown, height: double.maxFinite, width: double.maxFinite,),
            ),
          ),
          SizedBox(height: 25,),
          Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: 250,
              constraints: BoxConstraints(
                  maxWidth: 400
              ),
              child: Text(widget.item.name??'', maxLines: 25, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 13,),)),
          SizedBox(height: 25,),
          Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: 250,
              constraints: BoxConstraints(
                  maxWidth: 400
              ),
              child: Text(widget.item.description??'', maxLines: 25, style: TextStyle(color: Colors.black, fontSize: 13,),)),
        ],
      ),
    );
  }
}
