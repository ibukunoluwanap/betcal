import 'package:betcal/ui/utils/color.dart';
import 'package:betcal/ui/utils/input.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController homePPG = TextEditingController();
  final TextEditingController awayPPG = TextEditingController();

  final TextEditingController home5th = TextEditingController();
  final TextEditingController away5th = TextEditingController();
  final TextEditingController home4th = TextEditingController();
  final TextEditingController away4th = TextEditingController();
  final TextEditingController home3rd = TextEditingController();
  final TextEditingController away3rd = TextEditingController();
  final TextEditingController home2nd = TextEditingController();
  final TextEditingController away2nd = TextEditingController();
  final TextEditingController home1st = TextEditingController();
  final TextEditingController away1st = TextEditingController();

  bool done = false;

  @override
  Widget build(BuildContext context) {
    final dWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: const Text("Bet Cal")),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            Container(
              width: dWidth,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: primary,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Meaning Of Terms",
                    style: TextStyle(
                      fontSize: 16,
                      color: primary,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Flexible(
                        child: Text(
                          "PPG:",
                          style: TextStyle(
                            fontSize: 14,
                            color: primary,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Flexible(
                        child: Text(
                          "Points Per Game",
                          style: TextStyle(
                            fontSize: 14,
                            color: primary,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              "Team Stats",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 20),
            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please Enter Home PPG";
                            }
                            return null;
                          },
                          controller: homePPG,
                          decoration: const Input(
                            labelText: "Home PPG",
                            hintText: "Home Team Points Per Game",
                            color: primary,
                          ).decoration(),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please Enter Away PPG";
                            }
                            return null;
                          },
                          controller: awayPPG,
                          decoration: const Input(
                            labelText: "Away PPG",
                            hintText: "Away Team Points Per Game",
                            color: primary,
                          ).decoration(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "Team Last Five Games Points",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Home",
                        style: TextStyle(fontSize: 16, color: primary),
                      ),
                      Text(
                        "Away",
                        style: TextStyle(fontSize: 16, color: primary),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Home Last 5th";
                            }
                            return null;
                          },
                          controller: home5th,
                          decoration: const Input(
                            labelText: "Last 5th Game",
                            hintText: "Home Last 5th Game",
                            color: primary,
                          ).decoration(),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Away Last 5th";
                            }
                            return null;
                          },
                          controller: away5th,
                          decoration: const Input(
                            labelText: "Last 5th Game",
                            hintText: "Away Last 5th Game",
                            color: primary,
                          ).decoration(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Home Last 4th";
                            }
                            return null;
                          },
                          controller: home4th,
                          decoration: const Input(
                            labelText: "Last 4th Game",
                            hintText: "Home Last 4th Game",
                            color: primary,
                          ).decoration(),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Away Last 4th";
                            }
                            return null;
                          },
                          controller: away4th,
                          decoration: const Input(
                            labelText: "Last 4th Game",
                            hintText: "Away Last 4th Game",
                            color: primary,
                          ).decoration(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Home Last 3rd";
                            }
                            return null;
                          },
                          controller: home3rd,
                          decoration: const Input(
                            labelText: "Last 3rd Game",
                            hintText: "Home Last 3rd Game",
                            color: primary,
                          ).decoration(),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Away Last 3rd";
                            }
                            return null;
                          },
                          controller: away3rd,
                          decoration: const Input(
                            labelText: "Last 3rd Game",
                            hintText: "Away Last 3rd Game",
                            color: primary,
                          ).decoration(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Home Last 2nd";
                            }
                            return null;
                          },
                          controller: home2nd,
                          decoration: const Input(
                            labelText: "Last 2nd Game",
                            hintText: "Home Last 2nd Game",
                            color: primary,
                          ).decoration(),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Away Last 2nd";
                            }
                            return null;
                          },
                          controller: away2nd,
                          decoration: const Input(
                            labelText: "Last 2nd Game",
                            hintText: "Away Last 2nd Game",
                            color: primary,
                          ).decoration(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Home Last 1st";
                            }
                            return null;
                          },
                          controller: home1st,
                          decoration: const Input(
                            labelText: "Last 1st Game",
                            hintText: "Home Last 1st Game",
                            color: primary,
                          ).decoration(),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Away Last 1st";
                            }
                            return null;
                          },
                          controller: away1st,
                          decoration: const Input(
                            labelText: "Last 1st Game",
                            hintText: "Away Last 1st Game",
                            color: primary,
                          ).decoration(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: done
          ? FloatingActionButton(
              onPressed: clearForm,
              tooltip: "Clear form",
              child: const Icon(Icons.cancel),
            )
          : FloatingActionButton(
              onPressed: calFAvg,
              tooltip: "Final Average",
              child: const Icon(Icons.calculate_rounded),
            ),
    );
  }

  clearForm() {
    formKey.currentState!.reset();
    homePPG.clear();
    awayPPG.clear();
    home1st.clear();
    home2nd.clear();
    home3rd.clear();
    home4th.clear();
    home5th.clear();
    away1st.clear();
    away2nd.clear();
    away3rd.clear();
    away4th.clear();
    away5th.clear();
  }

  calFAvg() {
    if (isFormValidated()) {
      // calculate PPG sum & avg
      double sumPPG = double.parse(homePPG.text) + double.parse(awayPPG.text);
      double avgPPG = sumPPG / 2;

      // calculate last 5 games
      double homeSumLast = double.parse(home1st.text) +
          double.parse(home2nd.text) +
          double.parse(home3rd.text) +
          double.parse(home4th.text) +
          double.parse(home5th.text);

      double awaySumLast = double.parse(away1st.text) +
          double.parse(away2nd.text) +
          double.parse(away3rd.text) +
          double.parse(away4th.text) +
          double.parse(away5th.text);

      double homeAvg = homeSumLast / 5;
      double awayAvg = awaySumLast / 5;

      double lastSum = homeAvg + awayAvg;

      double fAvg = (sumPPG + lastSum) / 2;

      showResult(sumPPG, avgPPG, homeAvg, awayAvg, lastSum, fAvg);
      setState(() => done = true);
    }
  }

  Future<void> showResult(
    sumPPG,
    avgPPG,
    homeAvg,
    awayAvg,
    lastSum,
    fAvg,
  ) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          insetPadding: EdgeInsets.zero,
          title: const Text("Result"),
          content: Builder(builder: (context) {
            var width = MediaQuery.of(context).size.width;

            return SizedBox(
              width: width - 100,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text(
                          "PPG Sum:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 10),
                        Text("$sumPPG"),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Text(
                          "PPG Average:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 10),
                        Text("$avgPPG"),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Text(
                          "Home Average:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 10),
                        Text("$homeAvg"),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Text(
                          "Away Average:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 10),
                        Text("$awayAvg"),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Text(
                          "Last 5 games sum:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 10),
                        Text("$lastSum"),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Text(
                          "Final Average:",
                          style: TextStyle(
                            fontSize: 20,
                            color: primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "$fAvg",
                          style: const TextStyle(
                            fontSize: 24,
                            color: primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
          actions: [
            TextButton(
              child: const Text('Close'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  bool isFormValidated() {
    final form = formKey.currentState;
    if (form != null && form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
