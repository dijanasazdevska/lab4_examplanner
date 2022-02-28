import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab4_examplanner/blocs/planner_event.dart';
import '../blocs/planner_bloc.dart';
import '../blocs/planner_state.dart';

class LoginScreen extends StatelessWidget{

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _submitData(BuildContext ctx) async {
    if (_usernameController.text.isEmpty) {
      return;
    }
    final username = _usernameController.text;
    final password = _passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      return;
    }
    final bloc = BlocProvider.of<PlannerBloc>(ctx);
    bloc.add(PlannerUserLoginEvent(username, password));
    if(bloc.state is! PlannerNoUserState){
      bloc.add(PlannerListInitializedEvent());
      SchedulerBinding.instance!.addPostFrameCallback((_) {
        Navigator.of(ctx).popAndPushNamed("/home");
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlannerBloc, PlannerState>(builder: (context, state){
      return Scaffold(appBar: AppBar(title: Text("Login")),
      body: Container(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          TextField(
            controller: _usernameController,
            decoration: InputDecoration(labelText: "Username"),
            onSubmitted: (_) => _submitData(context),
          ),
          TextField(
            controller: _passwordController,
            decoration: InputDecoration(labelText: "Password"),
            obscureText: true,
            onSubmitted: (_) => _submitData(context),
          ),
          FlatButton(
            child: Text("Login"),
            onPressed: () => _submitData(context),
          ),
        ],
      ),
    ));
  });
  
}
}