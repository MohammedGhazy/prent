import 'dart:convert';
import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prent/screens/descreption_screen.dart';
import 'package:prent/model/search_model.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => new _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController controller = new TextEditingController();

  Future<Null> getUserDetails() async {
    final response = await http.get(url);
    final responseJson = json.decode(response.body);

    setState(() {
      for (Map user in responseJson) {
        _userDetails.add(DataSearch.fromJson(user));
      }
    });
    print(':::::::::::::::::::' + _userDetails[0].images.length.toString());
  }

  @override
  void initState() {
    super.initState();

    getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            }),
        backgroundColor: Color(0xffFFCA37),
        title: Container(
          height: 40,
          child: TextField(
            style: new TextStyle(color: Colors.white),
                controller: controller,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  prefixIcon: Icon(Icons.search,color: Colors.white,),
                  enabled: true,
                  fillColor: Color(0xffF7B600),
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  suffixIcon: IconButton(
                    icon: new Icon(
                      Icons.cancel,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      controller.clear();
                      onSearchTextChanged('');
                    },
                  ),
                  hintText: '',
                ),
                onChanged: onSearchTextChanged,
              ),
        ),
        elevation: 0.0,
      ),
      body: new Column(
        children: <Widget>[
          new Expanded(
              child: _searchResult.length != 0 || controller.text.isNotEmpty
                  ? ListView.builder(
                      itemCount: _searchResult.length,
                      itemBuilder: (context, i) {
                        return new Card(
                          child: ListTile(
                            title: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Text(
                                _searchResult[i].modelName,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  width: 15.0,
                                ),
                                Text(''),
                                SizedBox(
                                  height: 5.0,
                                  width: 15.0,
                                ),
                                Text(_searchResult[i].features[0].feature),
                                SizedBox(
                                  height: 5.0,
                                ),
                                FlatButton(
                                    onPressed: () {},
                                    child: Container(
                                      decoration: new BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        color: Colors.orange,
                                      ),
                                      height: 35.0,
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DescriptionScreen(
                                                        type: 'search',
                                                        dataSearch:
                                                            _searchResult[i],
                                                      )));
                                        },
                                        child: Container(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Icon(Icons.add_shopping_cart,color: Colors.white,),
                                              Text(
                                                AppLocalizations.of(context).tr(
                                                    'search.show product')
                                                ,
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ))
                              ],
                            ),
                            leading: Container(
                                height: 500.0,
                                decoration: BoxDecoration(
                                    color: Colors.black12,
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.elliptical(50.0, 55.0),
                                        bottomRight:
                                            Radius.elliptical(50.0, 55.0))),
                                child: Image.network(
                                  _searchResult[i].images[0].images,
                                  fit: BoxFit.cover,
                                  height: 200.0,
                                )),
                          ),
                          elevation: 2.0,
                        );
                      },
                    )
                  : Container(
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context).tr(
                              'search.search your printer')
                          ,
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    )),
        ],
      ),
    );
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    _userDetails.forEach((userDetail) {
      if (userDetail.modelName.contains(text) ||
          userDetail.modelName.contains(text)) _searchResult.add(userDetail);
    });

    setState(() {});
  }
}

List<DataSearch> _searchResult = [];

List<DataSearch> _userDetails = [];

final String url = 'http://p-prent.com/api/search';
