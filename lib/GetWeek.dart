import 'package:flutter/material.dart';

class GetWeek extends StatefulWidget {
  final String text;
  GetWeek({ required this.text});


  @override
  _GetWeekState createState() => _GetWeekState();
}

class _GetWeekState extends State<GetWeek> {

  @override
  Widget build(BuildContext context) {
    int year = int.parse(widget.text.substring(0,4));
    assert(year is int);
    int month = int.parse(widget.text.substring(5,7));
    assert(month is int);
    int day = int.parse(widget.text.substring(8,10));
    DateTime selectedDate = DateTime.utc(year,month,day);
    int present_day = selectedDate.weekday;
    int first_day = selectedDate.day-present_day+1;
    print(first_day);
    return Scaffold(
      appBar: AppBar(
        title: Text("Calander"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Center(child: Text(widget.text)),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Mon"),
                Text("Tue"),
                Text("Wed"),
                Text("Thu"),
                Text("Fri"),
                Text("Sat"),
                Text("Sun"),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height/3.5,
            child: Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 35,
                        childAspectRatio: 3 / 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20),
                    itemCount: 7,
                    itemBuilder: (BuildContext ctx, index) {
                      return Container(
                        alignment: Alignment.center,
                        child: Text((index+first_day).toString()),
                        decoration: BoxDecoration(
                            color: index==present_day-1?Colors.green:Colors.amber,
                            borderRadius: BorderRadius.circular(15)),
                      );
                    }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
