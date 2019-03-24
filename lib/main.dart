import 'package:flutter/material.dart';
import 'package:load_images/models/ImageModel.dart';
import 'package:http/http.dart' show get;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Load Images'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int counter = 0;
  List<ImageLoader> _list = [];

  void fetchImage() async {
    counter++;
    var parsed_json = await get(
        "https://jsonplaceholder.typicode.com/photos/${counter.toString()}");
    print(parsed_json.toString());
    var decodedJson = json.decode(parsed_json.body);
    ImageLoader loader = new ImageLoader.fromJson(decodedJson);
    setState(() {
      _list.add(loader);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            floating: true,
            title: Text('Загрузка изображений'),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(_itemBuilder,
                childCount: _list.length),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchImage,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    var key = Key("value $counter");
    return Dismissible(
      key: key,
      onDismissed: (direction) {
        setState(() {
          _list.removeAt(index);
        });
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
        shape: RoundedRectangleBorder(
            side: BorderSide(width: 0.5, color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
        child: Column(
          children: <Widget>[
            Image.network(
              _list[index].image,
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height / 3,
            ),
            Padding(
              child: Text(
                _list[index].title,
              ),
              padding: EdgeInsets.all(16.0),
            )
          ],
        ),
      ),
    );
  }
}
