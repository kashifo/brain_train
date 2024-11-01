import 'package:brain_train/screens/empty_screen.dart';
import 'package:brain_train/jigsaw/jigsaw_demo.dart';
import 'package:brain_train/screens/find_the_no.dart';
import 'package:brain_train/screens/find_the_pair.dart';
import 'package:brain_train/screens/math_basic.dart';
import 'package:brain_train/screens/repeat_the_no.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SubHomeScreen extends StatefulWidget {
  const SubHomeScreen({super.key, required this.appBarTitle, required this.iconData, required this.iconColor});
  final String appBarTitle;
  final IconData iconData;
  final Color iconColor;

  @override
  State<SubHomeScreen> createState() => _SubHomeScreenState();
}

class _SubHomeScreenState extends State<SubHomeScreen> {

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: widget.iconColor));

    return Scaffold(
      body: AnnotatedRegion(
        value: SystemUiOverlayStyle(statusBarColor: widget.iconColor),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 40, bottom: 20),
              decoration: BoxDecoration(color: widget.iconColor),
              child: ListTile(
                contentPadding: EdgeInsets.only(left: 30, right: 30),
                leading: Container(
                    padding: const EdgeInsets.all(13),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle, color: widget.iconColor,
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(0, 1),
                            blurRadius: 5,
                            spreadRadius: 1,
                            color: Colors.black.withOpacity(0.2))
                      ],
                    ),
                    child: Icon(
                      widget.iconData,
                      color: Colors.white,
                    )),
                title: Text(
                  'Brain Train',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
                subtitle: Text(
                  widget.appBarTitle,
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                trailing: Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 28,
                        ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: widget.iconColor,
                child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50))),
                    padding: EdgeInsets.only(top: 10),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: GridView.extent(
                        shrinkWrap: true,
                        mainAxisSpacing: 30,
                        crossAxisSpacing: 30,
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                        physics: const ScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        maxCrossAxisExtent: 200,
                        children: getGridItems(widget.appBarTitle, widget.iconColor, context),
                      ),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }//build

}//State

List<Widget> getGridItems(String appBarTitle, Color color, BuildContext context){
  List<Widget> gridItemList = [];

  if(appBarTitle.compareTo('Memory Games')==0){

    gridItemList.add( gridItem(context, 'Repeat the Numbers', Icons.repeat_one, color),);
    gridItemList.add(gridItem(context, 'Find the Pair', Icons.search, color));

  }else if(appBarTitle.compareTo('Imagination Games')==0){

    gridItemList.add(gridItem(context, 'Classic Puzzle', Icons.join_left_rounded, color));

  }else if(appBarTitle.compareTo('Attention Games')==0){

    gridItemList.add(gridItem(context, 'Find the Number', Icons.remove_red_eye, color));

  }else if(appBarTitle.compareTo('Arithmetic Games')==0){

    gridItemList.add(gridItem(context, 'Human Calculator', Icons.add, color));
    // gridItemList.add();

  }

  return gridItemList;
}


InkWell gridItem(BuildContext context, String title, IconData iconData, Color iconColor) {
  return InkWell(
    onTap: (){
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) {

                switch(title){
                  case 'Human Calculator':
                    return MathBasic(appBarTitle: title);
                  case 'Classic Puzzle':
                    return JigsawDemo(appBarTitle: title);
                  case 'Repeat the Numbers':
                    return RepeatNo(appBarTitle: title);
                  case 'Find the Number':
                    return FindTheNo(appBarTitle: title);
                  case 'Find the Pair':
                    return FindThePair(appBarTitle: title);
                  default:
                    return EmptyScreen(appBarTitle: title);
                }

              }
          ));
    },
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, 0),
              blurRadius: 5,
              spreadRadius: 0,
              color: Colors.black.withOpacity(0.2))
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                shape: BoxShape.circle, color: iconColor,
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(0, 1),
                      blurRadius: 5,
                      spreadRadius: 1,
                      color: Colors.black.withOpacity(0.2))
                ],
              ),
              child: Icon(
                iconData,
                color: Colors.white,
                size: 25,
              )),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.all(2),
            child: Text(
              title, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w500),
            ),
          )
        ],
      ),
    ),
  );
}//gridItem

