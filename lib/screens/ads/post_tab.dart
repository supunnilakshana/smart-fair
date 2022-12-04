import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:nearvegi/constants/cities.dart';
import 'package:nearvegi/models/postmodel.dart';
import 'package:nearvegi/screens/ads/ad_view.dart';
import 'package:nearvegi/screens/components/errorpage.dart';
import 'package:nearvegi/screens/components/tots.dart';
import 'package:nearvegi/services/firebase/fb_handeler.dart';

import '../../constants/constraints.dart';
import '../components/roundedtextFiled.dart';
import '../home/drawer.dart';

class PostTab extends StatefulWidget {
  const PostTab({
    Key? key,
  }) : super(key: key);
  @override
  _PostTabState createState() => _PostTabState();
}

class _PostTabState extends State<PostTab> {
  late Future<List<PostModel>> futureData;
  late Future<List<PostModel>> futureDataall;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String dropdowndis = seldis;
  String dropdowncity = selcity;

  late List<String> cities;
  late List<String> discts;
  @override
  void initState() {
    super.initState();
    discts = districwithall;
    cities = getcitiesall(discts[2]);
    futureData = FbHandeler.getnearPost();
    futureDataall = FbHandeler.getallPost();
  }

  String searchvalue = "";
  bool isfilter = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        drawer: MenuDrawer(),
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kPrimaryColordark,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LineIcon.globe(
                size: size.width * 0.073,
                color: Colors.white,
              ),
              SizedBox(
                width: size.width * 0.01,
              ),
              Text(
                "Smart Fair",
                style: TextStyle(
                    fontSize: size.width * 0.063, color: Colors.white),
              ),
            ],
          ),
          // actions: [
          //   IconButton(onPressed: () {}, icon: const Icon(Icons.search))
          // ],
          leading: IconButton(
            onPressed: () {
              _scaffoldKey.currentState!.openDrawer();
            },
            icon: Icon(
              Icons.menu_rounded,
              color: Colors.white.withOpacity(.8),
              size: size.width * 0.1,
            ),
          ),
          bottom: PreferredSize(
              preferredSize: Size.fromHeight(size.height * 0.08),
              child: Container(
                width: size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RoundedInput(
                      onchange: (text) {
                        setState(() {
                          searchvalue = text;
                        });
                        print("Search text -------");
                      },
                      valid: (text) {},
                      save: (text) {},
                      hintText: "What are you looking for..",
                      icon: LineIcons.search,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: size.width * 0.01),
                      child: Container(
                          decoration: const BoxDecoration(
                              // color: kprimarylightcolor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                          width: size.width * 0.15,
                          child: Padding(
                            padding:
                                EdgeInsets.only(bottom: size.height * 0.008),
                            child: isfilter
                                ? IconButton(
                                    icon: Icon(
                                      Icons.filter_list_off_outlined,
                                      color:
                                          kPrimaryColorlight.withOpacity(0.8),
                                      size: size.width * 0.09,
                                    ),
                                    onPressed: () {
                                      isfilter = false;
                                      setState(() {});
                                    },
                                  )
                                : IconButton(
                                    icon: Icon(
                                      Icons.filter_list_outlined,
                                      color:
                                          kPrimaryColorlight.withOpacity(0.8),
                                      size: size.width * 0.09,
                                    ),
                                    onPressed: () {
                                      isfilter = true;
                                      setState(() {});
                                    },
                                  ),
                          )),
                    )
                  ],
                ),
              )),
        ),
        body: Column(
          children: [
            isfilter
                ? Card(
                    color: kPrimaryColorlight,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.close,
                                  color: kPrimaryColordark.withOpacity(0.8),
                                  size: size.width * 0.06,
                                ),
                                onPressed: () {
                                  isfilter = false;
                                  setState(() {});
                                },
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8, right: 8, bottom: 8),
                          child: Wrap(
                            children: [
                              DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  value: dropdowndis,
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  items: discts.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      dropdowndis = newValue!;
                                      if (newValue != seldis) {
                                        cities = getcitiesall(newValue);
                                      }
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  value: dropdowncity,
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  items: cities.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      dropdowncity = newValue!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                if (dropdowncity != selcity &&
                                    dropdowndis != seldis) {
                                  futureData = FbHandeler.getfilterPost(
                                      city: dropdowncity, distric: dropdowndis);
                                  setState(() {});
                                } else {
                                  Customtost.commontost(
                                      "Choose city or district", Colors.amber);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: kPrimaryColordark),
                              child: const Text("Filter Ads"),
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: () {
                                futureData = FbHandeler.getallPost();
                                isfilter = false;
                                setState(() {});
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: kPrimaryColordark),
                              child: const Text("Clear Filters"),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                : Container(),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Vegetables near you",
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: size.width * 0.040,
                          color: Colors.black87),
                    ),
                  ),
                  FutureBuilder(
                    future: futureData,
                    builder: (context, snapshot) {
                      print(snapshot.hasData);
                      if (snapshot.hasData) {
                        List<PostModel> tempdata =
                            snapshot.data as List<PostModel>;

                        List<PostModel> data = [];
                        print(data);
                        if (searchvalue.isEmpty) {
                          data = tempdata;
                        } else {
                          data = tempdata
                              .where((element) => element.title
                                  .toLowerCase()
                                  .contains(searchvalue.toLowerCase()))
                              .toList();
                        }
                        if (data.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Lottie.asset("assets/animations/newsno.json",
                                    width: size.width * 0.75),
                                Text(
                                  "No Ads just",
                                  overflow: TextOverflow.fade,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: size.width * 0.045,
                                      color: Colors.black54),
                                ),
                              ],
                            ),
                          ); //nodatafound.json
                        } else {
                          return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: data.length,
                              shrinkWrap: true,
                              itemBuilder: (context, indext) {
                                var pmodel = data[indext];
                                return Padding(
                                    padding: EdgeInsets.only(
                                        left: size.width * 0.01,
                                        right: size.width * 0.01),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return AdView(pmodel: pmodel);
                                            },
                                          ),
                                        );
                                      },
                                      child: Card(
                                        child: ListTile(
                                          leading:
                                              Image.network(pmodel.imageurl),
                                          title: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              pmodel.title,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: kBasefontColor,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: size.width * 0.04),
                                            ),
                                          ),
                                          subtitle: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8, right: 8, bottom: 8),
                                            child: Row(children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(pmodel.city,
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        softWrap: false,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: kBasefontColor
                                                                .withOpacity(
                                                                    0.8))),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    Text("Rs ${pmodel.price}",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        softWrap: false,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize:
                                                                size.width *
                                                                    0.038,
                                                            color:
                                                                kPrimaryColordark
                                                                    .withOpacity(
                                                                        0.8))),
                                                    const SizedBox(
                                                      height: 3,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Text(pmodel.addeddate,
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            softWrap: false,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: kBasefontColor
                                                                    .withOpacity(
                                                                        0.8))),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ]),
                                          ),
                                        ),
                                      ),
                                    ));
                              });
                        }
                      } else if (snapshot.hasError) {
                        return Errorpage(size: size.width * 0.7);
                      }
                      // By default show a loading spinner.
                      return Center(
                          child: Lottie.asset(
                              "assets/animations/loadinganimi.json",
                              width: size.width * 0.6));
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "All Vegetables",
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: size.width * 0.040,
                          color: Colors.black87),
                    ),
                  ),
                  FutureBuilder(
                    future: futureDataall,
                    builder: (context, snapshot) {
                      print(snapshot.hasData);
                      if (snapshot.hasData) {
                        List<PostModel> data = snapshot.data as List<PostModel>;

                        if (data.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Lottie.asset("assets/animations/newsno.json",
                                    width: size.width * 0.75),
                                Text(
                                  "No Ads just",
                                  overflow: TextOverflow.fade,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: size.width * 0.045,
                                      color: Colors.black54),
                                ),
                              ],
                            ),
                          ); //nodatafound.json
                        } else {
                          return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: data.length,
                              shrinkWrap: true,
                              itemBuilder: (context, indext) {
                                var pmodel = data[indext];
                                return Padding(
                                    padding: EdgeInsets.only(
                                        left: size.width * 0.01,
                                        right: size.width * 0.01),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return AdView(pmodel: pmodel);
                                            },
                                          ),
                                        );
                                      },
                                      child: Card(
                                        child: ListTile(
                                          leading:
                                              Image.network(pmodel.imageurl),
                                          title: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              pmodel.title,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: kBasefontColor,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: size.width * 0.04),
                                            ),
                                          ),
                                          subtitle: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8, right: 8, bottom: 8),
                                            child: Row(children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(pmodel.city,
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        softWrap: false,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: kBasefontColor
                                                                .withOpacity(
                                                                    0.8))),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    Text("Rs ${pmodel.price}",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        softWrap: false,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize:
                                                                size.width *
                                                                    0.038,
                                                            color:
                                                                kPrimaryColordark
                                                                    .withOpacity(
                                                                        0.8))),
                                                    const SizedBox(
                                                      height: 3,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Text(pmodel.addeddate,
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            softWrap: false,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: kBasefontColor
                                                                    .withOpacity(
                                                                        0.8))),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ]),
                                          ),
                                        ),
                                      ),
                                    ));
                              });
                        }
                      } else if (snapshot.hasError) {
                        return Errorpage(size: size.width * 0.7);
                      }
                      // By default show a loading spinner.
                      return Center(
                          child: Lottie.asset(
                              "assets/animations/loadinganimi.json",
                              width: size.width * 0.6));
                    },
                  )
                ],
              ),
            ),
          ],
        ));
  }

  loaddata() async {
    futureData = FbHandeler.getallPost();
    setState(() {});
  }
}
