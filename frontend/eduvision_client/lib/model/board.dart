class BoardListObject {
  String title;
  List<BoardItemObject> items;

  BoardListObject({required this.title, required this.items});
}

class BoardItemObject {
  String title;
  String description;
  String explanationTitle;
  String explanationDescription;

  BoardItemObject({ this.title = "",  this.description = "",  this.explanationTitle = "",  this.explanationDescription = "", required String from});

  String get from => "oi";

}