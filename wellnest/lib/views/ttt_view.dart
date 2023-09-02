import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';


class TTTPage extends StatefulWidget {
  const TTTPage({super.key});

  @override
  State<TTTPage> createState() => _TTTPageState();
}

class _TTTPageState extends State<TTTPage> {
  static const String PLAYER_X = 'X';
  static const String PLAYER_O = 'O';

  late String currentPlayer;
  late bool gameEnd;
  late List<String> occupied;
  bool isHardMode = false;
  @override
  void initState() {
    initializeGame();
    super.initState();
  }

  void initializeGame() {
    currentPlayer = PLAYER_X;
    gameEnd = false;
    occupied = List<String>.filled(9, '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFCACC),
        title: const Text("Tic Tac Toe"),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                initializeGame();
              });
            },
            icon: const Icon(Icons.restart_alt),
          ),
          CupertinoSegmentedControl(
                children: const {
                  false: Text(' Easy '),
                  true: Text(' Hard '),
                },
                groupValue: isHardMode,
                onValueChanged: (value) {
                  setState(() {
                    isHardMode = !isHardMode;
                  });
                },
              ),
          
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _headerText(),
            _gameContainer(),
          ],
        ),
      ),
    );
  }

  Widget _headerText() {
    return Column(
      children: [
        const Text(
          "Tic Tac Toe",
          style: TextStyle(
            color: Colors.black87,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        currentPlayer == PLAYER_X ? const Text(
          "Your turn",
          style: TextStyle(
            color: Colors.blueGrey,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ) : const Text(
          "Computer's turn",
          style: TextStyle(
            color: Colors.blueGrey,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }

  Widget _gameContainer() {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      width: MediaQuery.of(context).size.width / 2,
      margin: const EdgeInsets.all(8),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemCount: 9,
        itemBuilder: (context, int index) {
          return _box(index);
        },
      ),
    );
  }

  Widget _box(int index) {
    return InkWell(
      onTap: () {
        if (gameEnd || occupied[index].isNotEmpty || currentPlayer == PLAYER_O) {
          return;
        }
        setState(() {
          occupied[index] = currentPlayer;
          checkForWinner();
          checkForDraw();
          if (!gameEnd) {
            changeTurn();
            if (currentPlayer == PLAYER_O && (isHardMode || !isHardMode)) {
              Future.delayed(const Duration(seconds: 1), () {
      _makeComputerMove();
    });
              
            }
          }
        });
      },
      child: Container(
        color: occupied[index].isEmpty
            ? Colors.black12
            : occupied[index] == PLAYER_X
                ? Colors.red.shade100
                : Colors.blue.shade100,
        margin: const EdgeInsets.all(8),
        child: Center(
          child: Text(
            occupied[index],
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }

  void changeTurn() {
    currentPlayer = currentPlayer == PLAYER_X ? PLAYER_O : PLAYER_X;
  }

  void checkForWinner() {
    List<List<int>> winningList = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var winningPos in winningList) {
      String playerPosition0 = occupied[winningPos[0]];
      String playerPosition1 = occupied[winningPos[1]];
      String playerPosition2 = occupied[winningPos[2]];

      if (playerPosition0.isNotEmpty &&
          playerPosition0 == playerPosition1 &&
          playerPosition0 == playerPosition2) {
            if (playerPosition1 == PLAYER_X){
              showGameOverMessage("You Won");
            }
            else{
              showGameOverMessage("Computer Won");
            }
        
        gameEnd = true;
        break;
      }
    }
  }

  void checkForDraw() {
    if (!gameEnd && occupied.every((element) => element.isNotEmpty)) {
      showGameOverMessage("Draw");
      gameEnd = true;
    }
  }

  void showGameOverMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green.shade100,
        content: Text(
          "Game Over\n$message",
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  void _makeComputerMove() {
    if (isHardMode) {
      int bestMove = _findBestMove();
      if (bestMove != -1) {
        occupied[bestMove] = PLAYER_O;
        setState(() {
          checkForWinner();
          checkForDraw();
          changeTurn();
        });
      }
    } else {
      // For easy mode, choose a random empty cell
      List<int> emptyCells = [];
      for (int i = 0; i < occupied.length; i++) {
        if (occupied[i].isEmpty) {
          emptyCells.add(i);
        }
      }

      if (emptyCells.isNotEmpty) {
        int randomIndex = emptyCells[Random().nextInt(emptyCells.length)];
        occupied[randomIndex] = PLAYER_O;
        setState(() {
          checkForWinner();
          checkForDraw();
          changeTurn();
        });
      }
    }
  }

  int _findBestMove() {
    int bestMove = -1;
    int bestScore = -1000;

    for (int i = 0; i < 9; i++) {
      if (occupied[i].isEmpty) {
        occupied[i] = PLAYER_O;

        int score = _minimax(occupied, 0, false);

        occupied[i] = '';

        if (score > bestScore) {
          bestScore = score;
          bestMove = i;
        }
      }
    }

    return bestMove;
  }

  int _minimax(List<String> board, int depth, bool isMaximizing) {
    int score = _evaluate(board);

    if (score == 10) {
      return score - depth;
    }

    if (score == -10) {
      return score + depth;
    }

    if (!board.contains('')) {
      return 0;
    }

    if (isMaximizing) {
      int bestScore = -1000;

      for (int i = 0; i < 9; i++) {
        if (board[i].isEmpty) {
          board[i] = PLAYER_O;
          bestScore = max(bestScore, _minimax(board, depth + 1, !isMaximizing));
          board[i] = '';
        }
      }

      return bestScore;
    } else {
      int bestScore = 1000;

      for (int i = 0; i < 9; i++) {
        if (board[i].isEmpty) {
          board[i] = PLAYER_X;
          bestScore = min(bestScore, _minimax(board, depth + 1, !isMaximizing));
          board[i] = '';
        }
      }

      return bestScore;
    }
  }

  int _evaluate(List<String> board) {
    List<List<int>> winningList = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var winningPos in winningList) {
      String playerPosition0 = board[winningPos[0]];
      String playerPosition1 = board[winningPos[1]];
      String playerPosition2 = board[winningPos[2]];

      if (playerPosition0.isNotEmpty &&
          playerPosition0 == playerPosition1 &&
          playerPosition0 == playerPosition2) {
        if (playerPosition0 == PLAYER_O) {
          return 10;
        } else {
          return -10;
        }
      }
    }

    return 0;
  }
}

 

