import 'dart:collection';
import 'dart:io';
import 'dart:typed_data';

import 'package:aimart/custom_widgets/mart_list_item.dart';
import 'package:aimart/data_objects/mart_item.dart';
import 'package:aimart/utilities/cloud_client.dart';
import 'package:aimart/utilities/constants.dart';
import 'package:aimart/utilities/utility_functions.dart';
import 'package:azstore/azstore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class SearchPage extends StatefulWidget {

  SearchPage({Key? key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  List<Widget> aiWidgetsList = [];
  String searchText = '';

  bool progress = false;
  bool searchMode = false;
  final picker= ImagePicker();
  String picUrl = '';

  PickedFile? tempFile;

  Set<MartItem> martSet = new HashSet<MartItem>();

  @override
  void initState() {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('AiMart', style: TextStyle(color: THEME_COLOR, fontSize: 18),),
        actions: [
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
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _getImageWidget(),
                    GestureDetector(
                      onTap: (){
                        searchWithImage();
                      },
                      child: Container(
                        constraints: BoxConstraints(
                          maxHeight: 50,
                          maxWidth: 250,
                        ),
                        margin: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          color: (picUrl.isEmpty && tempFile == null)? Colors.grey : THEME_COLOR
                        ),
                        alignment: Alignment.center,
                        child: Text('Search', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 15),),
                      ),
                    ),
                    SizedBox(height: 30,),
                    Expanded(
                      child: Container(
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
                                childAspectRatio: 2
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
                    ),]
              ),
            ),
            if(progress)
              Container(
                height: 150,
                width: 150,
                child: CircularProgressIndicator(color: THEME_COLOR,),
              )
          ]
      ),
    );
  }

  Future<void> searchForItem() async {
    setProgress(true);
    List<MartItem> proList = await CloudClient().searchForItem(searchText);
    aiWidgetsList = [];
    for (MartItem pro in proList) {
      if (pro == null) continue;
      aiWidgetsList.add(MartListItem(martItem: pro));
    }
    setProgress(false);
  }

  resetMartList() async {
    if(mounted) showProgress(true);
    try {
      aiWidgetsList = [];
    }catch(e,t){
      uShowErrorNotification('An error occured.');
    }
    if(mounted)  showProgress(false);
  }

  void showProgress(bool bool) {
    setState(() {
     progress = bool;
    });
  }

  void _setSearchMode(bool bool) {
    setState(() {
      searchMode= bool;
    });
  }

  void openEditAdvertBottomSheet() {
    showMaterialModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Padding(
          padding: const EdgeInsets.only(top:180.0),
          child: SearchPage()
      ),
    );
  }

  Future<String> getProfilePicUploadUrl() async {
    if(tempFile==null ){
      return picUrl;
    }
    var storage = AzureStorage.parse(AZURE_CONNECTION_STRING);

    if(picUrl.isNotEmpty && picUrl.contains(MEDIA_DOMAIN)){
      await storage.deleteBlob(picUrl.replaceAll(MEDIA_DOMAIN,''));
    }
    Uint8List bytes = await tempFile!.readAsBytes();
    String picName = DateTime.now().toString().replaceAll(' ', '');
    await storage.putBlob('/aimart/$picName.png',
      bodyBytes: bytes,//Text can be uploaded to 'blob' in which case body parameter is specified instead of 'bodyBytes'
      contentType: 'image/png',
    );
    tempFile = null;

    return MEDIA_DOMAIN + '/aimart/$picName.png';
  }

  _getImageWidget( ){
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    height *= 0.3;
    width *= 0.5;
    var boxFitOption = BoxFit.cover;
    var profilePic = this.picUrl;
    profilePic = profilePic.trim();
    print('profilepic: $profilePic');
    if(tempFile != null){
      if(kIsWeb){
        return
          GestureDetector(
            onTap: selectImage ,
            child: Container(
                width: width,
                height: height,
                child: ClipRRect(borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Image.network(tempFile!.path, fit: BoxFit.scaleDown,),)
            ),
          );
      }else{
        return
          GestureDetector(
            onTap: selectImage ,
            child: Container(
                width: width,
                height: height,
                child: ClipRRect(borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Image.file(File(tempFile!.path), fit: BoxFit.scaleDown,),)
            ),
          );
      }
    }else if(tempFile == null && !(profilePic == 'null' || profilePic.isEmpty)){
      return GestureDetector(
        onTap: selectImage ,
        child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: ClipRRect(borderRadius: BorderRadius.all(Radius.circular(10)),
              child: Image.network(profilePic, fit: BoxFit.scaleDown),)
        ),
      );
    }else{
      return GestureDetector(
        onTap: selectImage ,
        child: Container(
            width: width,
            height:  height,
            decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: THEME_COLOR ),
                borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            padding: EdgeInsets.only(top:10),
            child: Center(child: Icon(Icons.image, color: THEME_COLOR, size: 50,))
        ),
      );
    }
  }

  selectImage() async {
    try {
      // setProgress(true);
      tempFile = await picker.getImage(source: ImageSource.gallery, imageQuality: 50);
      setProgress(false);
    }catch(e, t){
      uShowErrorNotification('No Image selected !');
      print('error: $e, trace: r$t');
    }
    setProgress(false);
  }

  void setProgress(bool bool) {
    setState(() {
      progress = bool;
    });
  }

  Future<void> searchWithImage() async {
    showProgress(true);
    String url  = await getProfilePicUploadUrl();
    var description = await CloudClient().describeImage(url);

    martSet = new HashSet<MartItem>();
    List<MartItem> martList = [];
    // : Extract tags.
    for (String tag in description['description']['tags']){
      martList = await CloudClient().searchForItem(tag);
      martSet.addAll(martList);
    }
    for (MartItem pro in martSet) {
      if (pro == null) continue;
      aiWidgetsList.add(MartListItem(martItem: pro));
    }
    //: Search through database with tags
    showProgress(false);
  }

}


