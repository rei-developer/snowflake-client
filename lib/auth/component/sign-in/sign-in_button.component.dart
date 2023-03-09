import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snowflake_client/auth/entity/auth_type.entity.dart';
import 'package:snowflake_client/utils/asset_loader.dart';

class SignInButtonComponent extends StatelessWidget {
  const SignInButtonComponent(this.authType, {this.callback, Key? key}) : super(key: key);

  final AuthType authType;
  final VoidCallback? callback;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: callback?.call,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 8.r),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.6),
            borderRadius: BorderRadius.circular(6.r),
          ),
          child: AssetLoader('image/icon/auth/${authType.name}.svg').image(),
        ),
      );
}
