import 'package:comic_app/login.dart';
import 'package:comic_app/login_screen/login_screen.dart';
import 'package:comic_app/models/user.dart';
import 'package:comic_app/provider/favoriteProvider.dart';
import 'package:comic_app/reading_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widget/appbar_widget.dart';
import '../widget/button_widget.dart';
import '../widget/numbers_widget.dart';
import '../widget/profile_widget.dart';
import 'constants/constant.dart' as u;
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

bool iLoading = true;
bool favoriteSel = false;

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final user = u.user;
    var favorite = Provider.of<FavoriteProvider>(context);
    if (iLoading) {
      (() async {
        await favorite.getComicFavoriteUser(user.id);
        setState(() {
          iLoading = false;
        });
      })();
    }
    return MaterialApp(
      home: Builder(
        builder: (context) => Scaffold(
          appBar: buildAppBar(context),
          body: ListView(
            padding: EdgeInsets.symmetric(horizontal: 32),
            physics: BouncingScrollPhysics(),
            children: [
              ProfileWidget(
                imagePath: user.avatar,
                onClicked: () {
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(builder: (context) => EditProfilePage()),
                  // );
                },
              ),
              const SizedBox(height: 24),
              buildName(user),
              const SizedBox(height: 24),
              Center(child: buildUpgradeButton()),
              const SizedBox(height: 24),
              SizedBox(
                child: Column(
                  children: [
                    ListTile(
                      leading: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.tealAccent.withOpacity(0.1),
                        ),
                        child: const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                      ),
                      title: Text(
                        'Favorite',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      trailing: GestureDetector(
                        onTap: () {
                          setState(() {
                            favoriteSel = !favoriteSel;
                          });
                        },
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: favoriteSel
                                ? Colors.red
                                : Colors.grey.withOpacity(0.1),
                          ),
                          child: Icon(Icons.navigate_next),
                        ),
                      ),
                    ),
                    AnimatedContainer(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        // border: Border.all(color: Colors.lightBlue),
                      ),
                      constraints:
                          BoxConstraints(maxHeight: favoriteSel ? 200 : 0),
                      duration: const Duration(seconds: 1),
                      width: double.infinity,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ...favorite.listFavoriteComicUser
                                .map(
                                  (e) => Padding(
                                    padding: EdgeInsets.only(bottom: 10),
                                    child: SizedBox(
                                      width: double.infinity,
                                      height: 40,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          // Image.asset(
                                          //   "assets/images/img_3.png",
                                          //   fit: BoxFit.scaleDown,
                                          // ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Flexible(
                                            child: Text(
                                              e.tenTruyen,
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                                .toList()
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              ListTile(
                leading: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.tealAccent.withOpacity(0.1),
                  ),
                  child: const Icon(
                    Icons.language,
                    color: Colors.red,
                  ),
                ),
                title: Text(
                  'Language',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                trailing: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.grey.withOpacity(0.1),
                  ),
                  child: Icon(Icons.navigate_next),
                ),
              ),
              ListTile(
                leading: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.tealAccent.withOpacity(0.1),
                  ),
                  child: const Icon(
                    Icons.notifications,
                    color: Colors.red,
                  ),
                ),
                title: Text(
                  'notifications',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                trailing: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.grey.withOpacity(0.1),
                  ),
                  child: Icon(Icons.navigate_next),
                ),
              ),
              const SizedBox(height: 20),
              ButtonWidget(
                text: 'Log Out',
                onClicked: () {
                  //  Navigator.of(context).pop();
                  Navigator.pushAndRemoveUntil(
                      context,
                      PageRouteBuilder(pageBuilder: (BuildContext context,
                          Animation animation, Animation secondaryAnimation) {
                        return LoginScreen();
                      }, transitionsBuilder: (BuildContext context,
                          Animation<double> animation,
                          Animation<double> secondaryAnimation,
                          Widget child) {
                        return new SlideTransition(
                          position: new Tween<Offset>(
                            begin: const Offset(1.0, 0.0),
                            end: Offset.zero,
                          ).animate(animation),
                          child: child,
                        );
                      }),
                      (Route route) => false);
                  // Navigator.push(
                  //             context,
                  //             MaterialPageRoute(
                  //                 builder: (context) => ProfilePage()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildName(UserModel user) => Column(
        children: [
          Text(
            user.tenUser,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            user.email,
            style: TextStyle(color: Colors.grey),
          )
        ],
      );

  Widget buildUpgradeButton() => ButtonWidget(
        text: 'Edit Profile',
        onClicked: () {
          // Navigator.push(context,
          //     MaterialPageRoute(builder: ((context) => EditProfilePage())));
        },
      );
  Widget buildAbout(UserModel user) => Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              user.phoneNumber,
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );
}
