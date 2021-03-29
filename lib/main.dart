import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'User Registration Form';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        backgroundColor: Color(0xff84FFFF),
        appBar: AppBar(
          title: Text(appTitle),
          backgroundColor: Colors.blueGrey,
        ),
        body: MyCustomForm(),
      ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  var passKey = GlobalKey<FormFieldState>();
  var pwd;
  var validateDob;
  TextEditingController dateCtl = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: 'Name'),
            validator: (value) {
              if (value.isEmpty ||
                  RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(value)) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'email'),
            validator: (value) {
              if (value.isEmpty ||
                  !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value)) {
                return 'Enter a valid email id';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'User name'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter your initials or nick name';
              }
              return null;
            },
          ),
          TextFormField(
            readOnly: true,
            controller: dateCtl,
            decoration: InputDecoration(
              labelText: "Date of birth",
              hintText: "Click/Tap here and insert your DOB",
            ),
            //validator: validateDob,
            //onSaved: (String val) {},
            onTap: () async {
              DateTime date = DateTime(1900);
              FocusScope.of(context).requestFocus(new FocusNode());

              date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100));

              dateCtl.text = date.toIso8601String();
            },
          ),
          /*InkWell(
            onTap: () {
              _selectDate(); // Call Function that has showDatePicker()
            },
            child: IgnorePointer(
              child: new TextFormField(
                decoration: new InputDecoration(hintText: 'DOB'),
                maxLength: 10,
                validator: validateDob,
                onSaved: (String val) {},
              ),
            ),
          ),  */
          TextFormField(
            controller: _pass,
            key: passKey,
            decoration: InputDecoration(labelText: 'Password'),
            obscureText: true,
            validator: (value) {
              //var pwd = value;
              if (value.isEmpty) {
                return 'Please enter a combination of letters, numbers and symbols';
              }
              return null;
            },
          ),
          TextFormField(
              controller: _confirmPass,
              decoration: InputDecoration(labelText: 'Confirm Password'),
              obscureText: true,
              validator: (value) {
                if (value.isEmpty) return 'Empty';
                if (value != _pass.text) return 'Not Match';
                return null;
              }
              //_form.currentState.validate()
              ),
          TextFormField(
            decoration: InputDecoration(labelText: 'City'),
            validator: (value) {
              if (value.isEmpty ||
                  RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(value)) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'State'),
            validator: (value) {
              if (value.isEmpty ||
                  RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(value)) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Country'),
            validator: (value) {
              if (value.isEmpty ||
                  RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(value)) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false
                // otherwise.
                if (_formKey.currentState.validate()) {
                  // If the form is valid, display a Snackbar.
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Thank you, Check your email')));
                }
              },
              child: Text('Submit'),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.orange),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
