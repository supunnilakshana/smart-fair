import 'package:nearvegi/models/usermodel.dart';

class PostModel {
  final String? id;
  final String title;
  final String context;
  final String addeddate;
  final String userid;
  final UserModel user;
  final String imageurl;
  final double price;
  final String city;
  final String dis;

  PostModel(
      {this.id,
      required this.title,
      required this.context,
      required this.addeddate,
      required this.price,
      required this.city,
      required this.dis,
      required this.user,
      required this.userid,
      required this.imageurl});
  Map<String, dynamic> toMap() {
    return {
      // 'id': id,
      'titel': title,
      'context': context,
      'addeddate': addeddate,
      'user': user.toMap(),
      'userid': userid,
      'price': price,
      'city': city,
      'dis': dis,
      'imageurl': imageurl
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> res, String id) {
    return PostModel(
        id: id,
        title: res['titel'],
        context: res['context'],
        price: res['price'],
        city: res['city'],
        dis: res['dis'],
        user: UserModel.fromMap(res['user']),
        addeddate: res['addeddate'],
        userid: res['userid'],
        imageurl: res['imageurl']);
  }
}
