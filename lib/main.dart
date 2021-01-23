import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sys/sys.dart';

void main() async {
  final platformVersion = await Sys.platformVersion;
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App(platformVersion: platformVersion));
}

class File {
  File({this.name});

  final String name;
}

class Action {
  Action({this.name});

  final String name;
}

class Path {
  Path({this.name});

  final String name;
}

class App extends StatelessWidget {
  App({
    this.platformVersion,
  });

  final String platformVersion;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ncx',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Main(),
    );
  }
}

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  final List<Action> actions = [
    Action(name: 'Info'),
    Action(name: 'View'),
    Action(name: 'Edit'),
    Action(name: 'Copy'),
    Action(name: 'Move'),
    Action(name: 'Rename'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(child: Pane(path: Path(name: '/home/zen/'))),
                  Container(color: Colors.purple.shade100, width: 8),
                  Expanded(child: Pane(path: Path(name: '/home/zen/'))),
                ],
              ),
            ),
            Material(
              elevation: 1,
              color: Colors.purple.shade200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: actions
                    .map((e) => Expanded(
                          child: ActionButton(
                            action: e,
                          ),
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  ActionButton({this.action});

  final Action action;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Center(child: Text(action.name)),
      ),
    );
  }
}

class Pane extends StatefulWidget {
  Pane({this.path});

  final Path path;

  @override
  _PaneState createState() => _PaneState();
}

class _PaneState extends State<Pane> {
  List<File> files = [
    File(name: '..'),
    File(name: 'git'),
    File(name: 'photos'),
    File(name: 'movies'),
    File(name: 'music'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Material(
          elevation: 1,
          child: Container(
            padding: EdgeInsets.all(12),
            child: Text(
              widget.path.name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        Expanded(
            child: ListView.builder(
                itemBuilder: (context, index) => FileTile(file: files[index]),
                itemCount: files.length))
      ],
    );
  }
}

class FileTile extends StatefulWidget {
  FileTile({this.file});

  final File file;

  @override
  _FileTileState createState() => _FileTileState();
}

class _FileTileState extends State<FileTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.file.name),
      onTap: () {},
    );
  }
}
