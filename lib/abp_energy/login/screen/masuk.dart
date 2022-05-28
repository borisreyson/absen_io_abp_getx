import 'package:flutter/material.dart';
import 'package:face_id_plus/abp_energy/landing/auth_check.dart';
import 'package:face_id_plus/abp_energy/login/models/login_model.dart';
import 'package:face_id_plus/abp_energy/login/screen/menu_auth.dart';
import 'package:face_id_plus/abp_energy/utils/constants.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Masuk extends StatefulWidget {
  const Masuk({Key? key}) : super(key: key);

  @override
  State<Masuk> createState() => _MasukState();
}

class _MasukState extends State<Masuk> {
  final _formKey = GlobalKey<FormState>();
  late FocusNode _usernameFocus, _passwordFocus;
  SharedPreferences? sharedPref;
  bool? isLogin;
  final Color _warna = const Color.fromARGB(255, 2, 113, 98);
  bool _passwordVisible = true;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final RoundedLoadingButtonController _roundedController =
      RoundedLoadingButtonController();
  bool errMsg = false;
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
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
          backgroundColor: _warna,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const MenuAuth()));
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
              ))),
      backgroundColor: _warna,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          autovalidateMode: _autovalidateMode,
          key: _formKey,
          child: ListView(
            children: [
              Center(
                child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)),
                    margin: const EdgeInsets.all(20),
                    elevation: 20,
                    child: const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: ClipRect(
                          child: Image(
                        image: AssetImage('assets/images/ic_abp.png'),
                        height: 70,
                      )),
                    )),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    focusNode: _usernameFocus,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: _warna)),
                        border: const OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: _warna)),
                        labelStyle: TextStyle(color: _warna),
                        labelText: "Username / NIK"),
                    onSaved: (value) {},
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
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    focusNode: _passwordFocus,
                    obscureText: _passwordVisible,
                    textInputAction: TextInputAction.go,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: _warna)),
                        border: const OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: _warna)),
                        labelStyle: TextStyle(color: _warna),
                        labelText: "Password",
                        hintText: "Password",
                        suffixIcon: IconButton(
                            icon: _passwordVisible
                                ? Icon(Icons.visibility_off, color: _warna)
                                : Icon(Icons.visibility, color: _warna),
                            onPressed: () {
                              _passwordFocus.unfocus();
                              toggleVisible();
                            })),
                    onSaved: (value) {},
                    onFieldSubmitted: (term) {
                      _passwordFocus.unfocus();
                      _onLogin(context);
                      _roundedController.start();
                      setState(() {});
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
                  successColor: Constants.green,
                  color: Colors.white,
                  elevation: 10,
                  controller: _roundedController,
                  onPressed: () {
                    _onLogin(context);
                  },
                  valueColor: _warna,
                  child: Text(
                    "Masuk",
                    style: TextStyle(
                      color: _warna,
                      fontSize: 24,
                    ),
                  )),
              AnimatedOpacity(
                opacity: errMsg ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: const Card(
                  elevation: 10,
                  color: Colors.red,
                  margin: EdgeInsets.only(top: 50, left: 20, right: 20),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                        child: Text(
                      "Username Atau Password Salah",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _onLogin(BuildContext context) async {
    String user = _usernameController.text.toString();
    String pass = _passwordController.text.toString();
    _autovalidateMode = AutovalidateMode.always;

    if (_formKey.currentState!.validate()) {
      var auth = await AuthApi.login(user, pass);
      if (mounted) {
        if (auth != null) {
          var dataUser = auth.login;
          if (dataUser != null) {
            var _success = dataUser.success;
            if (_success != null) {
              if (_success) {
                var _user = dataUser.user;
                if (_user != null) {
                  _roundedController.success();
                  Future.delayed(const Duration(seconds: 2), () {
                    _setPref(_user);
                  });
                } else {
                  _errEvent();
                }
              } else {
                _errEvent();
              }
            } else {
              _errEvent();
            }
          } else {
            _errEvent();
          }
        } else {
          _errEvent();
        }
      }
    } else {
      _roundedController.error();
      Future.delayed(const Duration(seconds: 2), () {
        _autovalidateMode = AutovalidateMode.disabled;
        _formKey.currentState?.reset();
        _roundedController.reset();
      });
    }
  }

  _setPref(User _user) async {
    var pref = await SharedPreferences.getInstance();
    await pref.setBool(Constants.ISLOGIN, true);
    await pref.setString(Constants.USERNAME, _user.username!);
    await pref.setString(Constants.NIK, _user.nik!);
    await pref.setString(Constants.NAME, _user.namaLengkap!);
    await pref.setString(Constants.RULE, _user.rule!);
    await pref.setString(Constants.fotoProfile, _user.photoProfile!);

    if (mounted) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const AuthCheck()));
    }
  }

  _errEvent() async {
    errMsg = true;
    _roundedController.error();
    setState(() {});
    await Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _usernameController.clear();
        _passwordController.clear();
        _usernameFocus.requestFocus();
        _roundedController.reset();
        _autovalidateMode = AutovalidateMode.disabled;
        errMsg = false;
      });
    });
  }

  void toggleVisible() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
