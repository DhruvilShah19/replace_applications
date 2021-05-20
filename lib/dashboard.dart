import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';
import 'package:replaceapplications/list.dart';
import 'package:share/share.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class Dashboard extends StatefulWidget {
  final bool isSwitch;
  Dashboard(this.isSwitch);
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Application> apps;
  bool isDone = false;
  //bool isSwitch = false;
  List chineseAppList = [];

  Future getInstalledApps() async {
    await DeviceApps.getInstalledApplications(
      includeAppIcons: true,
      includeSystemApps: false,
      onlyAppsWithLaunchIntent: true,
    ).then((value) {
      apps = [];
      chineseAppList = [];
      apps = value;
      chineseApp.forEach((cApp) {
        apps.forEach((app) {
          if (cApp['cApp'] == app.appName) {
            chineseAppList.add(cApp);
          }
        });
        print('app list: $chineseAppList');
      });
      isDone = true;
      if (chineseAppList.length == 0) {
        //isSwitch = true;
        Toast.show(
          'No chinese app found',
          context,
          duration: 3,
        );
      }
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    getInstalledApps();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isSwitch ? "Alternative Applications" : "Scan Applications",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              Share.share(
                "Hey, I am using Replace Applications to get rid of Chinese apps. If you want the same try using the app by clicking. https://play.google.com/store/apps/details?id=com.replaceapplications",
                subject: 'Use Replace Application in your device',
              );
            },
          ),
          PopupMenuButton(
            itemBuilder: (context) {
              return <PopupMenuItem<String>>[
                PopupMenuItem<String>(
                    value: widget.isSwitch ? 'scan' : 'alternative_apps',
                    child: Row(children: [
                      PopupMenuItem<String>(
                        value: "about_us",
                        child: Row(children: [
                          Icon(
                            Icons.info_outline,
                            color: Colors.black,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('About us'),
                          ),
                        ]),
                      ),
                    ]))
              ];
            },
            onSelected: (value) {
              if (value == 'about_us') {
                showAboutDialog(
                  context: context,
                  applicationIcon: Image.asset(
                    'assets/icons/logo.png',
                    fit: BoxFit.cover,
                    height: 70,
                    width: 70,
                  ),
                  applicationName: 'Replace Applications',
                  applicationVersion: '1.0',
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: Text(
                        'Disclaimer',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    Text(
                      'All the alternate application options available in the app are not Indian. Due to the Unavailability of Indian apps, we have given options for other Country apps except china.',
                      style: TextStyle(
                          letterSpacing: 1.25,
                          wordSpacing: 1.0,
                          fontWeight: FontWeight.w400),
                      textAlign: TextAlign.justify,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 40, 0, 20),
                      child: Text(
                        'About us',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    Text(
                      '''
To Identify the Application Made in India
                    
This application is developed to find out Indian apps available in the market so that the user can choose wisely for the alternate option. We do not promote or force people to uninstall any of the applications.

Our application detects and shows the pre-installed application as well as also shows the alternate options of the Indian Apps Available In the market. 

On the basis of Market Research, we have found the country of Origin. We do not guarantee any correct/incorrect information given by our app.

If you notice that any content in our app Violates Copyright or any term. Then please inform us so that we can remove it.

                    ''',
                      style: TextStyle(
                          letterSpacing: 1.25,
                          wordSpacing: 1.0,
                          fontWeight: FontWeight.w400),
                      textAlign: TextAlign.justify,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 40, 0, 20),
                      child: Text(
                        'Credits',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    Text('''Dhruvil Shah
Ravi Patel
Yash Savsani
                    ''')
                  ],
                  useRootNavigator: false,
                );
              }
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: getInstalledApps,
        child: chineseAppList.length == 0 && !isDone
            ? Center(
                child: CircularProgressIndicator(),
              )
            : !widget.isSwitch
            ? Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: <Widget>[
                    chineseAppList.length == 0
                        ? Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Center(
                              child: Column(
                                children: <Widget>[
                                  Image.asset('assets/icons/congo.jpg'),
                                  Text(
                                    'Awesome...No Chinese applications found',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Container(),
                    chineseAppList.length == 0
                        ? Container()
                        : BuildListView(
                            isSwitch: widget.isSwitch,
                            chineseAppList: chineseAppList,
                            apps: apps,
                          ),
                  ],
                ),
              )
            : Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: <Widget>[
                    BuildListView(
                      isSwitch: widget.isSwitch,
                      apps: [],
                      chineseAppList: [],
                    ),
                  ],
                ),
              ),
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: widget.isSwitch
          ? null
          : MaterialButton(
              padding: const EdgeInsets.all(16),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Dashboard(true)),
                );
              },
              color: Colors.transparent,
              elevation: 0,
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.red,
                ),
                width: 250,
                height: 40,
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.list,
                        color: Colors.white,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Find All Alternative Apps',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ]),
              ),
            ),
    );
  }
}

class BuildListView extends StatelessWidget {
  BuildListView({
    this.isSwitch,
    this.chineseAppList,
    this.apps,
  });

  final bool isSwitch;
  final List chineseAppList;
  final List<Application> apps;

  static String url = 'https://play.google.com/store/apps/details?id=';

  Future alternateApp(
      int index, BuildContext context, String packageName) async {
    if (await DeviceApps.isAppInstalled(packageName)) {
      await DeviceApps.openApp(packageName);
    } else {
      if (await canLaunch(url + packageName)) {
        await launch(url + packageName);
      } else {
        Toast.show(
          'Cannot launch App',
          context,
          duration: 3,
        );
      }
    }
  }

  Future replaceApp(int index, BuildContext context, String packageName) async {
    if (await DeviceApps.isAppInstalled(packageName)) {
      await DeviceApps.openApp(packageName);
    } else {
      if (await canLaunch(url + packageName)) {
        await launch(url + packageName);
      } else {
        Toast.show(
          'Cannot launch App',
          context,
          duration: 3,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 5,
            child: Column(
              children: <Widget>[
                ListTile(
                  contentPadding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage(isSwitch
                        ? chineseApp[index]['cIcon']
                        : chineseAppList[index]['cIcon']),
                    backgroundColor: Colors.white,
                  ),
                  title: Text(
                    "${isSwitch ? chineseApp[index]['cApp'] : chineseAppList[index]['cApp']}",
                  ),
                  trailing: isSwitch
                      ? null
                      : IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            apps.forEach((element) async {
                              if (element.appName ==
                                  chineseAppList[index]['cApp']) {
                                if (await canLaunch(
                                    url + element.packageName)) {
                                  await launch(url + element.packageName);
                                } else {
                                  Toast.show(
                                    'Cannot launch the app',
                                    context,
                                    duration: 3,
                                  );
                                }
                              }
                            });
                          },
                        ),
                ),
                RotationTransition(
                  turns: AlwaysStoppedAnimation(90 / 360),
                  child: Image.asset(
                    'assets/icons/replace.png',
                    height: 25,
                  ),
                ),
                ListTile(
                  contentPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage(
                      isSwitch
                          ? chineseApp[index]['altApp1Icon']
                          : chineseAppList[index]['altApp1Icon'],
                    ),
                    backgroundColor: Colors.white,
                  ),
                  title: Text(
                    "${isSwitch ? chineseApp[index]['altApp1'] : chineseAppList[index]['altApp1']}",
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.file_download,
                      color: Colors.green,
                    ),
                    onPressed: () {
                      isSwitch
                          ? alternateApp(
                              index, context, chineseApp[index]['altApp1Link'])
                          : replaceApp(index, context,
                              chineseAppList[index]['altApp1Link']);
                    },
                  ),
                ),
                Divider(
                  height: 1,
                ),
                ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage(
                      isSwitch
                          ? chineseApp[index]['altApp2Icon']
                          : chineseAppList[index]['altApp2Icon'],
                    ),
                    backgroundColor: Colors.white,
                  ),
                  title: Text(
                    "${isSwitch ? chineseApp[index]['altApp2'] : chineseAppList[index]['altApp2']}",
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.file_download,
                      color: Colors.green,
                    ),
                    onPressed: () {
                      isSwitch
                          ? alternateApp(
                              index, context, chineseApp[index]['altApp2Link'])
                          : replaceApp(index, context,
                              chineseAppList[index]['altApp2Link']);
                    },
                  ),
                ),
              ],
            ),
          );
        },
        itemCount: isSwitch ? chineseApp.length : chineseAppList.length,
      ),
    );
  }
}
