import 'package:authenticator/components/otp_item.dart';
import 'package:authenticator/controllers/totp_controller.dart';
import 'package:authenticator/pages/form_page.dart';
import 'package:authenticator/utility/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  final TotpController _totpController = Get.put(TotpController());

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
      floatingActionButton: _buildFloatActionButton(
          context), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return true ? _mainAppBar(context) : _secondAppBar(context);
  }

  AppBar _mainAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: Text(
        "Authenticator",
        style: context.theme.textTheme.headline6,
      ),
      backgroundColor: context.theme.backgroundColor,
      centerTitle: true,
      actions: [
        PopupMenuButton(
            icon: Icon(
              Icons.more_vert,
              color: context.theme.iconTheme.color,
            ),
            onSelected: (String choise) {
              _totpController.changeTheme();
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                    value: 'theme mode',
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(end: 4),
                      child: Align(
                          alignment: AlignmentDirectional.topStart,
                          child: Text(
                            ThemeService().theme == ThemeMode.dark
                                ? 'View in light mode'
                                : 'View in dark mode',
                            style: context.theme.textTheme.bodyText2,
                          )),
                    ))
              ];
            })
      ],
    );
  }

  AppBar _secondAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        "Authenticator",
        style: context.theme.textTheme.headline6,
      ),
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

  Widget _buildBody(BuildContext context) {
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          color: context.theme.backgroundColor,
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
                        color: context.theme.textTheme.headline6!.color,
                      ),
                    ),
                    Text(
                      'Add an account to get started',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
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

  Widget _buildFloatActionButton(BuildContext context) {
    return SpeedDial(
      icon: Icons.add,
      useRotationAnimation: true,
      spacing: 8,
      spaceBetweenChildren: 8,
      iconTheme: context.theme.iconTheme,
      backgroundColor: context.theme.floatingActionButtonTheme.backgroundColor,
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
            backgroundColor:
                context.theme.floatingActionButtonTheme.backgroundColor,
            onTap: () {
              _totpController.navigateToFormPage();
            }),
      ],
    );
  }
}
