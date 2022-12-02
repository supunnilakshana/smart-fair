import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:line_icons/line_icon.dart';
import 'package:lottie/lottie.dart';
import 'package:nearvegi/models/postmodel.dart';
import 'package:nearvegi/screens/components/errorpage.dart';
import 'package:nearvegi/services/firebase/fb_handeler.dart';

import '../../constants/constraints.dart';
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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    futureData = FbHandeler.getallPost();
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
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Lottie.asset("assets/animations/newsno.json",
                                  width: size.width * 0.75),
                              Text(
                                "No Posts just",
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: size.width * 0.045,
                                    color: Colors.black54),
                              ),
                            ],
                          ); //nodatafound.json
                        } else {
                          return Container(
                            child: ListView.builder(
                                itemCount: data.length,
                                itemBuilder: (context, indext) {
                                  return Padding(
                                      padding: EdgeInsets.only(
                                          left: size.width * 0.01,
                                          right: size.width * 0.01),
                                      child: Card());
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
    futureData = FbHandeler.getallPost();
    setState(() {});
  }
}
