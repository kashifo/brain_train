import 'package:brain_train/components/home_grid_item.dart';
import 'package:brain_train/screens/empty_screen.dart';
import 'package:brain_train/screens/jigsaw/jigsaw_demo.dart';
import 'package:brain_train/screens/find_the_no.dart';
import 'package:brain_train/screens/find_the_pair.dart';
import 'package:brain_train/screens/math_basic.dart';
import 'package:brain_train/screens/memory_matrix.dart';
import 'package:brain_train/screens/repeat_the_no.dart';
import 'package:brain_train/screens/sliding_puzzle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'components/get_icons.dart';

class SubHomeScreen extends StatefulWidget {
  const SubHomeScreen({super.key, required this.appBarTitle, required this.iconColor});
  final String appBarTitle;
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
                    child: getIcon(widget.appBarTitle),
                ),
                title: Text(
                  'Brain Train',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
                subtitle: Text(
                  '${widget.appBarTitle} Games',
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

  if(appBarTitle.compareTo('Memory')==0){

    gridItemList.add(gridItem(context, 'Repeat the Numbers', color));
    gridItemList.add(gridItem(context, 'Find the Pair', color));
    gridItemList.add(gridItem(context, 'Compare', color));
    gridItemList.add(gridItem(context, 'Matrix', color));

  }else if(appBarTitle.compareTo('Imagination')==0){

    gridItemList.add(gridItem(context, 'Classic Puzzle', color));
    gridItemList.add(gridItem(context, 'Sliding Puzzle', color));

  }else if(appBarTitle.compareTo('Attention')==0){

    gridItemList.add(gridItem(context, 'Find the Number', color));

  }else if(appBarTitle.compareTo('Math')==0){

    gridItemList.add(gridItem(context, 'Human Calculator', color));
    // gridItemList.add();

  }

  return gridItemList;
}

InkWell gridItem(BuildContext context, String title, Color iconColor) {
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
                  case 'Sliding Puzzle':
                    return SlidingPuzzle(appBarTitle: title);
                  case 'Repeat the Numbers':
                    return RepeatNo(appBarTitle: title);
                  case 'Find the Number':
                    return FindTheNo(appBarTitle: title);
                  case 'Find the Pair':
                    return FindThePair(appBarTitle: title);
                  case 'Matrix':
                    return MemoryMatrix(appBarTitle: title);
                  default:
                    return EmptyScreen(appBarTitle: title);
                }

              }
          ));
    },
    child: getHomeGrid(title, iconColor),
  );
}//gridItem

