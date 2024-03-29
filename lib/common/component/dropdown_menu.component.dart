import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snowflake_client/common/provider/common.provider.dart';
import 'package:snowflake_client/i18n/strings.g.dart';

class DropdownMenuComponent extends ConsumerStatefulWidget {
  const DropdownMenuComponent(
    this.items, {
    this.hintText,
    this.defaultValue,
    this.isDisabled = false,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  final Map<String, String> items;
  final String? hintText;
  final String? defaultValue;
  final bool isDisabled;
  final Function(String? prev, String next) onChanged;

  @override
  ConsumerState<DropdownMenuComponent> createState() => DropdownMenuComponentState();
}

class DropdownMenuComponentState extends ConsumerState<DropdownMenuComponent> {
  late String? selectedItem;
  late ScrollController _scrollController;

  StringsEn get t => ref.watch(translationProvider);

  @override
  void initState() {
    super.initState();
    selectedItem = widget.defaultValue;
    _scrollController = ScrollController();
  }

  void setSelectedItem(String key) => setState(() => selectedItem = key);

  void setSelectedItemByValue(String value) => setSelectedItem(_getKeyByValue(value));

  int _getSelectedIndex(String key) => widget.items.keys.toList().indexOf(key);

  String _getKey(int index) => widget.items.keys.toList()[index];

  String _getKeyByValue(String value) => widget.items.keys.where((e) => e == value).first;

  String _getLabel(int index) => widget.items.values.toList()[index];

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          GestureDetector(
            child: ConstrainedBox(
              constraints: BoxConstraints.tightFor(height: 48.r),
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 20.r),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(10.r)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        selectedItem == null
                            ? widget.hintText ?? t.common.select
                            : _getLabel(_getSelectedIndex(selectedItem!)),
                        style: TextStyle(
                          fontSize: 14.r,
                          color: Colors.white.withOpacity(
                            widget.isDisabled || selectedItem == null ? 0.5 : 1,
                          ),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Transform.rotate(
                      angle: -90 * math.pi / 180,
                      child: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 12.r),
                    ),
                  ],
                ),
              ),
            ),
            onTap: () {
              if (widget.isDisabled) {
                return;
              }
              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                builder: (BuildContext context) {
                  WidgetsBinding.instance.addPostFrameCallback(
                    (_) {
                      if (!_scrollController.hasClients || selectedItem == null) {
                        return;
                      }
                      _scrollController.animateTo(
                        _getSelectedIndex(selectedItem!) * 46.r,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                      );
                    },
                  );
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.r),
                        topRight: Radius.circular(20.r),
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 20.r),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          width: 60.r,
                          height: 5.r,
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 20.r, horizontal: 10.r),
                            child: ListView.separated(
                              controller: _scrollController,
                              separatorBuilder: (context, index) => Container(height: 10.r),
                              itemBuilder: (context, index) {
                                final isSelected = selectedItem == _getKey(index);
                                return InkWell(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 10.r, horizontal: 10.r),
                                    decoration: BoxDecoration(
                                      color: isSelected ? const Color(0xFFffb7c5) : null,
                                      borderRadius: BorderRadius.all(Radius.circular(10.r)),
                                    ),
                                    child: Text(
                                      _getLabel(index),
                                      style: TextStyle(
                                        color: isSelected ? Colors.black : Colors.white,
                                        fontSize: 14.r,
                                        fontWeight: isSelected ? FontWeight.w600 : null,
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    if (widget.isDisabled) {
                                      return;
                                    }
                                    final prev = selectedItem;
                                    final next = _getKey(index);
                                    widget.onChanged(prev, next);
                                    setSelectedItem(next);
                                    Navigator.pop(context);
                                  },
                                );
                              },
                              itemCount: widget.items.length,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      );
}
