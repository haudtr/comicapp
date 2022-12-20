// import 'dart:html';
import 'package:comic_app/models/user.dart';
import 'package:provider/provider.dart';

import 'package:carousel_slider/carousel_slider.dart';
// import 'package:comic_app/models/comic.dart';
import 'package:comic_app/provider/comicProvider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:comic_app/constants/constant.dart' as constant;

import 'detail_comic.dart';

class HomeComic extends StatefulWidget {
  // UserModel user;
  HomeComic({super.key});
  // HomeComic({super.key, required this.user});
  @override
  State<HomeComic> createState() => _HomeComicState();
}

class _HomeComicState extends State<HomeComic> {
  int _selectedIndex = 0;
  int _current = 0;
  final CarouselController _controller = CarouselController();
  bool iLoading = true;

  @override
  Widget build(BuildContext context) {
    var comicProvider = Provider.of<ComicProvider>(context);
    if (iLoading) {
      (() async {
        await comicProvider.getList();
        await comicProvider.getTopList();
        comicProvider.searchComic("");
        setState(() {
          iLoading = false;
        });
      })();
    }
    var size = MediaQuery.of(context).size;
    // print(comicProvider.list);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        actions: [
          Container(
            width: size.width,
            height: size.height,
            color: Colors.white,
            child: Row(
              children: [
                Container(
                  width: size.width / 2,
                  margin: EdgeInsets.only(left: size.width / 6),
                  child: TextField(
                    autofocus: false,
                    style: const TextStyle(fontSize: 15, color: Colors.black),
                    decoration: InputDecoration(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width / 2,
                      ),
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.1),
                      hintText: 'Search Manga',
                      suffixIcon: const Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      contentPadding: const EdgeInsets.only(
                          left: 14.0, bottom: 13, top: 13),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        comicProvider.searchComic(value);
                      });
                    },
                  ),
                ),
                Material(
                  type: MaterialType.transparency,
                  child: Ink(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(100.0),
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.network(constant.user!.avatar,
                            fit: BoxFit.cover, height: size.height),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            CarouselSlider(
              options: CarouselOptions(
                height: size.height / 6,
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
                onPageChanged: (index, carouselReason) {
                  if (kDebugMode) {
                    print(index);
                  }
                  setState(() {
                    _current = index;
                  });
                },
              ),
              items: comicProvider.listTop5.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return ElevatedButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailComic(
                                      item: i,
                                    )),
                            (route) => false);
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Colors.white,
                        side: const BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              i.anhBia,
                              fit: BoxFit.cover,
                              width: size.width,
                            )),
                      ),
                    );
                  },
                );
              }).toList(),
            ), //Slider
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: comicProvider.listTop5.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => _controller.animateToPage(entry.key),
                  child: Container(
                    width: 7.0,
                    height: 8.0,
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (Theme.of(context).brightness == Brightness.dark
                                ? Colors.blue
                                : Colors.black)
                            .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                  ),
                );
              }).toList(),
            ), //Trending manga
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Trending Manga",
                      style: GoogleFonts.readexPro(fontSize: 15)),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.more_horiz))
                    ],
                  ),
                ],
              ),
            ), //Trending Manga
            Container(
              margin: const EdgeInsets.only(top: 3),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...comicProvider.listTop5.map(
                      (e) => ElevatedButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            // do something
                            return DetailComic(
                              item: e,
                            );
                          }));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          elevation: 0,
                          side: const BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: size.width / 5,
                                height: size.height / 9,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    e.anhBia,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  Text(
                                    e.tenTruyen,
                                    overflow: TextOverflow.clip,
                                    style: GoogleFonts.readexPro(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 14),
                                  ),
                                  Text(
                                    e.tacGia,
                                    overflow: TextOverflow.clip,
                                    style: GoogleFonts.readexPro(
                                        color: Colors.grey, fontSize: 12),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ), //All Manga
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("All Manga", style: GoogleFonts.readexPro(fontSize: 15)),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.more_horiz))
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height / 3.4,
              width: size.width,
              child: ListView(
                children: [
                  ...comicProvider.listSearch.map((e) {
                    return ElevatedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          // do something
                          return DetailComic(
                            item: e,
                          );
                        }));
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 0, backgroundColor: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  e.anhBia,
                                  fit: BoxFit.cover,
                                  width: size.width,
                                  height: 130,
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RichText(
                                  maxLines: 1,
                                  text: TextSpan(
                                      text: e.tenTruyen,
                                      style: GoogleFonts.readexPro(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 18.0),
                                      children: const [
                                        TextSpan(
                                            text: '',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ]),
                                ),
                                RichText(
                                  text: TextSpan(
                                      text: 'Chapter 12',
                                      style: GoogleFonts.readexPro(
                                          color: Colors.blueGrey.shade800,
                                          fontSize: 16.0),
                                      children: const [
                                        TextSpan(
                                            text: '',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ]),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  })
                ],
              ),
            ),
          ]),
        ),
      ),
      // bottomNavigationBar: Container(
      //   height: 100,
      //   decoration: BoxDecoration(
      //     color: Colors.white,
      //     boxShadow: [
      //       BoxShadow(
      //         blurRadius: 20,
      //         color: Colors.black.withOpacity(.1),
      //       )
      //     ],
      //   ),
      //   child: Padding(
      //     padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      //     child: GNav(
      //       rippleColor: Colors.grey[300]!,
      //       hoverColor: Colors.grey[100]!,
      //       gap: 8,
      //       activeColor: Colors.black,
      //       iconSize: 24,
      //       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      //       duration: const Duration(milliseconds: 400),
      //       tabBackgroundColor: Colors.grey[100]!,
      //       color: Colors.black,
      //       tabs: const [
      //         GButton(
      //           icon: Icons.home,
      //           text: 'Home',
      //         ),
      //         GButton(
      //           icon: Icons.book,
      //           text: 'Book',
      //         ),
      //         GButton(
      //           icon: Icons.accessibility_new,
      //           text: 'Book',
      //         ),
      //         GButton(
      //           icon: Icons.people,
      //           text: 'Profile',
      //         ),
      //       ],
      //       selectedIndex: _selectedIndex,
      //       onTabChange: (index) {
      //         setState(() {
      //           _selectedIndex = index;
      //         });
      //       },
      //     ),
      //   ),
      // ),
    );
  }
}
