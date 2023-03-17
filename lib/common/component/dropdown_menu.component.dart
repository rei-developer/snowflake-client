import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DropdownMenuComponent extends StatefulWidget {
  const DropdownMenuComponent(
    this.items, {
    this.hintText,
    this.defaultValue,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  final Map<String, String> items;
  final String? hintText;
  final String? defaultValue;
  final ValueChanged<String> onChanged;

  @override
  State<DropdownMenuComponent> createState() => _DropdownMenuComponentState();
}

class _DropdownMenuComponentState extends State<DropdownMenuComponent> {
  late String selectedItem;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    selectedItem = widget.defaultValue ?? widget.items.values.first;
    _scrollController = ScrollController();
  }

  int _getSelectedIndex(String key) => widget.items.keys.toList().indexOf(key);

  String _getKey(int index) => widget.items.keys.toList()[index];

  String _getLabel(int index) => widget.items.values.toList()[index];

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          GestureDetector(
            child: ConstrainedBox(
              constraints: BoxConstraints.tightFor(height: 48.r),
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 10.r),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(10.r)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _getLabel(_getSelectedIndex(selectedItem)),
                      style: TextStyle(fontSize: 14.r, color: Colors.white),
                    ),
                    Transform.rotate(
                      angle: -90 * math.pi / 180,
                      child: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 12.r),
                    ),
                  ],
                ),
              ),
            ),
            onTap: () => showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              builder: (BuildContext context) {
                WidgetsBinding.instance.addPostFrameCallback(
                  (_) {
                    if (!_scrollController.hasClients) {
                      return;
                    }
                    _scrollController.animateTo(
                      _getSelectedIndex(selectedItem) * 46.r,
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
                                  widget.onChanged(_getKey(index));
                                  setState(() => selectedItem = _getKey(index));
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
            ),
          ),
        ],
      );
}
