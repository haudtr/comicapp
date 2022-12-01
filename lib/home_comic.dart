import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomeComic extends StatefulWidget {
  const HomeComic({Key? key}) : super(key: key);

  @override
  State<HomeComic> createState() => _HomeComicState();
}

class _HomeComicState extends State<HomeComic> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  final List<String> listview = [
    "asset/images/img_1.png",
    "asset/images/img_2.png",
    "asset/images/img_3.png"
  ];
  final List<String> listview1 = [
    "asset/images/img_4.png",
    "asset/images/img_5.png",
    "asset/images/img_5.png",
    "asset/images/img_4.png",
    "asset/images/img_4.png",
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
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
                        child: Image.asset("asset/images/img_10.png",
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
      body: Container(
        color: Colors.white,
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
                  print(index);
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
                          child: Image.asset(
                            "$i",
                            fit: BoxFit.cover,
                            width: size.width / 6,
                          )),
                    );
                  },
                );
              }).toList(),
            ), //Slider
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
                        color: (Theme.of(context).brightness == Brightness.dark
                                ? Colors.blue
                                : Colors.purpleAccent)
                            .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                  ),
                );
              }).toList(),
            ),
            Container(
              margin: const EdgeInsets.only(top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Trending Manga", style: TextStyle(fontSize: 15)),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.1),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 5),
                          ),
                        ]),
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.more_horiz))
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 3),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...listview1.map(
                      (e) => Container(
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
                        margin: const EdgeInsets.only(right: 15, left: 5),
                        height: size.height / 5,
                        width: size.width / 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: size.width / 5,
                              height: size.height / 8,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  e,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(bottom: 30),
                              child: Column(
                                children: const [
                                  Text(
                                    "Evangelion",
                                    maxLines: 1,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                  Text(
                                    "From",
                                    maxLines: 2,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 200),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("All Manga", style: TextStyle(fontSize: 15)),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.1),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 5),
                          ),
                        ]),
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.more_horiz))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
