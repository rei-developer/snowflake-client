import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomRadioComponent extends StatefulWidget {
  const CustomRadioComponent(
    this.options, {
    this.defaultValue,
    this.isVertical = false,
    this.onChanged,
    Key? key,
  }) : super(key: key);

  final Map<String, int> options;
  final int? defaultValue;
  final bool isVertical;
  final Function(int selectedIndex)? onChanged;

  @override
  State<CustomRadioComponent> createState() => _CustomRadioComponentState();
}

class _CustomRadioComponentState extends State<CustomRadioComponent> {
  int _selectedValue = 0;

  @override
  void initState() {
    _selectedValue = widget.defaultValue ?? widget.options.values.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) => widget.isVertical
      ? Column(children: _renderSelectItem())
      : Row(children: _renderSelectItem());

  List<Widget> _renderSelectItem() => widget.options.entries.map(
        (entry) {
          final isSelected = entry.value == _selectedValue;
          final content = InkWell(
            child: Column(children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 16.r,
                    height: 48.r,
                    padding: EdgeInsets.symmetric(vertical: 16.r),
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFFffb7c5) : Colors.black,
                        border: isSelected ? Border.all(color: Colors.black, width: 4.r) : null,
                        borderRadius: BorderRadius.circular(500.r),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.r),
                  Expanded(child: Text(entry.key, style: const TextStyle(color: Colors.white))),
                ],
              ),
            ]),
            onTap: () => _updateSelectedValue(entry.value),
          );
          return widget.isVertical ? content : Flexible(child: content);
        },
      ).toList();

  void _updateSelectedValue(int? value) {
    if (value == null) {
      return;
    }
    widget.onChanged?.call(value);
    setState(() => _selectedValue = value);
  }
}
