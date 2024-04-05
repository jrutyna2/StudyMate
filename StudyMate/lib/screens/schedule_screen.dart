import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'DatabaseHelper.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}


class _ScheduleScreenState extends State<ScheduleScreen> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  late DateTime _selectedDay;
  late DateTime _focusedDay;
  late TextEditingController _taskNameController;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _focusedDay = DateTime.now();
    _taskNameController = TextEditingController();
    _selectedEvents = ValueNotifier([]);
    _loadEventsForDay(_selectedDay);
  }

  void _loadEventsForDay(DateTime day) async {
    final events = await DatabaseHelper.instance.getEventsForDay(day);
    setState(() {
      _selectedEvents.value = events;
    });
  }

  Future<void> _addTask(String taskName) async {
    print("Adding task: $taskName"); // Debug print
    final newEvent = Event(
      date: _selectedDay,
      title: taskName,
      description: "Deadline: ${_selectedDay.year}-${_selectedDay.month}-${_selectedDay.day}",
    );
    print("Event to add: ${newEvent.toMap()}"); // Debug print
    await DatabaseHelper.instance.insertEvent(newEvent);
    _loadEventsForDay(_selectedDay);
  }

  Future<void> _removeTask(int id) async {
    await DatabaseHelper.instance.deleteEvent(id);
    _loadEventsForDay(_selectedDay);
  }

  void _showEditTaskDialog(Event event) {
    // Pre-populate the controller with the current task name
    _taskNameController.text = event.title;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Task'),
          content: TextField(
            controller: _taskNameController,
            decoration: const InputDecoration(hintText: 'Enter new task name'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                // Update the event with the new name
                if (_taskNameController.text.isNotEmpty) {
                  event.title = _taskNameController.text;
                  await DatabaseHelper.instance.updateEvent(event);
                  _loadEventsForDay(_selectedDay);
                  Navigator.pop(context);
                  _taskNameController.clear();
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }


  @override
  void dispose() {
    _selectedEvents.dispose();
    _taskNameController.dispose();
    super.dispose();
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
            eventLoader: (day) => _selectedEvents.value.where((event) => isSameDay(event.date, day)).toList(),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
              _loadEventsForDay(selectedDay);
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
                    trailing: Row(
                    mainAxisSize: MainAxisSize.min, // Important to avoid layout errors
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () => _showEditTaskDialog(events[index]),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _removeTask(events[index].id!),
                        ),
                      ],
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
        onPressed: () => _showAddTaskDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddTaskDialog() {
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
              onPressed: () async {
                if (_taskNameController.text.isNotEmpty) {
                  await _addTask(_taskNameController.text);
                  _taskNameController.clear();
                  Navigator.pop(context); // Close the dialog
                  print("Task added: ${_taskNameController.text}"); // Debug print
                }
              },
              child: const Text('Add'),
            ),

          ],
        );
      },
    );
  }
}

class Event {
  final int? id;
  final DateTime date;
  String title;
  final String description;

  Event({this.id, required this.date, required this.title, required this.description});

  Map<String, dynamic> toMap() {
    return {
      // Ensure 'id' is not included in toMap since it's auto-generated
      'date': date.toIso8601String(),
      'title': title,
      'description': description,
    };
  }

  static Event fromMap(Map<String, dynamic> map) {
    return Event(
      id: map['id'],
      date: DateTime.parse(map['date']),
      title: map['title'],
      description: map['description'],
    );
  }
}
