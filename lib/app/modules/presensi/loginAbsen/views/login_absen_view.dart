import 'package:face_id_plus/app/controllers/navigasi_controller.dart';
import 'package:face_id_plus/app/data/models/login_model.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../../views/views/navigasi_view.dart';
import '../controllers/login_absen_controller.dart';

class LoginAbsenView extends GetView<LoginAbsenController> {
  var navigasiTap = Get.find<NavigasiController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Absen"),
      ),
      body: Obx(() => Stack(
            children: [
              loginForm(context, controller),
            ],
          )),
      bottomNavigationBar: NavigasiView(
        navigasiTap: navigasiTap,
      ),
    );
  }

  Widget loginForm(context, _controller) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(10),
      child: Form(
        key: _controller.formKey,
        child: ListView(
          children: [
            TextFormField(
              keyboardType: TextInputType.number,
              focusNode: _controller.userFocus,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: "Username / NIK"),
              onSaved: (value) {
                _controller.user.value = value!;
              },
              onFieldSubmitted: (term) {
                _controller.userFocus.unfocus();
                FocusScope.of(context).requestFocus(_controller.passFocus);
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
              controller: _controller.userController,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              focusNode: _controller.passFocus,
              obscureText: !_controller.passwordVisible.value,
              textInputAction: TextInputAction.go,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: "Password",
                  hintText: "Password",
                  suffixIcon: IconButton(
                      icon: !_controller.passwordVisible.value
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
                      onPressed: () {
                        _controller.passFocus.unfocus();
                        _controller.toggleVisible();
                      })),
              onSaved: (value) {
                _controller.pass = value!;
              },
              onFieldSubmitted: (term) {
                _controller.passFocus.unfocus();
                _controller.doLogin();
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Password Wajib Di Isi';
                }
                return null;
              },
              controller: _controller.passController,
            ),
            const SizedBox(
              height: 20,
            ),
            RoundedLoadingButton(
              controller: controller.roundBtn,
              onPressed: () {
                controller.roundBtn.start();
                var loginAbp = LoginABP();
                loginAbp.username = controller.userController.text;
                loginAbp.password = controller.passController.text;
                controller.doLogin(loginAbp);
              },
              child: const Text(
                "Masuk",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Visibility(
              visible: controller.akunDitemukan.value,
              child: RoundedLoadingButton(
                color: Color.fromARGB(255, 121, 21, 14),
                controller: controller.roundBtn,
                onPressed: () {
                  controller.roundBtn.start();
                  var loginAbp = LoginABP();
                  loginAbp.username = controller.userData.value.nik;
                  loginAbp.password = '12345';
                  controller.apiLogin(loginAbp);
                },
                child: const Text(
                  "Masuk Dengan Akun ABP",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
