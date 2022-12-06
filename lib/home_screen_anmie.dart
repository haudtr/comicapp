import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeComic extends StatefulWidget {
  const HomeComic({Key? key}) : super(key: key);

  @override
  State<HomeComic> createState() => _HomeComicState();
}
class _HomeComicState extends State<HomeComic> {
  int _selectedIndex = 0;
  int _current = 0;
  final CarouselController _controller = CarouselController();
  final List<String> listview = [
    "images/img_1.png",
    "images/img_2.png",
    "images/img_3.png"
  ];
  final List<String> listview2 = [
    "assets/images/img_8.png",
    "assets/images/img_11.png",
    "assets/images/img_8.png",
    "assets/images/img_11.png",
    "assets/images/img_11.png",
    "assets/images/img_11.png"
  ];
  final List<String> listview1 = [
    "assets/images/img_4.png",
    "assets/images/img_5.png",
    "assets/images/img_5.png",
    "assets/images/img_4.png",
    "assets/images/img_4.png",
    "assets/images/img_4.png",
    "assets/images/img_4.png",
    "assets/images/img_4.png",
    "assets/images/img_4.png",
    "assets/images/img_4.png",
    "assets/images/img_4.png",
  ];
  List<String> genres=[
    "Action",
    "Crime",
    "Comedy",
    "Drama",
    "Horror"
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
                        child: Image.asset("assets/images/img_10.png",
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
          child: Column(
            children: [
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
                items: listview.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        margin: const EdgeInsets.only(top: 15),
                        //padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(i,
                              fit: BoxFit.cover,
                              width: size.width / 6,
                            )),
                      );
                    },
                  );
                }).toList(),
              ),//Slider
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: listview.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () => _controller.animateToPage(entry.key),
                    child: Container(
                      width: 7.0,
                      height: 8.0,
                      margin: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 4.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: (Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.blue
                                  : Colors.purpleAccent)
                              .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                    ),
                  );
                }).toList(),
              ),//Trending manga
              Container(
                margin: const EdgeInsets.only(left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Text("Trending Manga",
                        style: GoogleFonts.readexPro(fontSize:15)),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.more_horiz))
                      ],
                    ),
                  ],
                ),
              ),//Trending Manga
              Container(
                margin: const EdgeInsets.only(top:3),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ...listview1.map(
                        (e) => Container(
                          margin: const EdgeInsets.only(right: 15, left: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.white,
                                    blurRadius: 4,
                                    spreadRadius: 2,
                                    offset: Offset(5, 1))
                              ]),
                          child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                                SizedBox(
                                width: size.width / 5,
                                height: size.height/9,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    e,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  Text(
                                    "Evangelion",
                                    overflow: TextOverflow.clip,
                                    style: GoogleFonts.readexPro(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                   Text(
                                    "From ",
                                    overflow: TextOverflow.clip,
                                    style: GoogleFonts.readexPro(
                                      color: Colors.grey,
                                        fontSize: 12),
                                  ),
                                ],
                              ),

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),//All Manga
              Container(
                margin:  const EdgeInsets.only(left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Text("All Manga",
                        style:  GoogleFonts.readexPro(fontSize: 15)),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.more_horiz))
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height:size.height/3.4,
                width:size.width,
                child: ListView(
                  children: [
                    ...listview2.map((e) {
                      return ElevatedButton(
                        onPressed: () {
                          //Click xong bay sang detail truyện
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white),

                        child: Padding(

                          padding: const EdgeInsets.only(bottom: 15),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 5,
                              ),
                              ClipRRect(borderRadius: BorderRadius.circular(20), child:  Image.asset(e.toString(),
                                fit: BoxFit.cover,width:size.width,height:130 ,)),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children:  [
                                  RichText(
                                    maxLines: 1,
                                    text:  TextSpan(
                                        text: "Evangelion",
                                        style:  GoogleFonts.readexPro(
                                          fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 18.0),
                                        children: [
                                          TextSpan(
                                              text:
                                              '',
                                              style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.bold)),
                                        ]),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                        text: 'Chapter 12',
                                        style:  GoogleFonts.readexPro(
                                            color: Colors.blueGrey.shade800,
                                            fontSize: 16.0),
                                        children: const[
                                          TextSpan(
                                              text:
                                              '',
                                              style:  TextStyle(
                                                  fontWeight:
                                                  FontWeight.bold)),
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

            ]
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:10, vertical: 8),
          child: GNav(
            rippleColor: Colors.grey[300]!,
            hoverColor: Colors.grey[100]!,
            gap: 8,
            activeColor: Colors.black,
            iconSize: 24,
            padding:const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            duration: const Duration(milliseconds: 400),
            tabBackgroundColor: Colors.grey[100]!,
            color: Colors.black,
            tabs:const [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.book,
                text: 'Book',
              ),
              GButton(
                icon: Icons.accessibility_new,
                text: 'Book',
              ),
              GButton(
                icon: Icons.people,
                text: 'Profile',
              ),
            ],
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}


