import 'package:authenticator/components/otp_item.dart';
import 'package:authenticator/controllers/totp_controller.dart';
import 'package:authenticator/pages/form_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  final TotpController _totpController = Get.put(TotpController());

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton:
          _buildFloatActionButton(), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  AppBar _buildAppBar() {
    return true ? _mainAppBar() : _secondAppBar();
  }

  AppBar _mainAppBar() {
    return AppBar(
      title: Text(
        "Authenticator",
        style: TextStyle(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      centerTitle: true,
    );
  }

  AppBar _secondAppBar() {
    return AppBar(
      title: Text(
        "Authenticator",
        style: TextStyle(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      leading: Icon(
        Icons.arrow_back,
        color: Colors.black,
      ),
      actions: [
        Icon(Icons.delete),
        Padding(
          padding: EdgeInsetsDirectional.only(end: 8),
        ),
        Icon(Icons.edit)
      ],
    );
  }

  Widget _buildBody() {
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
        ),
        child: (_totpController.otpItems.isEmpty)
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Nothing to see here',
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Add an account to get started',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[900],
                      ),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                itemCount: _totpController.otpItems.length,
                itemBuilder: (context, index) {
                  return OTPItem(
                    secureOtp: _totpController.otpItems[index],
                    duration: 60,
                  );
                },
              ),
      ),
    );
  }

  Widget _buildFloatActionButton() {
    return SpeedDial(
      icon:Icons.add,
      useRotationAnimation: true,
      spacing: 8,
      spaceBetweenChildren: 8,
      iconTheme: IconThemeData(color: Colors.black),
      backgroundColor: Colors.white,
      activeIcon: Icons.close,
      overlayColor: Colors.grey,
      overlayOpacity: 0.6,
      children: [
        SpeedDialChild(
            child: const Icon(
              Icons.keyboard,
              color: Colors.lightBlue,
            ),
            label: 'Enter a Set up Key',
            backgroundColor: Colors.white,
            onTap: () {
              _totpController.navigateToFormPage();
            }),
      ],
    );
  }
}
