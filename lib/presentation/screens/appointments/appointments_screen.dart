import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:lucide_icons_flutter/lucide_icons_flutter.dart';
import '../../../core/theme/app_colors.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestion de Citas'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(LucideIcons.history)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCalendar(),
            const Padding(
              padding: EdgeInsets.all(24.0),
              child: Text(
                'Horarios Disponibles',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primaryNavy),
              ),
            ),
            _buildTimeSlots(),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: _selectedDay == null ? null : () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryCobalt,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Confirmar Cita', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendar() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [BoxShadow(color: AppColors.cardShadow, blurRadius: 15)],
      ),
      child: TableCalendar(
        firstDay: DateTime.now(),
        lastDay: DateTime.now().add(const Duration(days: 90)),
        focusedDay: _focusedDay,
        calendarFormat: _calendarFormat,
        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
        },
        calendarStyle: const CalendarStyle(
          selectedDecoration: BoxDecoration(color: AppColors.primaryCobalt, shape: BoxShape.circle),
          todayDecoration: BoxDecoration(color: AppColors.successEmerald, shape: BoxShape.circle),
        ),
        headerStyle: const HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }

  Widget _buildTimeSlots() {
    final slots = ['08:00 AM', '09:30 AM', '11:00 AM', '02:30 PM', '04:00 PM'];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        children: slots.map((slot) => _buildSlotChip(slot)).toList(),
      ),
    );
  }

  Widget _buildSlotChip(String time) {
    return FilterChip(
      label: Text(time),
      selected: false,
      onSelected: (val) {},
      backgroundColor: Colors.white,
      selectedColor: AppColors.primaryCobalt.withOpacity(0.2),
      checkmarkColor: AppColors.primaryCobalt,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: AppColors.divider),
      ),
    );
  }
}
