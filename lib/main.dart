import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sys/sys.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterError.onError = (FlutterErrorDetails details) {
    //this line prints the default flutter gesture caught exception in console
    //FlutterError.dumpErrorToConsole(details);
    print("Error From INSIDE FRAME_WORK");
    print("----------------------");
    print("Error :  ${details.exception}");
    print("StackTrace :  ${details.stack}");
  };
  runZoned<Future<void>>(
    () async {
      runApp(Main());
    },
    onError: (dynamic error, StackTrace stackTrace) {
      print(error);
    },
  );
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

class Main extends StatelessWidget {
  Main();

// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ncx',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreen createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen> {
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
                  Expanded(child: Pane(path: Path(name: '/'))),
                  Container(color: Colors.purple.shade100, width: 8),
                  Expanded(child: Pane(path: Path(name: '/home/zen'))),
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
  List<File> _files = [];

  Future<void> refresh() async {
    final directory = await Sys.fsDirectory(widget.path.name);

    setState(() {
      _files = directory.entries
          .map((entry) => File(
                name: entry.key,
              ))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Column(
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
                  itemBuilder: (context, index) =>
                      FileTile(file: _files[index]),
                  itemCount: _files.length,
                ),
              )
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: IconButton(
            onPressed: refresh,
            icon: Icon(Icons.refresh),
          ),
        )
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
