import 'package:aimart/custom_widgets/mart_list_item.dart';
import 'package:aimart/data_objects/mart_item.dart';
import 'package:aimart/pages/search_page.dart';
import 'package:aimart/utilities/cloud_client.dart';
import 'package:aimart/utilities/constants.dart';
import 'package:aimart/utilities/utility_functions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MarketPage extends StatefulWidget {
  const MarketPage({Key? key}) : super(key: key);

  @override
  _MarketPageState createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
  List<Widget> aiWidgetsList = [];
  RefreshController _rController= RefreshController(initialRefresh: false);
  String searchText = '';
  bool searchMode = false;

  bool progress = true;

  @override
  void initState() {
    resetMartList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('AiMart', style: TextStyle(color: THEME_COLOR, fontWeight: FontWeight.bold, fontSize: 18),),
        actions: [
          SizedBox(width: 20,),
          GestureDetector(
              onTap: (){Navigator.pushNamed(context, '/search');},
              child: Icon(Icons.search, color: THEME_COLOR,)),
          SizedBox(width: 20,),
          GestureDetector(
              onTap: resetMartList,
              child: Icon(Icons.refresh, color: THEME_COLOR,)),
          SizedBox(width: 20,)
        ],
      ),
      body:  Stack(
        alignment: Alignment.center,
        children: [
          Container(
          height: double.maxFinite,
          width: double.maxFinite,
          child: MediaQuery.of(context).size.width>=800?
          GridView(
              padding: EdgeInsets.all(10),
              children:aiWidgetsList,
              // semanticChildCount: proWidgets.l,
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 5
              )
          ):
          SingleChildScrollView(
            child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: aiWidgetsList
            ),
          ),
        ),

          if(progress)
          Container(
            height: 150,
            width: 150,
            child: CircularProgressIndicator(color: THEME_COLOR,),
          )
        ]
      )
    );
  }

  resetMartList() async {
    if(mounted) _setSearchMode(false);
    if(mounted) showProgress(true);
    try {
      List<MartItem> proList = await CloudClient().searchForItem(searchText);
      aiWidgetsList = [];
      for (MartItem pro in proList) {
        if (pro == null) continue;
        aiWidgetsList.add(MartListItem(martItem: pro));
      }
    }catch(e,t){
      uShowErrorNotification('An error occured. Drag to refresh.');
    }
    if(mounted)  showProgress(false);
  }

  void showProgress(bool bool) {
    setState(() {
      progress = false;
    });
  }

  void _setSearchMode(bool bool) {
    setState(() {
      searchMode= bool;
    });
  }
}
