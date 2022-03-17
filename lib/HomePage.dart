import 'package:assignmentgroww/GetWeek.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';



class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // DateTime selectedDate = DateTime.utc(2022,10);
  DateTime selectedDate = DateTime.now();


  int currentDateSelectedIndex = 0;
  ScrollController scrollController = ScrollController(); //To Track Scroll of ListView

  List<String> listOfMonths = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];

  List<String> listOfDays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

   Map<String,int> monthsInYear = {
     "Jan" : 1,
     "Feb": 2,
     "Mar": 3,
     "Apr":4,
     "May":5,
     "Jun":6,
     "Jul":7,
     "Aug":8,
     "Sep":9,
     "Oct":10,
     "Nov":11,
     "Dec":12
  };
  @override
  Widget build(BuildContext context) {
    int month = selectedDate.month.toInt();
    var date = new DateTime(selectedDate.year,selectedDate.month,0);
    int year = selectedDate.year;
    int monthh = selectedDate.month;
    DateTime thisMonth = DateTime(year,monthh,0);
    DateTime nextMonth = DateTime(year,monthh+1,0);
    int days =  nextMonth.difference(thisMonth).inDays+date.weekday;
    String selected_value = listOfMonths[selectedDate.month-1];
    int changed_year = selectedDate.year;
    String new_date = selectedDate.toString().substring(0,10);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Calander"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Center(child: Text(selectedDate.toString().substring(0,10))),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    focusColor: Colors.blueAccent,
                    hint: Center(
                      child: Text(
                        'Select Item',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme
                              .of(context)
                              .hintColor,
                        ),
                      ),
                    ),
                    items: listOfMonths
                        .map((item) =>
                        DropdownMenuItem<String>(
                          value: item,
                          child: Center(
                            child: Text(
                              item,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ))
                        .toList(),
                    value: selected_value,
                    onChanged: (value) async{
                      setState(() {
                        selected_value = value as String;
                        // var myInt = int.parse(value);
                        // assert(myInt is int);
                          int val = monthsInYear[selected_value]!.toInt();

                            selectedDate = DateTime.utc(selectedDate.year,val,1);


                      });
                    },
                    buttonHeight: 40,
                    buttonWidth: 100,
                    itemHeight: 40,
                  ),
                ),


              ],
            ),
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
                      itemCount: days,
                      itemBuilder: (BuildContext ctx, index) {
                        return index<date.weekday?Container():index<selectedDate.day?Container(
                          alignment: Alignment.center,
                          child: Text((index-date.weekday+1).toString()),
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(15)),
                        ):Container(
                          alignment: Alignment.center,
                          child: Text((index-date.weekday+1).toString()),
                          decoration: BoxDecoration(
                              color: (index==selectedDate.day)?Colors.green:Colors.amber,
                              borderRadius: BorderRadius.circular(15)),
                        );
                      }),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 50,
                  width: 130,
                  child: TextField(
                    onChanged: (n_year){
                      var myInt = int.parse(n_year);
                      assert(myInt is int);
                      changed_year = myInt;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Year',
                      hintText: 'Enter Year',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: InkWell(
                    onTap: (){
                      setState(() {
                        selectedDate = DateTime.utc(changed_year,selectedDate.month,1);
                      });
                    },
                    child: Container(
                      height: 40,
                      width: 60,

                      decoration: BoxDecoration(
                          color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Center(child: Text("Submit")),
                    ),
                  ),
                ),
              ],
            ),


            Padding(
              padding: const EdgeInsets.only(top: 50,left: 10),
              child: Row(
                children: [
                  Text("Enter a Date to retrieve a week (yyyy-mm-dd)"),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 10,top: 30),
              child: Row(
                children: [
                  Container(
                    height: 60,
                    width: 130,
                    child: TextField(
                      onSubmitted: (new_d){
                        new_date = new_d;
                      },
                      onChanged: (new_d){
                          new_date = new_d;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Date',
                        hintText: new_date,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: InkWell(
                      onTap: (){
                        // print(new_date);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => GetWeek(text: new_date,)));
                      },
                      child: Container(
                        height: 40,
                        width: 80,

                        decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Center(child: Text("Get Week")),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
