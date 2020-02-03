import 'package:flutter/material.dart';

import '../dummy/dummy.dart';

class DrawerMenu extends StatefulWidget {
  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  var isNotificationActive = false;
  var isNightModeActive;

  @override
  void initState() {
    super.initState();
    isNightModeActive = false;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            margin: EdgeInsets.zero,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black, Colors.black.withOpacity(.8)],
                stops: [.1, 1],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 26,
                    ),
                    MaterialButton(
                      child: Text('Login'),
                      textTheme: ButtonTextTheme.primary,
                      minWidth: 100,
                      color: Color(0xff5b5b5b),
                      onPressed: () {},
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Notification',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                    Switch(
                      // key: Key('notification'),
                      activeColor: Colors.greenAccent,
                      inactiveTrackColor: Color(0xff5b5b5b),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      value: isNotificationActive,
                      onChanged: (bool value) {
                        setState(() {
                          isNotificationActive = value;
                        });
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Night Mode',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                    Switch(
                      // key: Key('night_mode'),
                      activeColor: Colors.greenAccent,
                      inactiveTrackColor: Color(0xff5b5b5b),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      value: isNightModeActive,
                      onChanged: (bool value) {
                        setState(() {
                          isNightModeActive = value;
                          print(isNightModeActive);                      
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.zero,
              itemCount: title.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(icon[index], color: Colors.black87),
                  title: Text(
                    title[index],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onTap: () {},
                );
                // }
              },
              separatorBuilder: (BuildContext context, int index) {
                if (index == 7) {
                  return Divider();
                } else if (index == 13) {
                  return Divider();
                } else if (index == 22) {
                  return Divider();
                } else if (index == 26) {
                  return Divider();
                } else {
                  return Padding(padding: EdgeInsets.zero);
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
