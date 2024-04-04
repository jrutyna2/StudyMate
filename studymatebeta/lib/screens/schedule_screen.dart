import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  final Map<DateTime, List<Event>> _events = {};
  late DateTime _selectedDay;
  late DateTime _focusedDay;
  late TextEditingController _taskNameController;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _focusedDay = DateTime.now();
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay));
    _taskNameController = TextEditingController();
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    _taskNameController.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    return _events[day] ?? [];
  }

  void _removeTask(int index) {
    setState(() {
      List<Event> selectedDayEvents = _events[_selectedDay] ?? [];
      if (index >= 0 && index < selectedDayEvents.length) {
        selectedDayEvents.removeAt(index);
        _events[_selectedDay] = selectedDayEvents;
        _selectedEvents.value = _getEventsForDay(_selectedDay);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Study Schedule'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            eventLoader: _getEventsForDay,
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
                _selectedEvents.value = _getEventsForDay(selectedDay);
              });
            },
            calendarStyle: CalendarStyle(
              outsideDaysVisible: false,
              todayDecoration: const BoxDecoration(
                color: Colors.deepPurple,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.deepPurple[300],
                shape: BoxShape.circle,
              ),
              weekendTextStyle: const TextStyle(color: Colors.red),
            ),
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              leftChevronIcon: Icon(Icons.arrow_back_ios, size: 15, color: Colors.deepPurple),
              rightChevronIcon: Icon(Icons.arrow_forward_ios, size: 15, color: Colors.deepPurple),
              titleTextStyle: TextStyle(color: Colors.deepPurple),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ValueListenableBuilder<List<Event>>(
              valueListenable: _selectedEvents,
              builder: (context, events, _) {
                return ListView.builder(
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      child: ListTile(
                        leading: const Icon(Icons.event_note, color: Colors.deepPurple),
                        title: Text(events[index].title, style: const TextStyle(color: Colors.deepPurple)),
                        subtitle: Text(events[index].description),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _removeTask(index),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Add Task'),
                content: TextField(
                  controller: _taskNameController,
                  decoration: const InputDecoration(
                    hintText: 'Enter task name',
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      if (_taskNameController.text.isNotEmpty) {
                        final newTaskName = _taskNameController.text;
                        final tasksForDay = _events[_selectedDay] ?? [];
                        tasksForDay.add(
                          Event(
                            date: _selectedDay,
                            title: newTaskName,
                            description: "Deadline: ${_selectedDay.year}-${_selectedDay.month}-${_selectedDay.day}",
                          ),
                        );
                        _events[_selectedDay] = tasksForDay;
                        _selectedEvents.value = _getEventsForDay(_selectedDay);
                        _taskNameController.clear();
                      }
                      Navigator.pop(context);
                    },
                    child: const Text('Add'),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class Event {
  final DateTime date;
  final String title;
  final String description;

  Event({
    required this.date,
    required this.title,
    required this.description,
  });
}