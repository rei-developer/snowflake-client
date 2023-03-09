import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snowflake_client/utils/go.util.dart';

Future<bool> showConfirmDialog(
  BuildContext context, {
  String? title,
  String? message,
  String? cancelButtonLabel,
  String? confirmButtonLabel,
  bool? confirmOnly,
}) async =>
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => _DialogContainer(
        title: title,
        message: message,
        cancelButtonLabel: cancelButtonLabel,
        confirmButtonLabel: confirmButtonLabel,
        confirmOnly: confirmOnly,
      ),
    ) as bool;

class _DialogContainer extends ConsumerWidget {
  const _DialogContainer({
    Key? key,
    this.title,
    this.message,
    this.cancelButtonLabel,
    this.confirmButtonLabel,
    this.confirmOnly = false,
  }) : super(key: key);

  final String? title;
  final String? message;
  final String? cancelButtonLabel;
  final String? confirmButtonLabel;
  final bool? confirmOnly;

  @override
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.r),
              padding: EdgeInsets.fromLTRB(20.r, 32.r, 20.r, 20.r),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.all(Radius.circular(12.r)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    title ?? '알림',
                    style: TextStyle(color: Colors.white, fontSize: 16.r),
                  ),
                  if (message != null) ...[
                    SizedBox(height: 20.r),
                    Text(message!, style: const TextStyle(color: Colors.white)),
                  ],
                  SizedBox(height: 40.r),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (confirmOnly == null || confirmOnly == false) ...[
                        Flexible(
                          flex: 1,
                          child: MaterialButton(
                            color: Colors.white,
                            child: Text(cancelButtonLabel ?? 'Cancel'),
                            onPressed: () => Go(context).pop(false),
                          ),
                        ),
                        SizedBox(width: 10.r),
                      ],
                      Flexible(
                        flex: 2,
                        child: MaterialButton(
                          color: Colors.amber,
                          child: Text(confirmButtonLabel ?? 'Confirm'),
                          onPressed: () => Go(context).pop(true),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      );
}
