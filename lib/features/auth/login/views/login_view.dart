import 'package:flutter/material.dart';
import 'package:mobile_boilerplate/application/components/button/ibutton.dart';
import 'package:mobile_boilerplate/application/components/dialog/idialog_view.dart';
import 'package:mobile_boilerplate/application/components/image/iimage.dart';
import 'package:mobile_boilerplate/application/components/text_form/itext_form.dart';
import 'package:mobile_boilerplate/application/constant/image_path.dart';
import 'package:mobile_boilerplate/application/helper/size_config.dart';
import 'package:mobile_boilerplate/features/auth/login/viewmodel/login_viewmodel.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  static const routeName = '/LoginView';

  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginViewModel(),
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          IDialogView.dialogConfirmExit(context);
        },
        child: Scaffold(
          body: SingleChildScrollView(
            padding: EdgeInsets.only(
              top: SizeConfig.kDefaultPadding * 10,
              left: SizeConfig.kDefaultPadding * 3,
              right: SizeConfig.kDefaultPadding * 3,
            ),
            child: Consumer<LoginViewModel>(
              builder: (context, provider, child) {
                return Form(
                  key: provider.formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: SizeConfig.kDefaultPadding * 5,
                        ),
                        child: IImage(
                          image: ImagePath.logo,
                          width: SizeConfig.screenWidth * .25,
                        ),
                      ),
                      ITextForm(
                        label: 'Username',
                        ctrl: provider.ctrlUsername,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'username is required';
                          }
                          return null;
                        },
                      ),
                      ITextForm(
                        label: 'Password',
                        ctrl: provider.ctrlPassword,
                        padding: EdgeInsets.symmetric(vertical: SizeConfig.kDefaultPadding * 2),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'password is required';
                          }
                          return null;
                        },
                      ),
                      IButton(
                        name: 'Login',
                        onPressed: () async {
                          if (provider.formKey.currentState!.validate()) {
                            final result = await provider.login(context);
                            if (result != null && context.mounted) {
                              IDialogView.dialogSuccess(
                                context,
                                title: result.username,
                                desc: 'Success Login',
                              );
                            }
                          }
                        },
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
