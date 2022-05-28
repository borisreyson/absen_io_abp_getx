import 'package:face_id_plus/permit/auth/background.dart';
import 'package:face_id_plus/permit/mainpage.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Background(),
          Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 60),
                  child: const Center(
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 150,
                  child: Stack(
                    children: [
                      loginWidget(),
                      loginButton(),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 16, top: 16),
                      child: Text(
                        "Forgot ?",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[400],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget loginButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(right: 15),
        height: 80,
        width: 80,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.green[200]!.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color(0xff1bccba),
              Color(0xff22e2ab),
            ],
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(100),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MainPage(),
                ),
              );
            },
            child: const Icon(
              Icons.arrow_forward_outlined,
              color: Colors.white,
              size: 32,
            ),
          ),
        ),
      ),
    );
  }

  Widget loginWidget() {
    return Container(
      padding: const EdgeInsets.only(left: 20),
      margin: const EdgeInsets.only(
        right: 70,
      ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0,
            blurRadius: 25,
            offset: const Offset(0, 10),
          ),
        ],
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(150),
          bottomRight: Radius.circular(150),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextFormField(
            decoration: const InputDecoration(
                border: InputBorder.none,
                icon: Icon(
                  Icons.person_rounded,
                ),
                labelText: "Username"),
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 40.0),
            child: TextFormField(
              obscureText: _passwordVisible,
              decoration: InputDecoration(
                  icon: const Icon(
                    Icons.key,
                  ),
                  border: InputBorder.none,
                  labelText: "Password",
                  suffixIcon: IconButton(
                      icon: _passwordVisible
                          ? const Icon(
                              Icons.visibility_off,
                            )
                          : const Icon(
                              Icons.visibility,
                            ),
                      onPressed: () {
                        toggleVisible();
                      })),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.go,
            ),
          ),
        ],
      ),
    );
  }

  void toggleVisible() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }
}
