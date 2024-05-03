import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var paswordText = TextEditingController();

  String genpassword = "";

  List<int> lenList = [
    0,
    6,
    8,
    10,
    12,
    16,
  ];
  int? passLength = 0;

  String? strength;

  String isStrength(String genpassword) {
    if (genpassword.length < 6) {
      return "";
    } else if (genpassword.length == 6) {
      return "weak password";
    } else if (genpassword.length > 6 && genpassword.length <= 10) {
      return "average password";
    }

    return "strong password";
  }

  Color isColor() {
    if (genpassword.length < 6) {
      return Colors.red;
    } else if (genpassword.length == 6) {
      return Colors.orange;
    } else if (genpassword.length > 6 && genpassword.length <= 10) {
      return Colors.amber;
    }

    return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "PASSWORD GENERATOR",
            style:
                TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: SizedBox(
            height: 600,
          
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 200,
                  width: 200,
                  child: 
                  
                  ImageIcon(
                      color: Colors.teal,
                      AssetImage('lib/assets/images/security.png')),
                ),
                SizedBox(
                  height: 25,
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        const Text(
                          "Password length :",
                          style: TextStyle(fontSize: 16),
                        ),
                        DropdownButton(
                          value: passLength,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: lenList.map((int items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text("$items"),
                            );
                          }).toList(),
                          onChanged: (int? newValue) {
                            setState(() {
                              passLength = newValue!;
                            });
                          },
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => generatePassword(passLength!),
                      child: Container(
                        height: 50,
                        width: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.green),
                        child: const Center(
                            child: Text(
                          "Generate",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        )),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Container(
                    height: 60,
                    width: MediaQuery.sizeOf(context).width - 50,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      title: genpassword == ""
                          ? RichText(
                              text: const TextSpan(children: [
                                TextSpan(
                                    text: "To generate password click ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        color: Colors.grey,
                                        fontSize: 18)),
                                TextSpan(
                                    text: "Generate",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 18))
                              ]),
                            )
                          : Text(
                              genpassword,
                              style: const TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                      trailing: InkWell(
                        onTap: () async {
                          await Clipboard.setData(
                                  ClipboardData(text: genpassword))
                              .then((value) => ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                      backgroundColor: Colors.blue,
                                      content: Text("Copied to clipboard"))));
                        },
                        child: const ImageIcon(
                            AssetImage('lib/assets/images/copy.png')),
                      ),
                    )),
                Text(
                  isStrength(
                    genpassword,
                  ),
                  style: TextStyle(
                      color: isColor(),
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ));
  }

  generatePassword(int input) {
    String result = "";

    Random random = Random();

    const value =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#\$%^&*_+';

    for (int i = 0; i < input; i++) {
      result += value[random.nextInt(value.length)];
    }
    setState(() {
      genpassword = result;
    });
  }
}
