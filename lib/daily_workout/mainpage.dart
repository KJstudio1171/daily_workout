import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:daily_workout/daily_workout/workout_control.dart';
import 'package:daily_workout/daily_workout/date_control.dart';
import 'package:daily_workout/lib_control/theme_control.dart';
import 'package:daily_workout/database/maindata_control.dart';
import 'package:daily_workout/database/routine_firestore.dart';
import 'package:daily_workout/timer/timer_control.dart';
import 'package:daily_workout/revenue/admob.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  DateTime dateTime = DateTime.now();
  List<Widget> selectedWidget;
  List<Widget> activeRoutineList = [];
  RevenueAdMob revenueAdMob = RevenueAdMob();

  @override
  void initState() {
    revenueAdMob.init();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    activeRoutineList.clear();
    revenueAdMob.dispose();
    super.dispose();
  }

  refreshActiveRoutineList() async {
    {
      List result = await Get.to(FireStoreSelectedRoutine());
      List<Widget> _list = activeRoutineList;
      result.forEach((element) {
        _list.add(RoutineList(
          element,
          key: GlobalKey(),
        ));
      });
      setState(() {
        activeRoutineList = _list;
      });
    }
  }

  Widget addRoutine() {
    return activeRoutineList.isEmpty
        ? InkWell(
            enableFeedback: true,
            child: ListTile(
              title: Text('Add Routines'),
              leading: Icon(Icons.add),
            ),
            onTap: refreshActiveRoutineList,
          )
        : Container(
            height: 8,
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "${dateTime.year} - ${dateTime.month} - ${dateTime.day}",
                style: TextStyle(
                  color: Color.fromARGB(255, 80, 97, 125),
                ),
              ),
              Icon(
                Icons.arrow_drop_down_sharp,
                color: Colors.blueGrey,
              ),
            ],
          ),
          onTap: () {
            Future<DateTime> selected = showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2015),
                lastDate: DateTime(2025),
                builder: (BuildContext context, Widget child) {
                  return Theme(
                      data: ThemeData.light().copyWith(
                          colorScheme:
                              ColorScheme.light().copyWith(primary: color1)),
                      child: child);
                });
            selected.then((selected) {
              setState(() {
                dateTime = selected ?? dateTime;
              });
            });
          },
        ),
        bottom: PreferredSize(
          child: Container(
            color: Color.fromARGB(255, 224, 224, 224),
            height: 1.0,
          ),
        ),
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        actions: [
          Center(
            child: Text(
              'Daily Workout',
              style: TextStyle(fontFamily: 'godo', fontSize: 20, color: color1),
            ),
          ),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      body: Column(
        children: [
          DateSection(dateTime),
          addRoutine(),
          Expanded(
            child: ListView.builder(
              physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              padding: EdgeInsets.all(0),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: UniqueKey(),
                  child: activeRoutineList[index],
                  onDismissed: (DismissDirection direction) {
                    setState(() {
                      activeRoutineList.removeAt(index);
                    });
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
              },
              itemCount: activeRoutineList.length,
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: (index) {
            if (index == 0) Get.toNamed('/c');
            if (index == 2) Get.toNamed('/s');
          },
          currentIndex: 1,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.calendar_today_outlined,
                color: color2,
              ),
              activeIcon: Icon(
                Icons.calendar_today_outlined,
                color: color7,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.mode_edit,
                  color: color2,
                ),
                activeIcon: Icon(
                  Icons.mode_edit,
                  color: color7,
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.inbox,
                  color: color2,
                ),
                activeIcon: Icon(
                  Icons.inbox,
                  color: color7,
                ),
                label: ''),
          ]),
      floatingActionButton:
          FloatingButtons(refreshActiveRoutineList, dateTime, revenueAdMob),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class FloatingButtons extends StatefulWidget {
  FloatingButtons(this.function, this.dateTime, this.revenueAdMob);

  final void Function() function;
  final DateTime dateTime;
  final RevenueAdMob revenueAdMob;

  @override
  _FloatingButtonsState createState() => _FloatingButtonsState();
}

class _FloatingButtonsState extends State<FloatingButtons>
    with SingleTickerProviderStateMixin {
  bool isOpened = false;
  AnimationController _animationController;
  Animation<Color> _buttonColor;
  Animation<double> _animateIcon;
  Animation<double> _translateButton;
  Animation<double> _elevation;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 48.0;
  ResultDataFireStore resultDataFireStore = ResultDataFireStore();

  @override
  initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addListener(() {
            setState(() {});
          });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _elevation =
        Tween<double>(begin: 0.0, end: 5.0).animate(_animationController);
    _buttonColor = ColorTween(
      begin: color1,
      end: color11,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.00,
        1.00,
        curve: Curves.linear,
      ),
    ));
    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -14.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.0,
        0.75,
        curve: _curve,
      ),
    ));
    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }

  Widget routine() {
    return Container(
      width: 150,
      height: 48,
      child: FloatingActionButton.extended(
        elevation: _elevation.value,
        heroTag: 'routine',
        label: Text(
          'Add Routines',
          style: TextStyle(fontFamily: 'godo'),
        ),
        onPressed: () {
          widget.function();
          animate();
        },
      ),
    );
  }

  Widget timer() {
    return Container(
      width: 150,
      height: 48,
      child: FloatingActionButton.extended(
        backgroundColor: color6,
        elevation: _elevation.value,
        heroTag: 'timer',
        label: Row(
          children: [
            Icon(Icons.timer_outlined),
            const SizedBox(
              width: 11,
            ),
            Text(
              'TIMER',
              style: TextStyle(fontFamily: 'godo'),
            ),
          ],
        ),
        onPressed: () {
          Get.to(TimerDialog(), fullscreenDialog: true);
        },
      ),
    );
  }

  Widget save() {
    return Container(
      width: 150,
      height: 48,
      child: FloatingActionButton.extended(
        backgroundColor: color13,
        elevation: _elevation.value,
        heroTag: 'save',
        label: Row(
          children: [
            Icon(Icons.save_alt_outlined),
            const SizedBox(
              width: 2,
            ),
            Text(
              'SAVE',
              style: TextStyle(fontFamily: 'godo'),
            ),
          ],
        ),
        onPressed: () {
          widget.revenueAdMob.showInterstitialAd();
          Get.defaultDialog(
            textCancel: 'Cancel',
            textConfirm: 'Confirm',
            confirmTextColor: color8,
            onConfirm: () async {
              await WorkoutSaveData.rawDataPreProcessing();
              await WorkoutSaveData.rawDataPostProcessing(widget.dateTime);
              if (WorkoutSaveData.resultDate.isEmpty) {
              } else {
                await resultDataFireStore.overlapCheck(
                    WorkoutSaveData.resultDate[0],
                    WorkoutSaveData.resultDate[1],
                    WorkoutSaveData.resultDate[2]);
                if (resultDataFireStore.overlap) {
                  await resultDataFireStore.updateCalendar(
                      WorkoutSaveData.resultDate, WorkoutSaveData.resultData);
                } else {
                  await resultDataFireStore.deleteRoutine(
                      WorkoutSaveData.resultDate[0],
                      WorkoutSaveData.resultDate[1],
                      WorkoutSaveData.resultDate[2]);
                  await resultDataFireStore.createCalendar(
                      WorkoutSaveData.resultDate, WorkoutSaveData.resultData);
                }
              }
              await WorkoutSaveData.rawResultDataReset();
              if (Get.currentRoute == '/h') {
                Get.offAll(MainPage());
              } else {
                Get.offAllNamed('/h');
              }
            },
            title: 'SAVE',
            middleText: 'Do you want to save the workout data?',
          );
        },
      ),
    );
  }

  Widget menu() {
    return Container(
      width: 150,
      height: 48,
      child: FloatingActionButton.extended(
        heroTag: 'menu',
        backgroundColor: _buttonColor.value,
        label: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          progress: _animateIcon,
        ),
        onPressed: animate,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * 3.0,
            0.0,
          ),
          child: routine(),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * 2.0,
            0.0,
          ),
          child: timer(),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value,
            0.0,
          ),
          child: save(),
        ),
        menu(),
      ],
    );
  }
}
