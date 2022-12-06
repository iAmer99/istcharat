import 'package:istchrat/screens/bottom_nav_bar/account_screen/edit_account_information/repo/AccountInfoModel.dart';

abstract class EditAccInfoStates{}

class EditAccInfoInitialStates extends EditAccInfoStates{}

class GetAccInfoSuccess extends EditAccInfoInitialStates{
  AccountInfoModel accInfoModel;
  GetAccInfoSuccess(this.accInfoModel);
}

class GetAccInfoSuccessError extends EditAccInfoInitialStates{}

class LoadingState extends EditAccInfoInitialStates{}

class UpdateAccInfoSuccessfully extends EditAccInfoInitialStates{}

class DeleteAccountSuccess extends EditAccInfoInitialStates{}

class DeleteAccountError extends EditAccInfoInitialStates{
  final String errorMsg;

  DeleteAccountError(this.errorMsg);
}