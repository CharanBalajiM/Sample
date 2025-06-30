import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateSelector extends StatefulWidget {
  final ValueChanged<DateTime>? onDateChanged;
  const DateSelector({super.key,this.onDateChanged});

  @override
  State<DateSelector> createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  final ScrollController _scrollController = ScrollController();
  late List<DateTime> dateList;
  int selectedIndex = 15;

  @override
  void initState() {
    super.initState();
    final today = DateTime.now();

    dateList = List.generate(30, (i) => today.add(Duration(days: i - 15)));

    // Center the default selected item AFTER layout is ready
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToCenter(selectedIndex);
    });
  }

  void _scrollToCenter(int index) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      const double itemWidth = 60;
      final double screenWidth = MediaQuery.of(context).size.width;

      final double offset = (index * itemWidth) - (screenWidth / 2) + (itemWidth / 2);
      _scrollController.animateTo(
        offset,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String monthLabel = DateFormat('MMM').format(dateList[selectedIndex]);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          monthLabel,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 60,
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: dateList.length,
            itemBuilder: (context, index) {
              final date = dateList[index];
              final isSelected = index == selectedIndex;

              return GestureDetector(
                onTap: () {
            setState(() {
    selectedIndex = index;
  });

  widget.onDateChanged?.call(dateList[selectedIndex]); // ✅ THIS LINE

  _scrollToCenter(index);
},

                child: Container(
                  width: 60,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.green : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${date.day}',
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
        )
      ],
    );
  }
}
