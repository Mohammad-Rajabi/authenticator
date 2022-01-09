import 'package:authenticator/controllers/form_controller.dart';
import 'package:authenticator/models/secure_otp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormPage extends StatelessWidget {
  final FormController _formController = Get.put(FormController());
  final TextEditingController _accountNameController = TextEditingController();
  final TextEditingController _secretKeyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: context.theme.iconTheme,
          title: Text(
            "Enter detail account",
              style: context.theme.textTheme.headline6,
          ),
        ),
        body: Container(
          decoration: BoxDecoration(color: context.theme.backgroundColor),
          child: Form(
            key: _formController.formKey,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  _accountNameField(),
                  _secretKeyField(),
                  Align(
                    alignment: AlignmentDirectional.topStart,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          primary: Colors.blue),
                      onPressed: _onAddButtonClicked,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text('Add',
                            style: TextStyle(color: Colors.white, fontSize: 16)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _accountNameField() {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.text,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: _accountNameValidate,
        controller: _accountNameController,
        style: TextStyle(color: Colors.grey, fontSize: 16),
        decoration: InputDecoration(
          hintText: "Account name",
          hintStyle: TextStyle(color: Colors.grey[400], fontSize: 16),
          contentPadding: EdgeInsets.all(8),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey, width: 1)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey, width: 1)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey, width: 1)),
        ),
      ),
    );
  }

  Widget _secretKeyField() {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.text,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: _secretKeyValidate,
        controller: _secretKeyController,
        style: TextStyle(color: Colors.grey, fontSize: 16),
        decoration: InputDecoration(
          hintText: "Your key",
          hintStyle: TextStyle(color: Colors.grey[400], fontSize: 16),
          contentPadding: EdgeInsets.all(8),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey, width: 1)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey, width: 1)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey, width: 1)),
        ),
      ),
    );
  }

  String? _accountNameValidate(String? value) {
    if (value!.isEmpty) {
      return "required";
    } else {
      return null;
    }
  }

  String? _secretKeyValidate(String? value) {
    if (value!.isEmpty) {
      return "required";
    }
    if (value.length < 16) {
      return "Cannot be less than 16 letters";
    } else {
      return null;
    }
  }

  void _onAddButtonClicked() {
    SecureOtp secureOtp = SecureOtp(
        secret: _secretKeyController.text,
        accountName: _accountNameController.text);

    _formController.addTotp(secureOtp);
  }
}
