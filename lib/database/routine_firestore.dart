import 'package:flutter/material.dart';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'package:daily_workout/lib_control/theme_control.dart';
import 'package:daily_workout/daily_workout/set_control.dart';
import 'package:daily_workout/database/workout_firestore.dart';
import 'package:daily_workout/database/workout_database.dart';

List<Map<String, dynamic>> routineData = [];
Map pressed = {};
int chooseList = 0;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
  /*ChangeNotifierProvider(
          create: (context) => SimpleState(),
          child: StateLoginDemo(),*/
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: color1,
      ),
      home: FireStoreSelectedRoutine(),
    );
  }
}

class FireStoreSelectedRoutine extends StatefulWidget {
  FireStoreSelectedRoutine();

  @override
  _FireStoreSelectedRoutineState createState() =>
      _FireStoreSelectedRoutineState();
}

class _FireStoreSelectedRoutineState extends State<FireStoreSelectedRoutine> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  // 필드명
  final String routine = 'routine';
  final String routineName = 'routine_name';
  final String wkoNames = 'wko_names';
  final String set = "set";
  final String weight = 'weight';
  final String reps = 'reps';
  final String time = "time";
  final String unitWeight = 'unit_weight';
  final String unitTime = 'unit_time';
  final String datetime = 'datetime';

  AsyncSnapshot snapshots;
  var db;

  TextEditingController _newRoutineCon = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sizeCheck();
    db = routineDoc().orderBy(routineName);
  }

  sizeCheck() async {
    var tx = await routineDoc().get().then((value) => value.size);
    if (tx == 0) {
      initRoutine();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          "Routines",
        ),
        backgroundColor: color1,
        actions: [
          Container(
            padding: EdgeInsets.all(10),
            child: Center(
              child: InkWell(
                onTap: () {
                  showCreateDoc();
                },
                enableFeedback: true,
                child: Row(
                  children: [
                    Icon(Icons.add),
                    Text(
                      'Create a Routine',
                      style: TextStyle(fontFamily: 'godo'),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          InkWell(
            enableFeedback: true,
            child: ListTile(
              title: Text(
                'Without Routines',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: Icon(Icons.arrow_forward_ios_sharp),
              onTap: () {
                routineData.clear();
                routineData.add(
                    {this.routineName: 'Today\'s Workout', this.wkoNames: {}});
                /*workoutSaveData
                    .add({'routine_name': '오늘의 운동', 'wko_category': {}});
                print(workoutSaveData.toString());*/
                Get.back(result: routineData);
              },
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: db.snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) return Text("Error: ${snapshot.error}");
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                case ConnectionState.none:
                  return Text("Loading...");
                default:
                  return Expanded(
                    child: ListView(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      children:
                          snapshot.data.docs.map((DocumentSnapshot document) {
                        IconButtonNeumorphic checkCircle = IconButtonNeumorphic(
                          document,
                          key: UniqueKey(),
                        );
                        pressed[checkCircle.key] = false;
                        Map structure = document[this.wkoNames];
                        List wkoCategory = [];
                        structure.forEach((key, value) {
                          wkoCategory.add(key.toString());
                        });
                        return Dismissible(
                          child: ExpansionTile(
                            maintainState: true,
                            /* title: Text(
                              document[this.routineName],
                              style: TextStyle(
                                color: color12,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),*/
                            title: checkCircle,
                            children: [
                              ListView.builder(
                                  physics: ScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: wkoCategory.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    String wkoName = wkoCategory[index];
                                    List wkoSetList =
                                        structure[wkoName]['set_info'];
                                    return Dismissible(
                                      child: ExpansionTile(
                                        maintainState: true,
                                        title: ConstrainedBox(
                                          constraints: BoxConstraints(
                                              minWidth: 70, maxWidth: 300),
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Text(
                                              wkoName,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        children: [
                                          ListView.builder(
                                            physics: ScrollPhysics(),
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              return Dismissible(
                                                key: UniqueKey(),
                                                child: ListTile(
                                                  title: textChanger(
                                                      wkoSetList, index),
                                                ),
                                                onDismissed: (DismissDirection
                                                    direction) {
                                                  deleteSet(
                                                      document, wkoName, index);
                                                },
                                                secondaryBackground: Container(
                                                  child: Center(
                                                    child: Text(
                                                      'Delete',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                  color: color11,
                                                ),
                                                background: Container(),
                                                direction:
                                                    DismissDirection.endToStart,
                                              );
                                            },
                                            itemCount: wkoSetList.length,
                                          ),
                                          InkWell(
                                              enableFeedback: true,
                                              onTap: () async {
                                                List result =
                                                    await Get.to(SetInfo());
                                                createSet(
                                                    document, wkoName, result);
                                                print(result.toString());
                                              },
                                              child: ListTile(
                                                leading: Icon(Icons.add),
                                                title: Text('Add Set'),
                                              )),
                                        ],
                                      ),
                                      key: UniqueKey(),
                                      onDismissed:
                                          (DismissDirection direction) {
                                        deleteWorkout(document, wkoName);
                                      },
                                      secondaryBackground: Container(
                                        child: Center(
                                          child: Text(
                                            'Delete',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        color: color11,
                                      ),
                                      background: Container(),
                                      direction: DismissDirection.endToStart,
                                    );
                                  }),
                              InkWell(
                                  enableFeedback: true,
                                  onTap: () async {
                                    Map<String, dynamic> map =
                                        document[this.wkoNames];
                                    List result =
                                        await Get.to(FireStoreSelectWorkout());
                                    result.forEach((e) {
                                      // print(map.toString());
                                      map.addAll({
                                        e[0]: {'category': e[1], 'set_info': []}
                                      });
                                      //map[e[0]] = [];
                                      print(map.toString());
                                    });
                                    createWorkout(document, map);
                                  },
                                  child: ListTile(
                                      leading: Icon(Icons.add),
                                      title: Text(
                                        'Add Workouts',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ))),
                            ],
                          ),
                          key: UniqueKey(),
                          onDismissed: (DismissDirection direction) {
                            deleteRoutine(document.id);
                          },
                          secondaryBackground: Container(
                            child: Center(
                              child: Text(
                                'Delete',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            color: color11,
                          ),
                          background: Container(),
                          direction: DismissDirection.endToStart,
                        );
                      }).toList(),
                    ),
                  );
              }
            },
          ),
          Container(
            height: 80,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: color7,
        label: Text(
          '                    SELECT                     ',
          style: TextStyle(fontFamily: 'godo'),
        ),
        onPressed: () {
          if (routineData.isEmpty || routineData == null) {
            Get.defaultDialog(
                title: 'No Routine', middleText: 'Please select routines.');
          } else {
            Get.back(result: routineData);
          }
          /*routineData.forEach((element) {
            workoutSaveData.add(element);
          });
          print("asdasdasdasdasdas");
          print(workoutSaveData.toString());*/
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // Create Document
    );
  }

  @override
  void dispose() {
    super.dispose();
    _newRoutineCon.dispose();
    routineData.clear();
    pressed.clear();
  }

  Widget textChanger(List wkoSetList, int index) {
    if (wkoSetList[index][weight] == '') {
      if (wkoSetList[index][reps] == '') {
        return Row(
          children: [
            Text(wkoSetList[index][time] + wkoSetList[index][unitTime]),
            Text(wkoSetList[index][set] + 'sets'),
          ],
        );
      } else {
        return Row(
          children: [
            Text(wkoSetList[index][reps] + 'reps'),
            Text(wkoSetList[index][set] + 'sets'),
          ],
        );
      }
    } else {
      if (wkoSetList[index][reps] == '') {
        return Row(
          children: [
            Text(wkoSetList[index][weight] + wkoSetList[index][unitWeight]),
            Text(wkoSetList[index][time] + wkoSetList[index][unitTime]),
            Text(wkoSetList[index][set] + 'sets'),
          ],
        );
      } else {
        return Row(
          children: [
            Text(wkoSetList[index][weight] + wkoSetList[index][unitWeight]),
            Text(wkoSetList[index][reps] + 'reps'),
            Text(wkoSetList[index][set] + 'sets'),
          ],
        );
      }
    }
  }

  CollectionReference routineDoc() {
    String identification = FirebaseAuth.instance.currentUser.uid;
    return FirebaseFirestore.instance
        .collection(identification)
        .doc(routine)
        .collection(routine);
  }

  void initRoutine() async {
    routineMap.forEach((key, value) async {
      createRoutine(key);
      DocumentSnapshot document = await findDocument(key);
      createWorkout(document, value);
    });
  }

  Future<DocumentSnapshot> findDocument(String string) async {
    DocumentSnapshot document;
    String documentID;
    await routineDoc()
        .where(this.routineName, isEqualTo: string)
        .get()
        .then((value) => value.docs.forEach((element) async {
              documentID = element.id;
            }));
    document = await routineDoc().doc(documentID).get();
    return document;
  }

  void createRoutine(String routineName) async {
    await routineDoc().add({this.routineName: routineName, this.wkoNames: {}});
  }

  void createWorkout(DocumentSnapshot document, Map map) async {
    await routineDoc().doc(document.id).update({wkoNames: map});
  }

  void createSet(DocumentSnapshot document, String wkoName, List result) async {
    Map<String, dynamic> data = document[wkoNames];
    Map<String, dynamic> wkoData = document[wkoNames][wkoName];
    List list = document[wkoNames][wkoName]['set_info'];
    list.add({
      set: result[0],
      weight: result[1],
      reps: result[2],
      time: result[3],
      unitWeight: result[4],
      unitTime: result[5]
    });
    wkoData['set_info'] = list;
    data[wkoName] = wkoData;
    await routineDoc().doc(document.id).update({wkoNames: data});
  }

  void deleteRoutine(String docID) {
    routineDoc().doc(docID).delete();
  }

  void deleteWorkout(DocumentSnapshot document, String wkoName) {
    Map<String, dynamic> map = document[wkoNames];
    if (map.containsKey(wkoName)) {
      map.remove(wkoName);
      routineDoc().doc(document.id).update({wkoNames: map});
    }
  }

  void deleteSet(DocumentSnapshot document, String wkoName, int index) {
    Map<String, dynamic> data = document[wkoNames];
    Map<String, dynamic> wkoData = document[wkoNames][wkoName];
    List listNames = document[wkoNames][wkoName]['set_info'];
    listNames.removeAt(index);
    data.remove(wkoName);
    wkoData['set_info'] = listNames;
    data[wkoName] = wkoData;
    routineDoc().doc(document.id).update({wkoNames: data});
  }

  void showCreateDoc() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Routine name"),
          content: Container(
            height: 200,
            child: TextField(
              autofocus: true,
              decoration: InputDecoration(labelText: "Routine name"),
              controller: _newRoutineCon,
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Delete"),
              onPressed: () {
                _newRoutineCon.clear();
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text("Save"),
              onPressed: () {
                if (_newRoutineCon.text != null &&_newRoutineCon.text.length<=100) {
                  createRoutine(_newRoutineCon.text);
                }
                _newRoutineCon.clear();
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
}

class IconButtonNeumorphic extends StatefulWidget {
  IconButtonNeumorphic(this._document, {Key key}) : super(key: key);

  DocumentSnapshot _document;

  @override
  _IconButtonNeumorphicState createState() => _IconButtonNeumorphicState();
}

class _IconButtonNeumorphicState extends State<IconButtonNeumorphic> {
  bool _pressIcon;

  @override
  void initState() {
    _pressIcon = pressed[widget.key];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
          width: 40,
          height: 40,
          child: InkWell(
            enableFeedback: false,
            borderRadius: BorderRadius.circular(50),
            onTap: () {
              pressed[widget.key] = !pressed[widget.key];
              setState(() {
                _pressIcon = !_pressIcon;
                if (_pressIcon) {
                  routineData.add(widget._document.data());
                } else {
                  routineData.removeWhere((element) =>
                      element['routine_name'] ==
                      widget._document.data()['routine_name']);
                }
              });
            },
            child: Neumorphic(
              style: _pressIcon
                  ? NeumorphicStyle(
                      shape: NeumorphicShape.flat,
                      intensity: 1.0,
                      boxShape: NeumorphicBoxShape.circle(),
                      lightSource: LightSource.topLeft,
                      depth: -2,
                      color: color7,
                    )
                  : NeumorphicStyle(
                      shape: NeumorphicShape.flat,
                      intensity: 1.0,
                      boxShape: NeumorphicBoxShape.circle(),
                      lightSource: LightSource.topLeft,
                      depth: 0,
                      color: Colors.grey[200],
                    ),
              child: Icon(
                _pressIcon ? Icons.check : Icons.add,
                color: _pressIcon ? color15 : color2,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        ConstrainedBox(
          constraints: BoxConstraints(minWidth: 70, maxWidth: 250),
          child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                widget._document['routine_name'],
                style: TextStyle(
                  color: _pressIcon ? color7 : color12,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              )),
        ),
      ],
    );
  }
}

/*
  void showCreateDoc() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("새로운 운동을 등록하세요!"),
          content: Container(
            height: 200,
            child: Column(
              children: <Widget>[
                TextField(
                  autofocus: true,
                  decoration: InputDecoration(labelText: "운동 이름"),
                  controller: _newNameCon,
                ),
                TextField(
                  decoration: InputDecoration(labelText: "운동 부위"),
                  controller: _newCateCon,
                ),
                TextField(
                  decoration: InputDecoration(labelText: "메모"),
                  controller: _newMemoCon,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("취소"),
              onPressed: () {
                _newNameCon.clear();
                _newCateCon.clear();
                _newMemoCon.clear();
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text("등록"),
              onPressed: () {
                if (_newCateCon.text.isNotEmpty &&
                    _newNameCon.text.isNotEmpty) {
                  createWorkout(_newNameCon.text, _newCateCon.text);
                }
                _newNameCon.clear();
                _newCateCon.clear();
                _newMemoCon.clear();
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  void showReadDocSnackBar(DocumentSnapshot doc) {
    _scaffoldKey.currentState
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          backgroundColor: color11,
          duration: Duration(seconds: 3),
          content: Text(
              "$wkoName: ${doc.data()[wkoName]}\n$wkoCategory: ${doc.data()[wkoCategory]}"
                  "\n$wkoMemo: ${doc.data()[wkoMemo]}"),
          action: SnackBarAction(
            label: "완료",
            textColor: colorWhite,
            onPressed: () {

            },
          ),
        ),
      );
  }

  void showUpdateOrDeleteDocDialog(DocumentSnapshot doc) {
    _undNameCon.text = doc[wkoName];
    _undCateCon.text = doc[wkoCategory];
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("운동을 수정하실 건가요?"),
          content: Container(
            height: 200,
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(labelText: wkoName),
                  controller: _undNameCon,
                ),
                TextField(
                  decoration: InputDecoration(labelText: wkoCategory),
                  controller: _undCateCon,
                ),
                TextField(
                  decoration: InputDecoration(labelText: wkoMemo),
                  controller: _undMemoCon,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("취소"),
              onPressed: () {
                _undNameCon.clear();
                _undCateCon.clear();
                _undMemoCon.clear();
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text("수정"),
              onPressed: () {
                if (_undNameCon.text.isNotEmpty &&
                    _undCateCon.text.isNotEmpty) {
                  updateWorkout(doc.id, _undNameCon.text, _undCateCon.text,
                      memo: _undMemoCon.text);
                }
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text("삭제"),
              onPressed: () {
                deleteWorkout(doc.id);
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  String timestampToStrDateTime(Timestamp ts) {
    return DateTime.fromMicrosecondsSinceEpoch(ts.microsecondsSinceEpoch)
        .toString();
  }
*/
