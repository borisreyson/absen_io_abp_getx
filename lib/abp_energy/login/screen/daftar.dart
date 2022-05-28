// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class Daftar extends StatefulWidget {
  const Daftar({Key? key}) : super(key: key);

  @override
  State<Daftar> createState() => _DaftarState();
}

class _DaftarState extends State<Daftar> {
  final _formKey = GlobalKey<FormState>();
  late FocusNode _usernameFocus, _passwordFocus;
  late String _username, _password;
  bool _passwordVisible = true;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final RoundedLoadingButtonController _roundedController =
      RoundedLoadingButtonController();
      @override
  void initState() {
    _passwordVisible = true;
    _usernameFocus = FocusNode();
    _passwordFocus = FocusNode();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white
            )),
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 159, 97, 9),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          child:  ListView(
            children: [
            Center(
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                margin: const EdgeInsets.all(20),
                elevation: 20,
                child: const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: ClipRect(
                    
                    child: Image(
                      image: AssetImage('assets/images/ic_abp.png'),height: 70,
                      )
                      ),
                )
                    )
                    ,),
              Card(
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    focusNode: _usernameFocus,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(color: Color.fromARGB(255, 159, 97, 9)
                      ),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 159, 97, 9))),
                      border:  OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 159, 97, 9))),
                      labelText: "Username / NIK"),
                      
                        
                    onSaved: (value) {
                      _username = value!;
                    },
                    onFieldSubmitted: (term) {
                      _usernameFocus.unfocus();
                      FocusScope.of(context).requestFocus(_passwordFocus);
                    },
                    validator: (value) {
                      final isValidateUsername = RegExp(r'^[a-zA-Z0-9]*$');
                      if (value!.isEmpty) {
                        return 'Username Wajib Di Isi';
                      } else if (!isValidateUsername.hasMatch(value)) {
                        return 'Only letters are allowed';
                      }
                      return null;
                    },
                    controller: _usernameController,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Card(
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    focusNode: _passwordFocus,
                    obscureText: _passwordVisible,
                    textInputAction: TextInputAction.go,
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 159, 97, 9))),
                        border:  const OutlineInputBorder(),
                        focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 159, 97, 9))),
                        labelText: "Password",
                        hintText: "Password",
                        labelStyle: const TextStyle(color: Color.fromARGB(255, 159, 97, 9)
                      ),
                        suffixIcon: IconButton(
                            icon: _passwordVisible
                                ? const Icon(Icons.visibility_off,color: Color.fromARGB(255, 159, 97, 9))
                                : const Icon(Icons.visibility,color: Color.fromARGB(255, 159, 97, 9)),
                            onPressed: () {
                              _passwordFocus.unfocus();
                              // toggleVisible();
                            })),
                    onSaved: (value) {
                      _password = value!;
                    },
                    onFieldSubmitted: (term) {
                      _passwordFocus.unfocus();
                      // _onLogin(context);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password Wajib Di Isi';
                      }
                      return null;
                    },
                    controller: _passwordController,
                  ),
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              RoundedLoadingButton(
                valueColor: const Color.fromARGB(255, 159, 97, 9),
                elevation: 10,
                color: Colors.white,
                  controller: _roundedController,
                  onPressed: () {
                    _roundedController.start();
                    // _onLogin(context);
                  },
                  child: const Text(
                    "Daftar",
                    style: TextStyle(
                      color: Color.fromARGB(255, 159, 97, 9),
                      fontSize: 24,
                    ),
                  )),
            ],
          ),),
      ),
      backgroundColor: const Color.fromARGB(255, 159, 97, 9),
    );
  }
}
