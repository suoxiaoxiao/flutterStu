import 'dart:convert';

import "package:flutter/material.dart";
import 'listDemoDataModel.dart';

class ListDemoPage extends StatefulWidget {
  ListDemoPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _ListDemoPageState createState() => _ListDemoPageState();
}

class _ListDemoPageState extends State<ListDemoPage> {
  List<listItemModel> datas = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ListView.builder(
            itemCount: datas.length,
            itemBuilder: (BuildContext context, int position) {
              return listViewCellForRow(position);
            }));
  }

  @override
  void initState() {
    loadDatas();
  }

  loadDatas() {
    /// 读取文件 listDemoData.json
    /// 用listDemoDataModel解析并接受数据
    Future<String> loadString =
        DefaultAssetBundle.of(context).loadString("listDemoData.json");
    loadString.then((String value) {
      List<listItemModel> models = [];
      List sourceList = jsonDecode(value);
      for (var item in sourceList) {
        listItemModel model = new listItemModel(item);
        models.add(model);
      }

      /// 通知框架此对象的内部状态已更改
      /// 刷新列表
      setState(() {
        datas = models;
      });
    });
  }

  listViewCellForRow(int index) {
    return Container(
        child: new LayoutBuilder(
            builder: (context, constraints) => Card(
                    child: new Padding(
                  padding: EdgeInsets.all(10.0),
                  child: new Row(
                    children: <Widget>[
                      new Container(
                        width: 150,
                        height: 92,
                        child: new Image.network(
                          //图片地址
                          datas[index].pic,
                          //填充模式
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      new Container(
                        width: constraints.maxWidth - 30 - 150,
                        height: 92,
                        padding: new EdgeInsets.only(
                            left: 10.0, top: 0.0, right: 10.0, bottom: 0.0),
                        child: new Column(
                          // 子组件的在交叉轴的对齐方式为起点
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // 子组件的排列方式为主轴两端对齐
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Text(
                              datas[index].title,
                              style: TextStyle(
                                fontSize: 14.0,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.clip,
                            ),
                            new Text(
                              datas[index].author +
                                  '  ' +
                                  datas[index].readNumber +
                                  '人浏览' +
                                  '  ' +
                                  datas[index].publishTime,
                              style: TextStyle(
                                fontSize: 14.0,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.clip,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ))));
  }

  listViewDidSelectedOfIndex(int index) {
    print("我点击了了");
  }
}
