import 'dart:convert';
import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:prent/screens/done_screen.dart';
import 'package:provider/provider.dart';

import '../provider.dart';

final format = DateFormat("yyyy-MM-dd");

class CompleteTransactionScreen extends StatefulWidget {
  final List name;

  CompleteTransactionScreen({this.name});

  @override
  _CompleteTransactionScreenState createState() =>
      _CompleteTransactionScreenState();
}

class _CompleteTransactionScreenState extends State<CompleteTransactionScreen> {
  bool loading = false;
  bool done = false;
  bool error = false;

  String name,
      e_mail,
      number,
      company,

      currentValue1 = 'null',
      currentValue = 'null';

  Future<void> addData(
      String name,
      String e_mail,
      String number,
      String company,
      String date,
      String currentValue,
      String currentValue1,
      String t) async {
    setState(() {
      loading = true;
    });
    String myUrl = "http://p-prent.com/api/newOrder";
    var body = {
      "name": "$name",
      "email": "$e_mail",
      "company_name": "$company",

      "phone": "$number",
      "data": date == null ? DateTime.now().toString() : "$date",
      "time1": currentValue == null ? ' ' : "$currentValue",
      "time2": currentValue1 == null ? ' ' : "$currentValue1",
      "card": t,
    };
    print(':::::::::::: Body Sent :::::::::::::::' + body.toString());
    await http
        .post(myUrl,
            headers: {
              'Accept': 'application/json',
            },
            body: body)
        .then((response) {
      // ه اللى جايلك من السيرفر
      print('Response status : ${response.statusCode}');
      print('Response body : ${response.body}');
      setState(() {
        loading = false;
        done = true;
      });
    }).catchError((error) {
      setState(() {
        error = true;
      });
    });
  }

  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;
  String currentSelectedValue = "yearly";

  Widget buildFirstCard() {
    return Form(
      key: _key,
      autovalidate: _validate,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: EdgeInsets.only(left: 15.0, right: 25.0, top: 2.0),
            child: TextFormField(
              obscureText: false,
              keyboardType: TextInputType.multiline,
              validator: validateName,
              autofocus: true,
              onSaved: (value) {
                name = value;
              },
              decoration: InputDecoration(
                filled: true,
                  fillColor: Colors.white,
                  focusColor: Colors.white,
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFF9AB55))),
                  hintText: AppLocalizations.of(context).tr(
                    'complete_screen.full_name',
                  ),
                  hintStyle: TextStyle(fontFamily: 'Tajawal'),
                  labelText: AppLocalizations.of(context).tr(
                    'complete_screen.full_name',
                  ),
                  labelStyle: TextStyle(
                    color: Color(0xFFF9AB55),
                    fontSize: 15,
                    fontFamily: 'Tajawal',
                  )),
            ),
          ),
          SizedBox(height: 16.0,),
          Padding(
            padding: EdgeInsets.only(left: 15.0, right: 25.0, top: 2.0),
            child: TextFormField(
              obscureText: false,
              keyboardType: TextInputType.multiline,
              autofocus: true,
              validator: validateEmail,
              onSaved: (value) {
                e_mail = value;
              },
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  focusColor: Colors.white,
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFF9AB55))),
                  hintText: 'example.com',
                  hintStyle: TextStyle(fontFamily: 'Tajawal'),
                  labelText: AppLocalizations.of(context).tr(
                    'complete_screen.e_mail',
                  ),
                  labelStyle: TextStyle(
                    color: Color(0xFFF9AB55),
                    fontSize: 15,
                    fontFamily: 'Tajawal',
                  )),
            ),
          ),
          SizedBox(height: 16.0,),
          Padding(
            padding: EdgeInsets.only(left: 15.0, right: 25.0, top: 2.0),
            child: TextFormField(
              obscureText: false,
              keyboardType: TextInputType.multiline,
              autofocus: true,
              validator: validateMobile,
              onSaved: (value) {
                number = value;
              },
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  focusColor: Colors.white,
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFF9AB55))),
                  hintText: '000 - 000 - 960+',
                  hintStyle: TextStyle(fontFamily: 'Tajawal'),
                  labelText: AppLocalizations.of(context).tr(
                    'complete_screen.phone',
                  ),
                  labelStyle: TextStyle(
                    color: Color(0xFFF9AB55),
                    fontSize: 15,
                    fontFamily: 'Tajawal',
                  )),
            ),
          ),
          SizedBox(height: 16.0,),
          Padding(
            padding: EdgeInsets.only(left: 15.0, right: 25.0, top: 2.0),
            child: TextFormField(
              obscureText: false,
              keyboardType: TextInputType.multiline,
              autofocus: true,
              onSaved: (value) {
                company = value;
              },
              decoration: InputDecoration(
                filled: true,
                  fillColor: Colors.white,
                  focusColor: Colors.white,
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFF9AB55))),
                  labelText: AppLocalizations.of(context).tr(
                    'complete_screen.name of company',
                  ),
                  labelStyle: TextStyle(
                    color: Color(0xFFF9AB55),
                    fontSize: 15,
                    fontFamily: 'Tajawal',
                  ),
                  hintText: AppLocalizations.of(context).tr(
                    'complete_screen.name of company',
                  ),
                  hintStyle: TextStyle(fontFamily: 'Tajawal')),
            ),
          ),
          SizedBox(height: 16.0,),
          Padding(
            padding: const EdgeInsets.only(top: 25.0, left: 20.0, right: 20.0),
            child: DropdownButtonFormField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(
                      top: 5, bottom: 5, right: 10.0, left: 10.0),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange)),
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.orange, width: 5.0))),
              items: ['yearly', 'event']
                  .map(
                    (value) => DropdownMenuItem(
                      child: Text(value),
                      value: value,
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  currentSelectedValue = value;
                });
              },
              isExpanded: false,
              hint: Text(
                currentSelectedValue + '                                ',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontFamily: 'beINNormal',
                ),
              ),
              iconDisabledColor: Colors.black,
              iconEnabledColor: Colors.black,
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          currentSelectedValue == "yaerly"
              ? Center(child: Text(""))
              : currentSelectedValue == "event"
                  ? Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              left: 15.0, right: 25.0, top: 2.0),
                          child: TextFormField(
                            obscureText: false,
                            onSaved: (value) {
                              currentValue = value;
                            },
                            keyboardType: TextInputType.multiline,
                            autofocus: true,
                            validator: startDate,
                            decoration: InputDecoration(
                              filled: true,
                                fillColor: Colors.white,
                                focusColor: Colors.white,
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xFFF9AB55))),
                                hintText: AppLocalizations.of(context).tr(
                                  'complete_screen.start event',
                                ),
                                hintStyle: TextStyle(fontFamily: 'Tajawal'),
                                labelText: AppLocalizations.of(context).tr(
                                  'complete_screen.start event',
                                ),
                                labelStyle: TextStyle(
                                  color: Color(0xFFF9AB55),
                                  fontSize: 15,
                                  fontFamily: 'Tajawal',
                                )),
                          ),
                        ),
                        SizedBox(height: 16.0,),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 15.0, right: 25.0, top: 2.0),
                          child: TextFormField(
                            obscureText: false,
                            onSaved: (value) {
                              currentValue1 = value;
                            },
                            keyboardType: TextInputType.multiline,
                            validator: endDate,
                            autofocus: true,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                focusColor: Colors.white,
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xFFF9AB55))),
                                hintText: AppLocalizations.of(context).tr(
                                  'complete_screen.end event',
                                ),
                                hintStyle: TextStyle(fontFamily: 'Tajawal'),
                                labelText: AppLocalizations.of(context).tr(
                                  'complete_screen.end event',
                                ),
                                labelStyle: TextStyle(
                                  color: Color(0xFFF9AB55),
                                  fontSize: 15,
                                  fontFamily: 'Tajawal',
                                )),
                          ),
                        ),
                      ],
                    )
                  : Center(child: Text("")),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff4f4f4),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xffFFCA37),
        title: Text(
          'إتمام العمليه',
          style: TextStyle(fontFamily: 'Tajawal', color: Colors.white),
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: ListView(
        children: <Widget>[
          buildFirstCard(),
//          getBody(),
          SizedBox(
            height: 10.0,
          ),
          error
              ? InkWell(
                  onTap: () async {

                    final formData = _key.currentState;
                    final formData2 = _key.currentState;
                    if (formData.validate()) {
                      formData.save();
                      formData2.save();
                      await addData(
                          name,
                          e_mail,
                          number,
                          company,

                          currentSelectedValue,
                          currentValue,
                          currentValue1,
                          json.encode(widget.name));
                    } else {
                      print('::::::::::::::::::::error::::::::::');
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15.0, left: 15.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 40.0,
                      decoration: BoxDecoration(
                        color: Color(0xFF59B95F),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Center(
                        child: Text(
                          'An error occured try again?',
                          style: TextStyle(
                              fontFamily: 'Tajawal', color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                )
              : done
                  ? Center(
                      child: Text(
                        '',
                        style: TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 18.0,
                        ),
                      ),
                    )
                  : loading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : InkWell(
                          onTap: () async {
                            final formData = _key.currentState;
                            final formData2 = _key.currentState;
                            if (formData.validate()) {
                              formData.save();
                              formData2.save();
                              await addData(
                                  name,
                                  e_mail,
                                  number,
                                  company,

                                  currentSelectedValue,
                                  currentValue,
                                  currentValue1,
                                  json.encode(widget.name));
                              Provider.of<Logic>(context, listen: false)
                                  .emptyCart();
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => DoneScreen()));
                            } else {
                              print(':::::::::::::::::::::error::::::::::');
                            }
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.only(right: 15.0, left: 15.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 40.0,
                              decoration: BoxDecoration(
                                color: Color(0xFF59B95F),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Center(
                                child: Text(
                                  AppLocalizations.of(context).tr(
                                    'complete_screen.confirm transection',
                                  ),
                                  style: TextStyle(
                                      fontFamily: 'Tajawal',
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
          SizedBox(height: 20.0,)
        ],
      ),
    );
  }

  DateTime date;
  TimeOfDay time;

  String validateName(String value) {
    String pattern = r'';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return AppLocalizations.of(context).tr(
        'complete_screen.name is Required',
      );
    } else if (value.length == 20) {
      return AppLocalizations.of(context).tr(
        'complete_screen.name is Required',
      );
    } else if (!regExp.hasMatch(value)) {
      return AppLocalizations.of(context).tr(
        'complete_screen.name is Required',
      );
    }
  }

  String startDate(String value1) {
    String pattern =
        r'^(?:(?:31(\/|-|\.)(?:0?[13578]|1[02]))\1|(?:(?:29|30)(\/|-|\.)(?:0?[13-9]|1[0-2])\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(\/|-|\.)0?2\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:(?:1[6-9]|[2-9]\d)?\d{2})$';

    RegExp regExp = new RegExp(pattern);
    if (value1.length == 0) {
      return AppLocalizations.of(context).tr(
        'complete_screen.validation_event',
      );
    } else if (value1.length >= 20) {
      return AppLocalizations.of(context).tr(
        'complete_screen.validation_event',
      );
    } else if (!regExp.hasMatch(value1)) {
      return AppLocalizations.of(context).tr(
        'complete_screen.validation_event',
      );
    }
    return null;
  }

  String endDate(String value2) {
    String pattern =
        r'^(?:(?:31(\/|-|\.)(?:0?[13578]|1[02]))\1|(?:(?:29|30)(\/|-|\.)(?:0?[13-9]|1[0-2])\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(\/|-|\.)0?2\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:(?:1[6-9]|[2-9]\d)?\d{2})$';

    RegExp regExp = new RegExp(pattern);
    if (value2.length == 0) {
      return AppLocalizations.of(context).tr(
        'complete_screen.validation_event',
      );
    } else if (value2.length >= 20) {
      return AppLocalizations.of(context).tr(
        'complete_screen.validation_event',
      );
    } else if (!regExp.hasMatch(value2)) {
      return AppLocalizations.of(context).tr(
        'complete_screen.validation_event',
      );
    }
    return null;
  }

  String validateMobile(String value) {
    String pattern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return AppLocalizations.of(context).tr(
        'complete_screen.Mobile is Required',
      );
    } else if (value.length == 14) {
      return AppLocalizations.of(context).tr(
        'complete_screen.Mobile is Required1',
      );
    } else if (!regExp.hasMatch(value)) {
      return AppLocalizations.of(context).tr(
        'complete_screen.confirm3_mobile',
      );
    }
    return null;
  }

  String validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return AppLocalizations.of(context).tr(
        'complete_screen.Email is Required',
      );
    } else if (!regExp.hasMatch(value)) {
      return AppLocalizations.of(context).tr(
        'complete_screen.Email is Required1',
      );
    } else {
      return null;
    }
  }
}
