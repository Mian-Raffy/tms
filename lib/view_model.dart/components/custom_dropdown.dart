import 'package:flutter/material.dart';
import 'package:tms_mobileapp/controllers/task_controller.dart';

class CustomDropdown extends StatefulWidget {
  final List<DropdownMenuItem<String>>? items;
  final String? hint;
  final ValueChanged<String?>? onChanged;

  const CustomDropdown({
    super.key,
    this.items,
    this.hint,
    this.onChanged,
  });

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;

  final LayerLink _layerLink = LayerLink();

  void _toggleDropdown() {
    if (_isOpen) {
      _removeDropdown();
    } else {
      _showDropdown();
    }
  }

  void _showDropdown() {
    if (mounted) {
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context).insert(_overlayEntry!);
      setState(() {
        _isOpen = true;
      });
    }
  }

  void _removeDropdown() {
    if (mounted) {
      _overlayEntry?.remove();
      _overlayEntry = null;
      setState(() {
        _isOpen = false;
      });
    }
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0.0, size.height + 5.0),
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              children: widget.items!.map((item) {
                return GestureDetector(
                  onTap: () {
                    widget.onChanged?.call(item.value);
                    _removeDropdown();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12.0),
                    child: item.child,
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: _toggleDropdown,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.hint ?? 'Select an option',
              style: const TextStyle(fontSize: 16),
            ),
            const Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }
}
