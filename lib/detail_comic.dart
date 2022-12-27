import 'package:comic_app/models/comic.dart';
import 'package:comic_app/models/favorite.dart';
import 'package:comic_app/provider/chapterProvider.dart';
import 'package:comic_app/provider/favoriteProvider.dart';
import 'package:comic_app/provider/ratingProvider.dart';
import 'package:comic_app/reading_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:comic_app/constants/constant.dart' as constant;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailComic extends StatefulWidget {
  ComicModel item;

  DetailComic({super.key, required this.item});

  @override
  State<DetailComic> createState() => _DetailComicState();
}

const double width = 300.0;
const double height = 40.0;
const double loginAlign = -1;
const double signInAlign = 1;
const Color selectedColor = Colors.black;
const Color normalColor = Colors.black54;

class _DetailComicState extends State<DetailComic> {
  late double xAlign;
  late Color loginColor;
  late Color signInColor;
  bool iLoading = true;
  bool isFavorite = false;
  String isRating = "";
  int selectedItem = 1;
  int favoriteCount = 0;
  bool rateSelected = false;
  double rate = 0;
  String noiDung = "";
  var controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    xAlign = loginAlign;
    loginColor = selectedColor;
    signInColor = normalColor;
  }

  // bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    var favorite = Provider.of<FavoriteProvider>(context);
    var ratingComic = Provider.of<RatingProvider>(context);
    var chapterOfComic = Provider.of<ChapterProvider>(context);

    if (iLoading) {
      (() async {
        await favorite.getComicFavorite(widget.item.id);
        await ratingComic.getComicRating(widget.item.id);
        await chapterOfComic.getChapterOfComic(widget.item.id);
        setState(() {
          isFavorite = favorite.checkFavorite(widget.item.id, constant.user.id);
          isRating = ratingComic.checkRating(widget.item.id, constant.user.id);
          favoriteCount = favorite.listFavoriteComic.length;
          iLoading = false;
        });
      })();
    }
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              rateSelected = false;
            });
          },
          child: Scaffold(
            body: iLoading
                ? Center(
                    child: LoadingAnimationWidget.dotsTriangle(
                    color: Colors.blueGrey,
                    size: 50,
                  ))
                : SafeArea(
                    child: Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 1.4,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: [
                                      _buildCoverImage(context),
                                      _buildAppbar(context),
                                      _buildFavoriteButton(context, favorite)
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  _buildComicTitle(context),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  _buildOptionButton(context),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Expanded(
                                    child: selectedItem == 1
                                        ? _buildDescription(
                                            context, ratingComic)
                                        : _buildChapList(
                                            context, chapterOfComic),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
        Positioned(
            child: AnimatedAlign(
          curve: Curves.fastOutSlowIn,
          alignment: rateSelected ? Alignment.center : Alignment.center,
          duration: const Duration(seconds: 1),
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              padding: const EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    width: 1,
                    color: const Color.fromARGB(255, 146, 198, 224),
                  )),
              width: rateSelected
                  ? MediaQuery.of(context).size.width * (2 / 3)
                  : 0,
              height: rateSelected ? MediaQuery.of(context).size.height / 3 : 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(constant.user.avatar),
                    radius: 25,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(constant.user.tenUser,
                      style: GoogleFonts.readexPro(
                          color: Colors.black87,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w400)),
                  const SizedBox(
                    height: 5,
                  ),
                  RatingBar(
                    initialRating: 0,
                    itemSize: 25,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    ratingWidget: RatingWidget(
                      full: const Icon(
                        Icons.star,
                        color: Colors.blue,
                      ),
                      half: const Icon(
                        Icons.star_half,
                        color: Colors.blue,
                      ),
                      empty: const Icon(
                        Icons.star_border,
                        color: Colors.blue,
                      ),
                    ),
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    onRatingUpdate: (rating) {
                      rate = rating;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: Material(
                      child: TextField(
                          controller: controller,
                          showCursor: true,
                          maxLines: null,
                          decoration: const InputDecoration(
                            hintText: "Add content...",
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(fixedSize: Size(80, 40)),
                      onPressed: () {
                        (() async {
                          if (isRating != "") {
                            await ratingComic.editRateComic(
                                isRating,
                                constant.user.id,
                                constant.user.tenUser,
                                constant.user.avatar,
                                widget.item.id,
                                rate,
                                controller.text);
                          } else {
                            await ratingComic.rateComic(
                                constant.user.id,
                                constant.user.tenUser,
                                constant.user.avatar,
                                widget.item.id,
                                rate,
                                controller.text);
                          }

                          await ratingComic.getComicRating(widget.item.id);
                          rateSelected = !rateSelected;
                          setState(() {});
                        })();
                      },
                      child: Text("Rate",
                          style: GoogleFonts.readexPro(
                              color: Colors.black87,
                              fontSize: 15.0,
                              fontWeight: FontWeight.w400)))
                ],
              ),
            ),
          ),
        ))
      ],
    );
  }

  Widget _buildAppbar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white10.withOpacity(0),
      leading: const Padding(
        padding: EdgeInsets.only(left: 20),
        child: BackButton(
          color: Colors.black,
        ),
      ),
      // actions: [
      //   Padding(
      //     padding: const EdgeInsets.only(right: 20),
      //     child: IconButton(
      //       onPressed: () {},
      //       icon: const Icon(
      //         Icons.more_horiz,
      //         color: Colors.black,
      //       ),
      //     ),
      //   ),
      // ],
      elevation: 0,
    );
  }

  Widget _buildDescription(BuildContext context, RatingProvider ratingComic) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: width * 0.8,
                  child: Text(
                    widget.item.tacGia,
                    style: GoogleFonts.readexPro(
                        color: Colors.black87, fontSize: 20.0),
                  ),
                ),
                Text(
                  "Auther",
                  style: GoogleFonts.readexPro(
                      color: Colors.black87, fontSize: 15.0),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(
                minHeight: 130,
              ),
              child: Container(
                child: Text(widget.item.moTa,
                    style: GoogleFonts.readexPro(
                        color: Colors.black87, fontSize: 15.0)),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  rateSelected = !rateSelected;
                });
              },
              child: Container(
                padding: const EdgeInsets.only(left: 15, right: 15),
                width: MediaQuery.of(context).size.width,
                height: 60,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromARGB(255, 179, 189, 194)),
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(40.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10.0,
                        spreadRadius: 1.0,
                        offset: Offset(1, 1),
                      ),
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RatingBar(
                      initialRating:
                          ratingComic.getRate(ratingComic.listRatingComic),
                      ignoreGestures: true,
                      itemSize: 28,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      ratingWidget: RatingWidget(
                        full: const Icon(
                          Icons.star,
                          color: Colors.blue,
                        ),
                        half: const Icon(
                          Icons.star_half,
                          color: Colors.blue,
                        ),
                        empty: const Icon(
                          Icons.star_border,
                          color: Colors.blue,
                        ),
                      ),
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      onRatingUpdate: (rating) {
                        // print(rating);
                      },
                    ),
                    const Divider(
                      color: Colors.black,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          ratingComic.listRatingComic.length.toString(),
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Rating",
                          style: GoogleFonts.readexPro(
                              color: Colors.black54, fontSize: 13.0),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 5,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  ...ratingComic.listRatingComic.map((e) {
                    return SizedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundImage:
                                                NetworkImage(e.avtDocGia),
                                            radius: 20,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            e.tenDocGia,
                                            style: GoogleFonts.readexPro(
                                                color: Colors.black87,
                                                fontSize: 18.0),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      child: Text(e.ngayViet.day.toString() +
                                          "/" +
                                          e.ngayViet.month.toString() +
                                          "/" +
                                          e.ngayViet.year.toString()),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  child: RatingBar(
                                    initialRating: e.rate.toDouble(),
                                    ignoreGestures: true,
                                    itemSize: 14,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    ratingWidget: RatingWidget(
                                      full: const Icon(
                                        Icons.star,
                                        color: Color.fromARGB(255, 255, 149, 0),
                                      ),
                                      half: const Icon(
                                        Icons.star_half,
                                        color: Color.fromARGB(255, 255, 149, 0),
                                      ),
                                      empty: const Icon(
                                        Icons.star_rate,
                                        color: Colors.black38,
                                      ),
                                    ),
                                    itemPadding: const EdgeInsets.symmetric(
                                        horizontal: 3.0),
                                    onRatingUpdate: (rating) {
                                      // print(rating);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(top: 10, left: 12, right: 12),
                            child: Text(
                              e.noiDung,
                              style: GoogleFonts.readexPro(
                                  color: Colors.black87, fontSize: 15.0),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                    );
                  }).toList()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChapList(BuildContext context, ChapterProvider chapterOfComic) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            chapterOfComic.listChapterOfComic.length.toString() + " chapter",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ...chapterOfComic.listChapterOfComic
                      .map(((e) => Column(
                            children: [
                              const SizedBox(
                                height: 5,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ReadingPageScreen(
                                                  item: e,
                                                  maxChapter: chapterOfComic
                                                      .listChapterOfComic
                                                      .length)));
                                },
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: 50,
                                  child: Row(
                                    children: [
                                      Text(
                                        "Chapter " + e.tapSo.toString(),
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                e.ten,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                DateTime.now()
                                                        .difference(e.ngayDang)
                                                        .inDays
                                                        .toString() +
                                                    " days ago - 12 view",
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )))
                      .toList()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCoverImage(BuildContext context) {
    return Stack(children: [
      Padding(
        padding: const EdgeInsets.all(1.0),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: Image.network(widget.item.anhBia,
                color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.8),
                colorBlendMode: BlendMode.modulate)),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 20, top: 60),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 4.0,
                  offset: const Offset(
                    3.5,
                    3.5,
                  ),
                  blurStyle: BlurStyle.normal),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              width: 120,
              widget.item.anhDaiDien,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    ]);
  }

  Widget _buildComicTitle(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.only(left: 25),
      child: Text(
        widget.item.tenTruyen,
        style: GoogleFonts.readexPro(color: Colors.black87, fontSize: 20.0),
        maxLines: null,
      ),
    );
  }

  Widget _buildFavoriteButton(BuildContext context, FavoriteProvider favorite) {
    return Padding(
      padding: const EdgeInsets.only(left: 250, top: 170),
      child: SizedBox(
        width: 70,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: isFavorite
                  ? Color.fromARGB(255, 254, 115, 107)
                  : Color.fromARGB(255, 146, 198, 224),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            onPressed: () {
              if (isFavorite) {
                favorite.unlike(widget.item.id, constant.user!.id);
                setState(() {
                  favoriteCount--;
                  isFavorite = false;
                });
              } else {
                favorite.like(
                    widget.item.id, widget.item.tenTruyen, constant.user!.id);

                setState(() {
                  favoriteCount++;
                  isFavorite = true;
                });
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.favorite),
                Text(favoriteCount.toString()),
              ],
            )),
      ),
    );
  }

  Widget _buildOptionButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      width: MediaQuery.of(context).size.width,
      height: 35,
      decoration: BoxDecoration(
          border: Border.all(color: const Color.fromARGB(255, 179, 189, 194)),
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(50.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10.0,
              spreadRadius: 1.0,
              offset: Offset(1, 1),
            ),
          ]),
      child: Stack(
        children: [
          AnimatedAlign(
            alignment: Alignment(xAlign, 0),
            duration: const Duration(milliseconds: 400),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.45,
              height: 35,
              decoration: const BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.all(
                  Radius.circular(50.0),
                ),
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.black12,
                //     blurRadius: 5.0,
                //     spreadRadius: 1.0,
                //     offset: Offset(1, 1),
                //   ),
                // ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                xAlign = loginAlign;
                loginColor = selectedColor;

                signInColor = normalColor;
                selectedItem = 1;
              });
            },
            child: Align(
              alignment: const Alignment(-1, 0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.4,
                color: Colors.transparent,
                alignment: Alignment.center,
                child: Text('Description',
                    style: GoogleFonts.readexPro(
                        color: loginColor, fontSize: 15.0)),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                xAlign = signInAlign;
                signInColor = selectedColor;

                loginColor = normalColor;
                selectedItem = 0;
              });
            },
            child: Align(
              alignment: const Alignment(1, 0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.4,
                color: Colors.transparent,
                alignment: Alignment.center,
                child: Text('List chapter',
                    style: GoogleFonts.readexPro(
                        color: signInColor, fontSize: 15.0)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
