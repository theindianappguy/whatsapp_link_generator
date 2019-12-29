import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final _formKey = GlobalKey<FormState>();

  String phone, message;
  String generatedUrl;
  bool urlGenerated = false, copied = false, validate = false;

  String _whatsAppLinkBuilder({phone,message}){
    String updatedMessage = message.toString().replaceAll(" ", "%20");
    String link = "https://api.whatsapp.com/send?phone=$phone&text="
        + updatedMessage;
    print(link);
    setState(() {
      generatedUrl = link;
      validate = false;
      urlGenerated = true;
      copied = false;
    });
    return link;

  }

  _launchURL() async {
    if (await canLaunch(generatedUrl)) {
      await launch(generatedUrl);
    } else {
      throw 'Could not launch $generatedUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Let's Generate"),
        centerTitle: true,
        backgroundColor: Colors.green[500],
      ),
      body: Stack(
        children: <Widget>[
          Container(height: double.infinity,width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.green[100],
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 30,),
                  Stack(
                    children: <Widget>[
                      Container(
                          width: double.infinity,
                          margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.green[500]),
                              borderRadius:
                              BorderRadius.circular(50)),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 20),
                                height: 22,
                                width: 22,
                                child: Icon(
                                  Icons.phone,
                                  color: Colors.green[500],
                                  size: 20,
                                ),
                              ),
                            ],
                          )),
                      Container(
                          height: 50,
                          margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                          padding: EdgeInsets.fromLTRB(50, 10, 0, 10),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            onSaved: (val) {
                              setState(() {
                                phone = val;
                              });
                            },
                            decoration: InputDecoration(
                              hintText: 'WhatsApp Number',
                              focusedBorder: InputBorder.none,
                              border: InputBorder.none,
                              hintStyle:
                              TextStyle(color: Colors.green[500]),
                            ),
                            style: TextStyle(
                                fontSize: 16, color: Colors.green[500]),
                          )),
                    ],
                  ),
                  SizedBox(height: 6,),
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: Text('Make sure you include the country code followed'
                        ' by the area code. E.g.1 for the US, 91 for the INDIA.',
                      style: TextStyle(fontSize: 14,color: Colors.green[400]),
                      textAlign: TextAlign.center,),
                  ),
                  SizedBox(height: 16,),
                  Stack(
                    children: <Widget>[
                      Container(
                          width: double.infinity,
                          margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.green[500]),
                              borderRadius:
                              BorderRadius.circular(50)),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 20),
                                height: 22,
                                width: 22,
                                child: Icon(
                                  Icons.message,
                                  color: Colors.green[500],
                                  size: 20,
                                ),
                              ),
                            ],
                          )),
                      Container(
                          height: 50,
                          margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                          padding: EdgeInsets.fromLTRB(50, 10, 0, 10),
                          child: TextFormField(
                            onSaved: (val) {
                              setState(() {
                                message = val;
                              });
                            },
                            decoration: InputDecoration(
                              hintText: 'Message',
                              focusedBorder: InputBorder.none,
                              border: InputBorder.none,
                              hintStyle:
                              TextStyle(color: Colors.green[500]),
                            ),
                            style: TextStyle(
                                fontSize: 16, color: Colors.green[500]),
                          )),
                    ],
                  ),
                  SizedBox(height: 8,),
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: Text('What message do you want your customers to see'
                        ' when they contact you?',
                      style: TextStyle(fontSize: 14,color: Colors.green[400]),
                      textAlign: TextAlign.center,),
                  ),
                  SizedBox(height: 24,),
                  InkWell(
                    onTap: () {
                      _formKey.currentState.save();
                      if(phone.isEmpty || message.isEmpty){
                        setState(() {
                          validate = true;
                        });
                      }else{
                        _whatsAppLinkBuilder(phone: phone,message: message);
                      }
                    },
                    child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50)),
                      margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: Center(
                          child: Text(
                            'Generate WhatsApp Link',
                            style: TextStyle(fontSize: 16, color: Colors.green[400], fontWeight: FontWeight.bold),
                          )),
                    ),
                  ),
                  SizedBox(height: 8,),
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: Text(validate ? '''Make Sure both feilds are filled '''+
                        ''''then click "Generate WhatsApp Link"''':"",
                      style: TextStyle(fontSize: 14,color: Colors.red[400]),
                      textAlign: TextAlign.center,),
                  ),
                  SizedBox(height: 20,),
                  Flexible(
                    child: Wrap(
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            InkWell(
                              child: Text(!urlGenerated ? "":generatedUrl,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 14),),
                              onTap: () async {
                                _launchURL();
                              },),
                            SizedBox(height: 8,),
                            urlGenerated ? GestureDetector(
                                onTap: (){
                                  Clipboard.setData(new ClipboardData(text: generatedUrl));
                                  setState(() {
                                    copied = true;
                                  });
                                },
                                child: Icon(Icons.content_copy,color: copied ? Colors.green:Colors.black26,)):Container()
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

