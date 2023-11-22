import 'package:flutter/material.dart';
import 'DialogBox.dart';
import 'Authentication.dart';

class LoginRegisterPage extends StatefulWidget
{
  LoginRegisterPage({
    required this.auth,
    required this.onSignedIn,

  });
  final AuthImplementation auth;
  final VoidCallback onSignedIn;
  State<StatefulWidget> createState()
  {
    return _LoginRegisterState();
  }

}

enum FormType
{
  login,
  register
}

class _LoginRegisterState extends State<LoginRegisterPage>
{

  DialogBox dialogBox = new DialogBox();

  final formKey = new GlobalKey<FormState>();
  FormType _formType = FormType.login;
  String _email = "";
  String _password =""; 
  //methods
  bool validateAndSave()
  {
    final form = formKey.currentState;

    if(form!.validate())
    {
      form.save();
      return true;
    }
    else
    {
      return false;
    }

  }

  void validateAndSubmit() async
  {
    if(validateAndSave())
    {
      try
      {
        if(_formType == FormType.login)
        {
          String? userId = await widget.auth.SignIn(_email, _password);
          dialogBox.information(context, "Congratulations", "you are logged in successfully.");
          print("login userId = " + userId!);
        }
        else
        {
          String? userId = await widget.auth.SignUp(_email, _password);
          dialogBox.information(context, "Congratulations", "your account has been created successfully.");
          print("Register userId = " + userId!);
        }

        widget.onSignedIn();
      }
      catch(e)
      {
        dialogBox.information(context, "Error", e.toString());
        print("Error = " + e.toString());
      }
    }
  }

  void moveToRegister()
  {

    formKey.currentState?.reset();

    setState(()
    {
      _formType = FormType.register;
    }
    );
  }
  void moveToLogin()
  {

    formKey.currentState?.reset();

    setState(()
    {
      _formType = FormType.login;
    }
    );
  }



  //design
  @override
  Widget build(BuildContext context) 
  {
    return new Scaffold
    (
      appBar: new AppBar(
        title: new Text("Anonymous Blog"),
      ),
      body: new Container
      (
        margin: EdgeInsets.all(15.0),

        child: new Form
        (
          key: formKey,
          child: new Column
          (
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: createInputs() + createButtons(),
          )
        )
      )
    );
  }


  List<Widget> createInputs()
  {
    return
    [
      SizedBox(height: 10.0,),
      logo(),
      SizedBox(height: 20.0,),

      // ignore: unnecessary_new
      new TextFormField
      (
        decoration:new InputDecoration(labelText: 'Email'),

        validator: (value)
        {
          return value!.isEmpty ? 'Email is required.': null;
        },
        onSaved: (value)
        {
         _email = value!;
        },

      ),

      SizedBox(height: 10.0,),

      new TextFormField
      (
        decoration: new InputDecoration(labelText: 'Password'),
        obscureText: true,
        validator: (value)
        {
          return value!.isEmpty ? 'Password is required.': null;
        },
        onSaved: (value)
        {
         _password = value!;
        },
        //decoration: new InputDecoration(labelText: 'Password'),
      ),

      SizedBox(height: 20.0,),

    ];
  }

  Widget logo()
  {
    return new Hero
    (
      tag: 'hero',
      child: new CircleAvatar
      (
        backgroundColor: Colors.transparent,
        radius: 110.0,
        child: Image.asset('assets/user.png'),
      ),
    );
  }


  List<Widget> createButtons()
  {
    if(_formType == FormType.login)
    {
      return
    [
      // ignore: unnecessary_new
      new ElevatedButton
      (
        onPressed: validateAndSubmit,
        child: new Text("Login", style: new TextStyle(fontSize: 20.0)),
      ),

      new TextButton
      (
        child: new Text("Don't have an account? Create Account", style: new TextStyle(fontSize: 20.0)),
        onPressed: moveToRegister,
      ),
    ];

    }
    else
    {
      return
    [
      // ignore: unnecessary_new
      new ElevatedButton
      (
        onPressed: validateAndSubmit,
        child: new Text("Create Account", style: new TextStyle(fontSize: 20.0)),
      ),

      new TextButton
      (
        child: new Text("Already have an account? Login", style: new TextStyle(fontSize: 20.0)),
        onPressed: moveToLogin,
      ),
    ];
    }
  }


}