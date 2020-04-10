import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:letamind/blocs/game/game_bloc.dart';

class GameScreen extends StatefulWidget {
  GameScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<GameBloc>(context).add(const StartNewGame());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GameBloc, GameState>(
      listener: (BuildContext context, GameState state) {
        // if (state is SettingsSaved) {
        //   Navigator.pushReplacementNamed(context, 'game');
        // }
      },
      child: BlocBuilder<GameBloc, GameState>(
          builder: (BuildContext context, GameState state) {
        // if (state.settings == null) {
        //   return const Center(child: CircularProgressIndicator());
        // }

        return Scaffold(
            appBar: AppBar(
              title: Text('Guess the word'),
            ),
            body: Center());
      }),
    );
  }
}
