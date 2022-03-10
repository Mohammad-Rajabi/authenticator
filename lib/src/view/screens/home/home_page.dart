import 'package:authenticator/src/data/local/theme_service.dart';
import 'package:authenticator/src/view/screens/form/widget/otp_item_widget.dart';
import 'package:authenticator/src/view_model/totp_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  final TotpViewModel _totpViewModel = Get.find<TotpViewModel>();

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
      floatingActionButton: _buildFloatActionButton(context),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return _appBar(context);
  }

  AppBar _appBar(BuildContext context) {
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
              _totpViewModel.changeTheme();
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

  Widget _buildBody(BuildContext context) {
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          color: context.theme.backgroundColor,
        ),
        child: (_totpViewModel.otpItems.isEmpty)
            ? _buildEmptyState(context)
            : _buildListView(),
      ),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
              itemCount: _totpViewModel.otpItems.length,
              itemBuilder: (context, index) {
                return OTPItemWidget(
                  secureOtp: _totpViewModel.otpItems[index],
                );
              },
            );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
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
              _totpViewModel.navigateToFormPage();
            }),
      ],
    );
  }
}
