
// import 'dart:js';

import 'package:boardview/board_item.dart';
import 'package:boardview/board_list.dart';
import 'package:boardview/boardview.dart';
import 'package:boardview/boardview_controller.dart';
import 'package:flutter/material.dart';
import '../model/board.dart';

class KanbanBoard extends StatefulWidget {

  @override
  _KanbanBoardState createState() => _KanbanBoardState();
}

class _KanbanBoardState extends State<KanbanBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF20B4A6),

      appBar: AppBar(
        // backgroundColor: Color(0xffffffff),
        elevation: 0,
        title: Row(
          children: <Widget>[
            Icon(Icons.view_column, color: Color(0xff000000),),
            SizedBox(width: 20,),
            Text(
              'Tarefas', 
                style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xff2F334B)
              ),
            ),
          ],
        ), 
        bottom: PreferredSize(child: Container(color: Colors.grey[300], height: 1.0,), preferredSize: Size.fromHeight(1.0)),
      ),
      body: BoardViewExample(context: context),
    );
  }
}

class BoardViewExample extends StatelessWidget {

  BuildContext context;

  BoardViewExample({required this.context});
  

  final List<BoardListObject> _listData = [
    BoardListObject(
      title: "A fazer...", 
      items: ActivitiesList().items
      // items: [
      //   BoardItemObject(title: '27 Pares de Zapatos Modelo SDF-234d', from: 'Ruben'),
      //   BoardItemObject(title: '7 Pares de Bota Modelo SDF-234d', from: 'Martha')]
    ),
    BoardListObject(title: "Fazendo...", items: []),
    BoardListObject(title: "Feito!", items: []),
    BoardListObject(title: "Tô com dificuldade!", items: []),
  ];
  //Can be used to animate to different sections of the BoardView
  final BoardViewController boardViewController = new BoardViewController();

  @override
  Widget build(BuildContext context) {
    List<BoardList> _lists = [];
    
    for (int i = 0; i < _listData.length; i++) {
      _lists.add(_createBoardList(_listData[i]));
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BoardView(
        lists: _lists,
        boardViewController: boardViewController,
      ),
    );
  }

  BoardItem buildBoardItem(BoardItemObject itemObject) {
    return BoardItem(
        onStartDragItem: (int? listIndex, int? itemIndex, BoardItemState state) {

        },
        onTapItem: (int? listIndex, int? itemIndex, BoardItemState state) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(itemObject.title!),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Text(itemObject.description!),
                      Divider(),
                      SizedBox(height: 10),
                      Text(
                        itemObject.explanationTitle!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(itemObject.explanationDescription!),
                      SizedBox(height: 10),
                    ],
                  ),
                );
              },
            );
          },


        onDropItem: (int? listIndex, int? itemIndex, int? oldListIndex,
          int? oldItemIndex, BoardItemState state) {

          //Used to update our local item data
          var item = _listData[oldListIndex!].items[oldItemIndex!];

          _listData[oldListIndex].items.removeAt(oldItemIndex);
          
          _listData[listIndex!].items.insert(itemIndex!, item);
        },

        item: Container(
          margin: EdgeInsets.fromLTRB(8, 0, 8, 8),
          child: Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(itemObject.title!, style: TextStyle(
                    height: 1.5,
                    color: Color(0xff2F334B),
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),),
                  SizedBox(height: 10.0,),
                  Text(itemObject.explanationTitle!, style: TextStyle(
                    height: 1.5,
                    color: Color(0xff2F334B),
                    fontSize: 16
                  ),),
                ],
              )
            ),
          ),
        ));
  }

  BoardList _createBoardList(BoardListObject list) {
    List<BoardItem> items = [];
    for (int i = 0; i < list.items.length; i++) {
      items.insert(i, buildBoardItem(list.items[i]));
    }

    return BoardList(
      onStartDragList: (int? listIndex) {

      },
      onTapList: (int? listIndex) async {

      },
      onDropList: (int? listIndex, int? oldListIndex) {
        //Update our local list data
        var list = _listData[oldListIndex!];
        _listData.removeAt(oldListIndex);
        _listData.insert(listIndex!, list);
      },
      headerBackgroundColor: Colors.transparent,
      backgroundColor: Color(0x90FFFFFF),
      header: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Text(
              list.title,
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Color(0xff000000)
              ),
            )
          )
        ),
      ],
      items: items,
    );
  }
}
