import 'package:flutter/material.dart';

class TimeSelector extends StatefulWidget {
  final void Function(int hour, int minute, bool isAm)? onTimeChanged;

  const TimeSelector({super.key, this.onTimeChanged});

  @override
  State<TimeSelector> createState() => _TimeSelectorState();
}

class _TimeSelectorState extends State<TimeSelector> {
  final ScrollController _hourScrollController = ScrollController();
  final ScrollController _minuteScrollController = ScrollController();

  final List<int> hours = List.generate(12, (i) => i + 1); // 1–12
  final List<int> minutes = List.generate(60, (i) => i + 1); // 1–60

  int selectedHour = DateTime.now().hour % 12 == 0 ? 12 : DateTime.now().hour % 12;
  int? selectedMinute; // ✅ Nullable so you can validate
  bool isAm = DateTime.now().hour < 12;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToCenter(_hourScrollController, selectedHour - 1);

      if (selectedMinute != null) {
        _scrollToCenter(_minuteScrollController, selectedMinute! - 1);
      }
    });
  }

  void _scrollToCenter(ScrollController controller, int index) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      const double itemWidth = 60;
      final double screenWidth = MediaQuery.of(context).size.width;
      final double offset = (index * itemWidth) - (screenWidth / 2) + (itemWidth / 2);

      controller.animateTo(
        offset,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _hourScrollController.dispose();
    _minuteScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Select AM or PM', style: TextStyle(fontSize: 16)),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildToggleButton("AM", isAm, () => setState(() => isAm = true)),
            const SizedBox(width: 12),
            _buildToggleButton("PM", !isAm, () => setState(() => isAm = false)),
          ],
        ),

        const SizedBox(height: 12),

        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text('Select Hour', style: TextStyle(fontSize: 16)),
        ),
        const SizedBox(height: 4),

        _buildScrollRow(
          items: hours,
          selectedValue: selectedHour,
          controller: _hourScrollController,
          onTap: (value, index) {
            setState(() {
              selectedHour = value;
            });
            _scrollToCenter(_hourScrollController, index);

            if (selectedMinute != null) {
              widget.onTimeChanged?.call(selectedHour, selectedMinute!, isAm);
            }
          },
        ),

        const SizedBox(height: 12),

        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text('Select Minute', style: TextStyle(fontSize: 16)),
        ),
        const SizedBox(height: 4),

        _buildScrollRow(
          items: minutes,
          selectedValue: selectedMinute ?? -1, // Safe fallback
          controller: _minuteScrollController,
          onTap: (value, index) {
            setState(() {
              selectedMinute = value;
            });
            _scrollToCenter(_minuteScrollController, index);

            widget.onTimeChanged?.call(selectedHour, value, isAm);
          },
        ),
      ],
    );
  }

  Widget _buildToggleButton(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.green : Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildScrollRow({
    required List<int> items,
    required int selectedValue,
    required ScrollController controller,
    required void Function(int value, int index) onTap,
  }) {
    const double itemWidth = 60;

    return SizedBox(
      height: 60,
      width: itemWidth * 5, // Show 5 items
      child: ListView.builder(
        controller: controller,
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final value = items[index];
          final isSelected = value == selectedValue;

          return GestureDetector(
            onTap: () => onTap(value, index),
            child: Container(
              width: itemWidth,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: isSelected ? Colors.green : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: Text(
                '$value',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
