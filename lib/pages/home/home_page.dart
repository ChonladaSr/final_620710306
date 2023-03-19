import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../models/poll.dart';
import '../my_scaffold.dart';

class HomePage extends StatefulWidget {
  //final int pollId;
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Poll>? _polls;
  var _isLoading = false;


  @override
  void initState() {
    super.initState();
    _loadData();
  }
  //Future<http.Response> _loadData() {
   // return http.get(Uri.parse('https://cpsu-test-api.herokuapp.com/api/polls/1'));
    // widget.pollId;
    // todo: Load list of polls here
 // }
  Future<Poll> _loadData() async {
    final response = await http
        .get(Uri.parse('https://cpsu-test-api.herokuapp.com/api/polls/1'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Poll.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: Column(
        children: [
          Image.network('https://cpsu-test-api.herokuapp.com/images/election.jpg'),
          Expanded(
            child: Stack(
              children: [
                const SizedBox(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text("1. บุคคลใดที่คุณจะสนับสนุนให้เป็นนายกรัฐมนตรีในการเลือกตั้งครั้งนี้"),

                  ),
                ),
                if (_polls != null) _buildList(),
                if (_isLoading) _buildProgress(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ListView _buildList() {
    return ListView.builder(
      itemCount: _polls!.length,
      itemBuilder: (BuildContext context, int index) {

        // todo: Create your poll item by replacing this Container()
        return Container();
      },
    );
  }

  Widget _buildProgress() {
    return Container(
      color: Colors.black.withOpacity(0.6),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            CircularProgressIndicator(color: Colors.white),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('รอสักครู่', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

}
