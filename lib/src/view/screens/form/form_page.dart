import 'package:authenticator/src/core/util/validator.dart';
import 'package:authenticator/src/view/components/text_form_field_widget.dart';
import 'package:authenticator/src/view_model/form_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormPage extends StatelessWidget {
  final FormViewModel _formViewModel = Get.find<FormViewModel>();
  final TextEditingController _accountNameController = TextEditingController();
  final TextEditingController _secretKeyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(context), body: _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: context.theme.backgroundColor),
      child: Form(
        key: _formViewModel.formKey,
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
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      iconTheme: context.theme.iconTheme,
      title: Text(
        "Enter detail account",
        style: context.theme.textTheme.headline6,
      ),
    );
  }

  Widget _accountNameField() {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: TextFormFieldWidget(
        hintText: "Account name",
        validator: Validators.accountNameValidator,
        controller: _accountNameController,
      ),
    );
  }

  Widget _secretKeyField() {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: TextFormFieldWidget(
        hintText: "Your key",
        validator: Validators.secretKeyValidator,
        controller: _secretKeyController,
      ),
    );
  }

  void _onAddButtonClicked() {
    _formViewModel.addTotp(
        _secretKeyController.text, _accountNameController.text);
  }
}
