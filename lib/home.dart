import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool oTurn = true;
  List<String> ele = ['', '', '', '', '', '', '', '', ''];
  int oScore = 0;
  int xScore = 0;
  int fb = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.indigo[900],
        appBar: AppBar(
          backgroundColor: Colors.indigo[900],
          title: Text("Tic Tac Toe"),
        ),
        body: Column(
          children: [
            Container(
              height: 120,
              color: Colors.indigo.shade500,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "SCORE BOARD",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold,fontSize: 25),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Player X',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Text(
                            xScore.toString(),
                            style: TextStyle(
                                fontSize: 20, color: Colors.white),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Player O',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                          Text(
                            oScore.toString(),
                            style: TextStyle(
                                fontSize: 20, color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 90,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                    itemCount: 9,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (oTurn && ele[index] == '') {
                              ele[index] = 'O';
                              fb++;
                            } else if (!oTurn && ele[index] == '') {
                              ele[index] = 'X';
                              fb++;
                            }
                            oTurn = !oTurn;
                            Winner();
                          });
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white)),
                          child: Center(
                            child: Text(
                              ele[index],
                              style:
                                  TextStyle(color: Colors.white, fontSize: 35),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
            SizedBox(
              height: 90,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        xScore = 0;
                        oScore = 0;
                        for (int i = 0; i < 9; i++) {
                          ele[i] = '';
                        }
                      });
                      fb = 0;
                    },
                    child: Text("Clear Score Board"),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.indigo.shade500)),
                  ),
                  ElevatedButton(
                    child: Text("Play Again"),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.indigo.shade500),
                    ),
                    onPressed: () {
                      setState(() {
                        for (int i = 0; i < 9; i++) {
                          ele[i] = '';
                        }
                      });
                      fb = 0;
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void Winner() {
    // Checking rows
    if (ele[0] == ele[1] && ele[0] == ele[2] && ele[0] != '') {
      Windialog(ele[0]);
    }
    if (ele[3] == ele[4] && ele[3] == ele[5] && ele[3] != '') {
      Windialog(ele[3]);
    }
    if (ele[6] == ele[7] && ele[6] == ele[8] && ele[6] != '') {
      Windialog(ele[6]);
    }

    // Checking Column
    if (ele[0] == ele[3] && ele[0] == ele[6] && ele[0] != '') {
      Windialog(ele[0]);
    }
    if (ele[1] == ele[4] && ele[1] == ele[7] && ele[1] != '') {
      Windialog(ele[1]);
    }
    if (ele[2] == ele[5] && ele[2] == ele[8] && ele[2] != '') {
      Windialog(ele[2]);
    }

    // Checking Diagonal
    if (ele[0] == ele[4] && ele[0] == ele[8] && ele[0] != '') {
      Windialog(ele[0]);
    }
    if (ele[2] == ele[4] && ele[2] == ele[6] && ele[2] != '') {
      Windialog(ele[2]);
    } else if (fb == 9) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Draw"),
              actions: [
                ElevatedButton(
                  child: Text("Play Again"),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.indigo.shade900),
                  ),
                  onPressed: () {
                    setState(() {
                      for (int i = 0; i < 9; i++) {
                        ele[i] = '';
                      }
                    });
                    fb = 0;
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    }
  }

  void Windialog(String winner) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("\" " + winner + " \" is Winner !!!"),
            actions: [
              ElevatedButton(
                child: Text("Play Again"),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.indigo.shade900)),
                onPressed: () {
                  setState(() {
                    for (int i = 0; i < 9; i++) {
                      ele[i] = '';
                    }
                  });

                  fb = 0;
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });

    if (winner == 'O') {
      oScore++;
    } else if (winner == 'X') {
      xScore++;
    }
  }
}
