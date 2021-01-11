class listItemModel {
  listItemModel(dict) {
    this.title = dict["title"];
    this.author = dict["author"];
    this.readNumber = dict["readNumber"];
    this.publishTime = dict["publishTime"];
    this.pic = dict["pic"];
  }

  String title;
  String author;
  String readNumber;
  String publishTime;
  String pic;
}
