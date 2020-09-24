import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';

class TrackOrder extends StatefulWidget {
  TrackOrder({Key key}) : super(key: key);
  static const routeName = '/trackOrder';

  @override
  _TrackOrderState createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrder> {
  bool _showDetails = false;
  String orderId = "";
  String orderDetails = "";
  var data = "";
  var url = "https://unistam.co.in/yoyo_pizza/yoyo_pizza.php";

  Future mesResp(mes) async {
    var res = await http.post(url,
        body: {
          "track_my_id": mes
        }
    );
    data = res.body;
    log("2");
    log('data : $data');
    if (data != null) {
      orderDetails = data;
    }
    log("3");
    log("orderDetails : $orderDetails");
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("Yo Yo Pizza"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                SizedBox(
                  width: 300,
                  child: CupertinoTextField(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.circular(8)),
                    controller: controller,
                    placeholder: "Enter Order ID",
                  ),
                ),
                SizedBox(height: 150),
                IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () async {
                      var res = await http.post(url,
                          body: {
                            "track_my_id": controller.text
                          }
                      );
                      data = res.body;
                      setState(() {
                        orderId = controller.text;
                        //mesResp(orderId);
                        // FETCH ORDER DETAILS AND STORE IT IN THE BELOW VARIABLE
                        orderDetails = data;
                        log("orderDetails search : $orderDetails + $data");
                        _showDetails = true;
                      });
                      print(controller.text);
                    })
              ],
            ),
          ),
          _showDetails
              ? Container(
                  height: 200,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.7),
                        offset: Offset(10, 10),
                        blurRadius: 20,
                      ),
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        offset: Offset(-10, -10),
                        blurRadius: 20,
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        orderId,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 36),
                      ),
                      Html(
                          data: orderDetails,
                          style: {
                            "body": Style(
                              fontSize: FontSize(18.0),
                            ),
                          },),
                    ],
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
