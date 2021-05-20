import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:replaceapplications/dashboard.dart';
import 'package:share/share.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerRight,
                      child: FloatingActionButton(
                        backgroundColor: Colors.red,
                        child: Icon(Icons.share),
                        onPressed: () {
                          Share.share(
                            "Hey, I am using Replace Applications to get rid of Chinese apps. If you want the same try using the app by clicking. https://play.google.com/store/apps/details?id=com.replaceapplications",
                            subject:
                            'Use Replace Application in your device',
                          );
                        },
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      height: MediaQuery.of(context).size.height / 3,
                      width: MediaQuery.of(context).size.width,
                      decoration: new BoxDecoration(
                        image: new DecorationImage(
                          image: new AssetImage("assets/icons/logo.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Text(
                      "Replace Applications",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.75),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Dashboard(false)),
                            );
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: 300,
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.red,
                              borderRadius: BorderRadius.circular(12)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.find_replace,color: Colors.white,),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Scan Chinese Applications",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Dashboard(true)),
                            );
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: 300,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(12)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.list,color: Colors.white,),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "List of all Alternatives Applications",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ]),
        ),
      ),
    );
  }
}
