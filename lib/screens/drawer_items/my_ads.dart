import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:line_icons/line_icon.dart';
import 'package:lottie/lottie.dart';
import 'package:nearvegi/models/postmodel.dart';
import 'package:nearvegi/screens/components/errorpage.dart';
import 'package:nearvegi/screens/components/popup_dilog.dart';
import 'package:nearvegi/screens/components/tots.dart';
import 'package:nearvegi/services/firebase/fb_handeler.dart';

import '../../constants/constraints.dart';
import '../../constants/initdata.dart';
import '../home/drawer.dart';

class MyAdsScreen extends StatefulWidget {
  const MyAdsScreen({
    Key? key,
  }) : super(key: key);
  @override
  _MyAdsScreenState createState() => _MyAdsScreenState();
}

class _MyAdsScreenState extends State<MyAdsScreen> {
  late Future<List<PostModel>> futureData;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    futureData = FbHandeler.getmyPost();
  }

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
                Text(
                  "My advertisements",
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
            )),
        body: Container(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  child: FutureBuilder(
                    future: futureData,
                    builder: (context, snapshot) {
                      print(snapshot.hasData);
                      if (snapshot.hasData) {
                        List<PostModel> data = snapshot.data as List<PostModel>;
                        print(data);
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
                          return Container(
                            child: ListView.builder(
                                itemCount: data.length,
                                itemBuilder: (context, indext) {
                                  var pmodel = data[indext];
                                  return Padding(
                                      padding: EdgeInsets.only(
                                          left: size.width * 0.01,
                                          right: size.width * 0.01),
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
                                            padding: EdgeInsets.only(
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
                                                    SizedBox(
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
                                                    SizedBox(
                                                      height: 3,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                            child: Container()),
                                                        Expanded(
                                                          child: Text(
                                                              pmodel.addeddate,
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
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ]),
                                          ),
                                          trailing: IconButton(
                                            onPressed: () async {
                                              PopupDialog.showPopupWarning(
                                                  context,
                                                  "Remove",
                                                  "Are you sure to delete this ad? ",
                                                  () async {
                                                int res =
                                                    await FbHandeler.deletedoc(
                                                        CollectionPath.postpath,
                                                        pmodel.id!);
                                                if (res == resok) {
                                                  Customtost.commontost(
                                                      "Sucessfully removed",
                                                      Colors.green);
                                                  loaddata();
                                                } else {
                                                  Customtost.commontost(
                                                      " Removing failed",
                                                      Colors.red);
                                                }
                                              });
                                            },
                                            icon: Icon(
                                              Icons.delete,
                                              color: kBasefontColor
                                                  .withOpacity(0.6),
                                            ),
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            iconSize: size.width * 0.07,
                                          ),
                                        ),
                                      ));
                                }),
                          );
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
                ),
              ),
            ],
          ),
        ));
  }

  loaddata() async {
    futureData = FbHandeler.getmyPost();
    setState(() {});
  }
}
