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
import 'package:rating_dialog/rating_dialog.dart';

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
const Color selectedColor = Colors.white;
const Color normalColor = Colors.black54;

class _DetailComicState extends State<DetailComic> {
  late double xAlign;
  late Color loginColor;
  late Color signInColor;
  bool iLoading = true;
  bool isFavorite = false;
  int selectedItem = 1;
  int favoriteCount = 0;
  bool rateSelected = false;
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
        favorite.getComicFavorite(widget.item.id);
        ratingComic.getComicRating(widget.item.id);
        chapterOfComic.getChapterOfComic(widget.item.id);
        setState(() {
          isFavorite =
              favorite.checkFavorite(widget.item.id, constant.user!.id);
          favoriteCount = favorite.listFavoriteComic.length;
          iLoading = false;
        });
      })();
    }
    // FocusManager.instance.primaryFocus?.unfocus();
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              rateSelected = false;
              FocusScope.of(context).requestFocus(new FocusNode());
            });
          },
          child: Scaffold(
            appBar: AppBar(
              leading: const Padding(
                padding: EdgeInsets.only(left: 20),
                child: BackButton(
                  color: Colors.black,
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.more_horiz,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
              elevation: 0,
            ),
            body: iLoading
                ? Center(
                    child: LoadingAnimationWidget.dotsTriangle(
                    color: Colors.blueGrey,
                    size: 50,
                  ))
                : Stack(
                    children: [
                      SafeArea(
                        child: Column(
                          children: [
                            _buildCoverImage(context),
                            const SizedBox(
                              height: 10,
                            ),
                            _buildComicTitleAndFavoriteButton(
                                context, favorite),
                            const SizedBox(
                              height: 10,
                            ),
                            _buildOptionButton(context),
                            const SizedBox(
                              height: 10,
                            ),
                            Expanded(
                              child: selectedItem == 1
                                  ? _buildDescription(context, ratingComic)
                                  : _buildChapList(context, chapterOfComic),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                          child: AnimatedAlign(
                        curve: Curves.fastOutSlowIn,
                        alignment:
                            rateSelected ? Alignment.center : Alignment.center,
                        duration: const Duration(seconds: 1),
                        child: SingleChildScrollView(
                          child: Container(
                            constraints: BoxConstraints(),
                            margin: EdgeInsets.only(left: 10, right: 10),
                            padding: EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  width: 4,
                                  color:
                                      const Color.fromARGB(255, 146, 198, 224),
                                )),
                            width: rateSelected
                                ? MediaQuery.of(context).size.width * (2 / 3)
                                : 0,
                            height: rateSelected
                                ? MediaQuery.of(context).size.height / 3
                                : 0,
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const CircleAvatar(
                                    backgroundImage: AssetImage(
                                      "assets/images/khanghy.jpg",
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    "Khang Hy",
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  RatingBar(
                                    initialRating: 0,
                                    itemSize: 20,
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
                                    itemPadding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    onRatingUpdate: (rating) {
                                      // print(rating);
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: 60,
                                    child: SingleChildScrollView(
                                      child: TextFormField(
                                        maxLines: null,
                                        decoration: const InputDecoration(
                                          hintText: "Nhập bình luận",
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          fixedSize: Size(80, 40)),
                                      onPressed: () {},
                                      child: Text("Rate"))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ))
                    ],
                  ),
          ),
        ),
      ],
    );
  }

  Widget _buildDescription(BuildContext context, RatingProvider ratingComic) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      widget.item.tacGia,
                      style: const TextStyle(fontSize: 25),
                    ),
                  ),
                  //Text("main character: ${widget.item.tacGia}"),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Text(widget.item.moTa),
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
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color.fromARGB(255, 146, 198, 224),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RatingBar(
                        initialRating:
                            ratingComic.getRate(ratingComic.listRatingComic),
                        ignoreGestures: true,
                        itemSize: 35,
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
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 4.0),
                        onRatingUpdate: (rating) {
                          // print(rating);
                        },
                      ),
                      const Divider(
                        color: Colors.black,
                      ),
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              ratingComic.listRatingComic.length.toString(),
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text("Đánh giá"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              ...ratingComic.listRatingComic.map((e) {
                return Container(
                  child: Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage:
                                            NetworkImage(e.avtDocGia),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        e.maDocGia,
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  child:
                                      Text(e.ngayViet.toString().split("T")[0]),
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
                                itemSize: 10,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                ratingWidget: RatingWidget(
                                  full: const Icon(
                                    Icons.star,
                                    color: Color.fromARGB(255, 255, 230, 0),
                                  ),
                                  half: const Icon(
                                    Icons.star_half,
                                    color: Color.fromARGB(255, 255, 230, 0),
                                  ),
                                  empty: const Icon(
                                    Icons.star_rate,
                                    color: Colors.black,
                                  ),
                                ),
                                itemPadding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                onRatingUpdate: (rating) {
                                  // print(rating);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        child: Text(e.noiDung),
                      )
                    ],
                  ),
                );
              }).toList()
            ],
          ),
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
                                              ReadingPageScreen(item: e)));
                                },
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: 50,
                                  child: Row(
                                    children: [
                                      Text(
                                        "Chương " + e.tapSo.toString(),
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
                                                "1 ngay truoc - 12 view",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
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
    return Image.network(widget.item.anhBia);
  }

  Widget _buildComicTitleAndFavoriteButton(
      BuildContext context, FavoriteProvider favorite) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: SizedBox(
              // width: 90,
              child: Text(
                // overflow: TextOverflow.ellipsis,
                // softWrap: false,
                widget.item.tenTruyen,
                style: TextStyle(
                  fontSize: 25,
                ),
                maxLines: 1,
              ),
            ),
          ),
          ElevatedButton(
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
                  const SizedBox(
                    width: 5,
                  ),
                  Text(favoriteCount.toString()),
                ],
              ))
        ],
      ),
    );
  }

  Widget _buildOptionButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      width: MediaQuery.of(context).size.width,
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromARGB(255, 179, 189, 194)),
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(50.0),
        ),
      ),
      child: Stack(
        children: [
          AnimatedAlign(
            alignment: Alignment(xAlign, 0),
            duration: const Duration(milliseconds: 400),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: 40,
              decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(
                  Radius.circular(50.0),
                ),
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
                child: Text(
                  'Mô tả',
                  style: TextStyle(
                    color: loginColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
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
                child: Text(
                  'Danh sách chương',
                  style: TextStyle(
                    color: signInColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
