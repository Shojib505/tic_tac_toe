import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tic_tac_toe/custom_dailog.dart';
import 'package:tic_tac_toe/game_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<GameButton> buttonsList;
  var player1;
  var player2;
  var activePlayer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    buttonsList=doInit();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tic Tac Toe"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children:<Widget> [
          Expanded(
              child: GridView.builder(
                  padding: EdgeInsets.all(10.0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1.0,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                  ),
                  itemCount: buttonsList.length,
                  itemBuilder: (context,i)=> SizedBox(
                    width: 100.0,
                    height: 100.0,
                    child: RaisedButton(
                      padding: EdgeInsets.all(8.0),
                      onPressed: buttonsList[i].enabled ? ()=> playGame(buttonsList[i]): null,
                      child: Text(
                        buttonsList[i].text,
                        textSt
                      ),
                    )
                    //ElevatedButton(
                    //   onPressed: () {  }, child: null,
                    //
                    //),
                  )
              )
          )
        ],
      ),
    );
  }

  List<GameButton> doInit(){
    player1 = [];
    player2 = [];
    activePlayer=1;

    var allGamesButton=[
      GameButton(id: 1),
      GameButton(id: 2),
      GameButton(id: 3),
      GameButton(id: 4),
      GameButton(id: 5),
      GameButton(id: 6),
      GameButton(id: 7),
      GameButton(id: 8),
      GameButton(id: 9),
    ];
    return allGamesButton;
  }

  void playGame(GameButton gb){
    setState(() {
      if(activePlayer==1){
        gb.text="X";
        gb.bg= Colors.red;
        activePlayer = 2;
        player1.add(gb.id);
      }else{
        gb.text="0";
        gb.bg=Colors.black;
        activePlayer=1;
        player2.add(gb.id);
      }
      gb.enabled=false;
      int winner= checkWinner();
      if(winner == -1){
        if(buttonsList.every((element) => element.text !="")){
          showDialog(
              context: context,
              builder: (context)=> CustomDialog("Game Tied","Press The Reset Button To Start Again",resetGame)
          );
        }else{
          activePlayer == 2? autoPlay(): null;
        }
      }
    });
  }







  int checkWinner(){
    var winner = -1;

    if(player1.contains(1)&&player1.contains(2)&&player1.contains(3)){
      winner = 1;
    }
    if(player2.contians(1)&&player2.contians(2)&&player2.contians(3)){
      winner =2;
    }

    if(player1.contians(4)&&player2.contians(5)&&player2.contians(6)){
      winner =1;
    }
    if(player2.contians(4)&&player2.contians(5)&&player2.contians(6)){
      winner =2;
    }

    if(player1.contians(7)&&player1.contians(8)&&player1.contians(9)){
      winner =2;
    }
    if(player2.contians(7)&&player2.contians(8)&&player2.contians(9)){
      winner =2;
    }


    if(player1.contians(1)&&player1.contians(5)&&player1.contians(9)){
      winner =1;
    }
    if(player2.contians(1)&&player2.contians(5)&&player2.contians(9)){
      winner =2;
    }


    if(player1.contians(3)&&player1.contians(5)&&player1.contians(7)){
      winner =2;
    }
    if(player2.contians(3)&&player2.contians(5)&&player2.contians(7)){
      winner =2;
    }


    if(winner!=-1){
      if(winner==1){
        showDialog(
          context: context,
          builder: (_) => CustomDialog('Player 1 Won','Press The Reset Button To Start Again',resetGame)
        );
      }else{
        showDialog(
            context: context,
            builder: (_) => CustomDialog('Player 2 Won','Press The Reset Button To Start Again',resetGame)
        );
      }
    }
    return winner;
  }

  void resetGame(){
    if(Navigator.canPop(context)){
      Navigator.pop(context);
      setState(() {
        buttonsList =doInit();
      });
    }
  }

  void autoPlay(){
    var emptyCells = [];
    var list = new List.generate(9, (index) => index+1);
    for(var cellID in list){
      if(!(player1.contains(cellID)||player2.contains(cellID))){
        emptyCells.add(cellID);
      }
    }
    var random = Random();
    var randomIndex= random.nextInt(emptyCells.length-1);
    var cellValue= emptyCells[randomIndex];
    int i = buttonsList.indexWhere((element) => element.id==cellValue);
    playGame(buttonsList[i]);
  }
}