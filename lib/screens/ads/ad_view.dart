import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nearvegi/models/postmodel.dart';

import '../../constants/constraints.dart';

class AdView extends StatelessWidget {
  final PostModel pmodel;
  const AdView({Key? key, required this.pmodel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 10),
            child: ClipRRect(
              borderRadius:
                  BorderRadius.all(Radius.circular(size.width * 0.03)),
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: pmodel.imageurl,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Container(
                  //  height: size.height * 0.01,
                  child: Center(
                    child: CircularProgressIndicator(
                        color: Colors.green.shade800,
                        value: downloadProgress.progress),
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 5),
            child: Row(
              children: [
                Text(
                  pmodel.title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: kBasefontColor,
                      fontWeight: FontWeight.w700,
                      fontSize: size.width * 0.054),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 3),
            child: Row(
              children: [
                Text(
                    "Post on ${pmodel.addeddate}, ${pmodel.city}, ${pmodel.dis}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        //fontSize: size.width * 0.038,
                        color: kBasefontColor.withOpacity(0.8))),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 15,
              top: 20,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Divider(
                    color: kBasefontColor.withOpacity(0.7),
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 15),
            child: Row(
              children: [
                Text("Rs ${pmodel.price}",
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: size.width * 0.048,
                        color: kPrimaryColordark.withOpacity(0.8))),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 8),
            child: Row(
              children: [
                Text("For Sale by ",
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        //fontSize: size.width * 0.038,
                        color: kBasefontColor.withOpacity(0.7))),
                Text(" ${pmodel.user.name}",
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: size.width * 0.038,
                        color: kBasefontColor.withOpacity(0.8))),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 20),
            child: Row(
              children: [
                Text("Description",
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: size.width * 0.038,
                        color: kBasefontColor.withOpacity(0.8))),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 8),
            child: Row(
              children: [
                Text("${pmodel.context} ",
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        //fontSize: size.width * 0.038,
                        color: kBasefontColor.withOpacity(0.7))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
