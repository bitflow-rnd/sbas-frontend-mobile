import 'package:flutter/material.dart';

class PatientLookupScreen extends StatefulWidget {
  const PatientLookupScreen({super.key});

  @override
  State<PatientLookupScreen> createState() => _PatientLookupScreenState();
}

const double width = 300.0;
const double height = 60.0;
const double todayAlign = -1;
const double signInAlign = 1;
const Color selectedColor = Colors.black;
const Color normalColor = Colors.black38;

class _PatientLookupScreenState extends State<PatientLookupScreen> {
  late double xAlign;
  late Color todayColor;
  late Color tomorrowColor;
  late bool selectedValue;

  @override
  void initState() {
    super.initState();
    xAlign = todayAlign;
    todayColor = selectedColor;
    tomorrowColor = normalColor;
    selectedValue = true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Container(
            height: 10,
          ),
          Container(
            width: width,
            height: 100,
            decoration: const BoxDecoration(
              // color: Colors.red,
              borderRadius: BorderRadius.all(
                Radius.circular(00.0),
              ),
            ),
            child: Stack(
              children: [
                AnimatedAlign(
                  alignment: Alignment(xAlign, 0),
                  duration: const Duration(milliseconds: 300),
                  child: Container(
                    color: Colors.red,
                    width: width * 0.5,
                    height: 70,
                    child: Container(
                      decoration: const BoxDecoration(
                        // color: Colors.pink,
                        gradient: LinearGradient(
                          colors: [
                            Colors.white,
                            Colors.white,
                            Colors.white,
                            Colors.white,
                            Colors.pink
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          // stops: [0.0, 1.0],
                          // tileMode: TileMode.clamp
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      xAlign = todayAlign;
                      todayColor = selectedColor;
                      tomorrowColor = normalColor;
                      selectedValue = true;
                    });
                  },
                  child: Align(
                    alignment: const Alignment(-1, 0),
                    child: Container(
                      width: width * 0.5,
                      color: Colors.transparent,
                      alignment: Alignment.center,
                      child: RichText(
                        text: TextSpan(
                          text: "Today",
                          style: TextStyle(color: todayColor, fontSize: 15),
                          children: const [
                            TextSpan(
                                text: "    2 Slots",
                                style: TextStyle(color: Colors.green))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      xAlign = signInAlign;
                      tomorrowColor = selectedColor;
                      selectedValue = false;
                      todayColor = normalColor;
                    });
                  },
                  child: Align(
                    alignment: const Alignment(1, 0),
                    child: Container(
                      width: width * 0.5,
                      color: Colors.transparent,
                      alignment: Alignment.center,
                      child: RichText(
                        text: TextSpan(
                          text: "Tomorrow",
                          style: TextStyle(color: tomorrowColor, fontSize: 15),
                          children: const [
                            TextSpan(
                                text: "    3 Slots",
                                style: TextStyle(color: Colors.green))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 20,
          ),
          Expanded(
            child: Container(
              child: selectedValue
                  ? const Text("Today Data")
                  : const Text(" Tomorrow Data"),
            ),
          )
        ],
      ),
    );
  }
}
