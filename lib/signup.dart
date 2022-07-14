import 'package:flutter/material.dart';
import 'package:naulan_tugas_678/authentication.dart';
import 'package:naulan_tugas_678/home.dart';

class Signup extends StatelessWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          SizedBox(height: 80),
          Column(
            children: [
              Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Image.network(
                      'https://utter.academy/uploads/system/logo-dark.png')),
            ],
          ),
          SizedBox(height: 50),
          Text(
            'Selamat Datang!',
            style: TextStyle(fontSize: 24),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SignupForm(),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  child: Row(
                    children: <Widget>[
                      SizedBox(width: 80),
                      Text('Punya Akun?',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text('Berhasil Log In!!',
                            style: TextStyle(fontSize: 18, color: Colors.blue)),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container buildLogo() {
    return Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.blue),
      child: Center(
        child: Text(
          "T",
          style: TextStyle(color: Colors.white, fontSize: 60.0),
        ),
      ),
    );
  }
}

class SignupForm extends StatefulWidget {
  SignupForm({Key? key}) : super(key: key);
  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  String? name;

  bool _obscureText = false;
  bool agree = false;
  final pass = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    var _border = OutlineInputBorder(
      borderRadius: BorderRadius.all(
        const Radius.circular(100.0),
      ),
    );

    var space = SizedBox(height: 10);
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.email_outlined),
                labelText: 'Email',
                border: _border),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Mohon Masukkan Email Anda';
              }
              return null;
            },
            onSaved: (val) {
              email = val;
            },
            keyboardType: TextInputType.emailAddress,
          ),
          space,
          TextFormField(
            controller: pass,
            obscureText: !_obscureText,
            decoration: InputDecoration(
              labelText: 'Password',
              prefixIcon: Icon(Icons.lock_outline),
              border: _border,
              suffixIcon: GestureDetector(
                child: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                ),
                onTap: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              ),
            ),
            onSaved: (val) {
              password = val;
            },
            validator: (value) {
              if (value!.isEmpty) {
                return 'Mohon Masukkan Password Anda';
              } else if (value.length < 6) {
                return 'Password Anda Terlalu Pendek';
              }
              return null;
            },
          ),
          space,
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Konfirmasi Password Anda',
              prefixIcon: Icon(Icons.lock_outline),
              border: _border,
            ),
            obscureText: true,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Mohon Masukkan Ulang Password Anda';
              } else if (value.length < 6) {
                return 'Password Anda Terlalu Pendek';
              }
              return null;
            },
          ),
          space,
          TextFormField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.account_circle),
                labelText: 'Nama Lengkap',
                border: _border),
            onSaved: (val) {
              name = val;
            },
            validator: (value) {
              if (value!.isEmpty) {
                return 'Mohon Masukkan Nama Lengkap Anda';
              }
              return null;
            },
          ),
          Row(
            children: <Widget>[
              Checkbox(
                onChanged: (value) {
                  setState(() {
                    agree = !agree;
                  });
                },
                value: agree,
              ),
              Flexible(
                child: Text(
                    'By Creating Account, I Agree To Terms & Conditions And Privacy Policy.'),
              ),
            ],
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 50,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  AuthenticationHelper()
                      .signUp(email: email!, password: password!)
                      .then((result) {
                    if (result == null) {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => HomeList()));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          result,
                          style: TextStyle(fontSize: 16),
                        ),
                      ));
                    }
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(24.0)))),
              child: Text(
                'Sign Up',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
