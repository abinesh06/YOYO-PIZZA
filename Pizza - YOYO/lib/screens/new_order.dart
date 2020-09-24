import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';
import 'package:flutter_html/style.dart';
import 'package:intl/intl.dart';
import 'dart:developer';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;

class NewOrder extends StatefulWidget {
  NewOrder({Key key}) : super(key: key);
  static const routeName = 'newOrder';

  @override
  _NewOrderState createState() => _NewOrderState();
}

class _NewOrderState extends State<NewOrder> {
  TextStyle _messageStyle = TextStyle(
    fontSize: 18,
  );

  final messageInsert = TextEditingController();

  List<Map> messages = [];
  var url = "https://unistam.co.in/yoyo_pizza/yoyo_pizza.php";
  var prev="",items="",name="",addr="",phone="";


  @override
  void dispose() {
    messageInsert.dispose();
    super.dispose();
  }

  @override
  void initState() {
    mesResp("");
  }

  Future mesResp(mes) async{
    var res = await http.post(url,
      body: {
        "message_sent":mes,
        "prev_ques":prev,
        "items":items,
        "name_in_order":name,
        "delivery_addr":addr,
        "phone":phone
      }
    );
    var data = json.decode(res.body);
    log('data : $data');
    if(data!=null){
      prev=data["prev_ques"];
      items=data["items"];
      name=data["name_in_order"];
      addr=data["delivery_addr"];
      phone=data["phone"];
      response(data["message"]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Yo Yo Pizza"),
        actions: [
          FlatButton(
              onPressed: () {
                setState(() {
                  messages.clear();
                });
              },
              child: Text(
                "Clear",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 15, bottom: 10),
              child: Text(
                "Today, ${DateFormat("Hm").format(DateTime.now())}",
                style: TextStyle(fontSize: 16),
              ),
            ),
            Flexible(
                child: ListView.builder(
              reverse: true,
              itemBuilder: (context, index) => getBubble(
                  messages[index]['data'], messages[index]['isHuman']),
              itemCount: messages.length,
            )),
            Container(
              child: ListTile(
                title: Container(
                  height: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Color.fromRGBO(220, 220, 220, 1),
                  ),
                  padding: EdgeInsets.only(left: 15),
                  child: TextFormField(
                    controller: messageInsert,
                    decoration: InputDecoration(
                      hintText: "Enter a Message...",
                      hintStyle: TextStyle(color: Colors.black26),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                    style: TextStyle(fontSize: 16, color: Colors.black),
                    onChanged: (value) {},
                  ),
                ),
                trailing: IconButton(
                    icon: Icon(
                      Icons.send,
                      size: 30.0,
                      color: Colors.greenAccent,
                    ),
                    onPressed: () {
                      if (messageInsert.text.isEmpty) {
                        print("empty message");
                      } else {
                        setState(() {
                          messages.insert(
                              0, {'data': messageInsert.text, 'isHuman': true});
                          // messsages.insert(0,
                          //     {"data": 1, "message": messageInsert.text});
                        });
                        mesResp(messageInsert.text);
                        messageInsert.clear();
                      }
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                    }),
              ),
            ),

            SizedBox(
              height: 15.0,
            )
          ],
        ),
      ),
    );
  }

  void response(message) async {
    // AuthGoogle authGoogle = await AuthGoogle(
    //     fileJson: "assets/service.json")
    //     .build();
    // Dialogflow dialogflow =
    // Dialogflow(authGoogle: authGoogle, language: Language.english);
    // AIResponse aiResponse = await dialogflow.detectIntent(query);
    setState(() {
      messages.insert(0, {
        "isHuman": false,
        "data": message,
      });
    });
  }

  Widget getBubble(String message, bool isUser) {
    return isUser
        ? Bubble(
            margin: BubbleEdges.only(top: 10),
            alignment: Alignment.topRight,
            nip: BubbleNip.rightTop,
            color: Colors.blue[50],
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                message,
                textAlign: TextAlign.right,
                style: _messageStyle,
              ),
            ),
          )
        : Bubble(
            margin: BubbleEdges.only(top: 10),
            alignment: Alignment.topLeft,
            nip: BubbleNip.leftTop,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Html(
                data: message,
                style: {
                  "body": Style(
                    fontSize: FontSize(18.0),
                  ),
                },
              )
            ),
          );
  }

  // Widget _buildTextComposer() {
  //   return IconTheme(
  //     data: IconThemeData(color: Colors.blue),
  //     child: Container(
  //       margin: const EdgeInsets.symmetric(horizontal: 8.0),
  //       child: Row(
  //         children: [
  //           Flexible(
  //             child: TextField(
  //               controller: _textController,
  //               onSubmitted: _handleSubmitted,
  //               decoration:
  //                   InputDecoration.collapsed(hintText: 'Send a message'),
  //             ),
  //           ),
  //           Container(
  //             margin: const EdgeInsets.symmetric(horizontal: 4.0),
  //             child: IconButton(
  //                 icon: Icon(Icons.send),
  //                 onPressed: () => _handleSubmitted(_textController.text)),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // void _handleSubmitted(String text) {
  //   _textController.clear();
  // }
}
