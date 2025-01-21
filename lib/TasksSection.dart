// // import 'package:flutter/material.dart';
// // import 'TaskDetailsPage.dart'; // Import your new page here.

// // class TasksSection extends StatelessWidget {
// //   final List<Task> tasks;
// //   final List<Task> completedTasks;

// //   const TasksSection({
// //     Key? key,
// //     this.tasks = const [
// //       Task(
// //         title: 'Water the plants',
// //         reward: '4 KWD',
// //         duration: 3,
// //         timeLeft: 1,
// //       ),
// //       Task(
// //         title: 'Feed the birdies',
// //         reward: '2 KWD',
// //         duration: 2,
// //         timeLeft: 1.5,
// //       ),
// //       Task(
// //         title: 'Eat your veggies',
// //         reward: '5 KWD',
// //         duration: 1,
// //         timeLeft: 0.083, // 5 minutes left = 5/60
// //       ),
// //     ],
// //     this.completedTasks = const [
// //       Task(title: 'Fold the laundry', reward: '5 KWD'),
// //       Task(title: 'Comb your hair', reward: '2 KWD'),
// //     ],
// //   }) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return LayoutBuilder(
// //       builder: (context, constraints) {
// //         return Container(
// //           width: double.infinity,
// //           constraints: BoxConstraints(
// //             minWidth: 507,
// //             minHeight: 487,
// //           ),
// //           decoration: BoxDecoration(
// //             color: Colors.white,
// //             borderRadius: BorderRadius.circular(30),
// //           ),
// //           child: SingleChildScrollView(
// //             child: Padding(
// //               padding: const EdgeInsets.all(16.0),
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Text(
// //                     'Tasks:',
// //                     style: TextStyle(
// //                       fontSize: 32,
// //                       fontWeight: FontWeight.w600,
// //                       color: Color(0xFFF38E22),
// //                     ),
// //                   ),
// //                   SizedBox(height: 16),
// //                   ...tasks.map((task) => TaskItem(task: task)),
// //                   SizedBox(height: 24),
// //                   Text(
// //                     'Completed:',
// //                     style: TextStyle(
// //                       fontSize: 32,
// //                       fontWeight: FontWeight.w600,
// //                       color: Color(0xFFF38E22),
// //                     ),
// //                   ),
// //                   SizedBox(height: 16),
// //                   ...completedTasks
// //                       .map((task) => CompletedTaskItem(task: task)),
// //                 ],
// //               ),
// //             ),
// //           ),
// //         );
// //       },
// //     );
// //   }
// // }

// // class Task {
// //   final String title;
// //   final String reward;
// //   final double? duration; // Total task duration in hours
// //   final double? timeLeft; // Remaining time in hours

// //   const Task({
// //     required this.title,
// //     required this.reward,
// //     this.duration,
// //     this.timeLeft,
// //   });
// // }

// // class TaskItem extends StatelessWidget {
// //   final Task task;

// //   const TaskItem({
// //     Key? key,
// //     required this.task,
// //   }) : super(key: key);

// //   void _navigateToTaskDetails(BuildContext context) {
// //     Navigator.push(
// //       context,
// //       MaterialPageRoute(
// //         builder: (context) => TaskDetailsPage(taskTitle: task.title),
// //       ),
// //     );
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     // Calculate progress percentage
// //     double progress = 0;
// //     if (task.duration != null && task.timeLeft != null) {
// //       progress = 1 - (task.timeLeft! / task.duration!);
// //     }

// //     return GestureDetector(
// //       onTap: () => _navigateToTaskDetails(context), // Navigate to details page
// //       child: Padding(
// //         padding: const EdgeInsets.only(bottom: 12.0),
// //         child: Stack(
// //           alignment: Alignment.bottomLeft,
// //           children: [
// //             // Task Card
// //             Container(
// //               height: 60,
// //               decoration: BoxDecoration(
// //                 gradient: LinearGradient(
// //                   colors: [
// //                     Color(0xFFF38E22),
// //                     Color(0xFFF5A147),
// //                   ],
// //                   begin: Alignment.topLeft,
// //                   end: Alignment.bottomRight,
// //                 ),
// //                 borderRadius: BorderRadius.circular(12),
// //                 boxShadow: [
// //                   BoxShadow(
// //                     color: Colors.black.withOpacity(0.1),
// //                     blurRadius: 4,
// //                     offset: Offset(2, 4),
// //                   ),
// //                 ],
// //               ),
// //               child: Row(
// //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                 children: [
// //                   Padding(
// //                     padding: const EdgeInsets.only(left: 16),
// //                     child: Text(
// //                       task.title,
// //                       style: TextStyle(
// //                         fontSize: 20,
// //                         fontWeight: FontWeight.bold,
// //                         color: Colors.white,
// //                       ),
// //                     ),
// //                   ),
// //                   Padding(
// //                     padding: const EdgeInsets.only(right: 16),
// //                     child: Row(
// //                       children: [
// //                         Icon(Icons.card_giftcard, color: Colors.white),
// //                         SizedBox(width: 4),
// //                         Text(
// //                           task.reward,
// //                           style: TextStyle(
// //                             fontSize: 18,
// //                             color: Colors.white,
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),

// //             // Dynamic Progress Bar
// //             Positioned(
// //               bottom: 0,
// //               left: 0,
// //               right: 0,
// //               child: Container(
// //                 height: 8, // Height for a bold progress bar
// //                 decoration: BoxDecoration(
// //                   color: Colors.white.withOpacity(0.3), // Background color
// //                   borderRadius: BorderRadius.only(
// //                     bottomLeft: Radius.circular(12),
// //                     bottomRight: Radius.circular(12),
// //                   ),
// //                 ),
// //                 child: FractionallySizedBox(
// //                   widthFactor: progress.clamp(0, 1), // Progress percentage
// //                   alignment: Alignment.centerLeft,
// //                   child: Container(
// //                     decoration: BoxDecoration(
// //                       color: Colors.white, // Foreground progress color
// //                       borderRadius: BorderRadius.only(
// //                         bottomLeft: Radius.circular(12),
// //                         bottomRight: Radius.circular(progress == 1 ? 12 : 0),
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// // class CompletedTaskItem extends StatelessWidget {
// //   final Task task;

// //   const CompletedTaskItem({
// //     Key? key,
// //     required this.task,
// //   }) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return Padding(
// //       padding: const EdgeInsets.only(bottom: 8.0),
// //       child: Container(
// //         height: 53,
// //         decoration: BoxDecoration(
// //           color: Colors.white.withOpacity(0.7),
// //           borderRadius: BorderRadius.circular(10),
// //         ),
// //         child: ListTile(
// //           title: Text(
// //             task.title,
// //             style: TextStyle(
// //               fontSize: 24,
// //               fontWeight: FontWeight.bold,
// //               color: Colors.grey,
// //               decoration: TextDecoration.lineThrough,
// //             ),
// //           ),
// //           trailing: Text(
// //             task.reward,
// //             style: TextStyle(
// //               fontSize: 16,
// //               color: Colors.grey,
// //               decoration: TextDecoration.lineThrough,
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'TaskDetailsPage.dart'; // Import your new page here.

// class TasksSection extends StatelessWidget {
//   final List<Task> tasks;
//   final List<Task> completedTasks;

//   const TasksSection({
//     Key? key,
//     this.tasks = const [
//       Task(
//         title: 'Water the plants',
//         reward: '4 KWD',
//         duration: 3,
//         timeLeft: 1,
//       ),
//       Task(
//         title: 'Feed the birdies',
//         reward: '2 KWD',
//         duration: 2,
//         timeLeft: 1.5,
//       ),
//       Task(
//         title: 'Eat your veggies',
//         reward: '5 KWD',
//         duration: 1,
//         timeLeft: 0.083, // 5 minutes left = 5/60
//       ),
//     ],
//     this.completedTasks = const [
//       Task(title: 'Fold the laundry', reward: '5 KWD'),
//       Task(title: 'Comb your hair', reward: '2 KWD'),
//     ],
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         return Container(
//           width: double.infinity,
//           constraints: BoxConstraints(
//             minWidth: 507,
//             minHeight: 487,
//           ),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(30),
//           ),
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Tasks:',
//                     style: TextStyle(
//                       fontSize: 32,
//                       fontWeight: FontWeight.w600,
//                       color: Color(0xFFF38E22),
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   ...tasks.map((task) => TaskItem(task: task)),
//                   SizedBox(height: 24),
//                   Text(
//                     'Completed:',
//                     style: TextStyle(
//                       fontSize: 32,
//                       fontWeight: FontWeight.w600,
//                       color: Color(0xFFF38E22),
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   ...completedTasks
//                       .map((task) => CompletedTaskItem(task: task)),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// class Task {
//   final String title;
//   final String reward;
//   final double? duration; // Total task duration in hours
//   final double? timeLeft; // Remaining time in hours

//   const Task({
//     required this.title,
//     required this.reward,
//     this.duration,
//     this.timeLeft,
//   });
// }

// class TaskItem extends StatelessWidget {
//   final Task task;

//   const TaskItem({
//     Key? key,
//     required this.task,
//   }) : super(key: key);

//   void _navigateToTaskDetails(BuildContext context) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => TaskDetailsPage(taskTitle: task.title),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Calculate progress percentage
//     double progress = 0;
//     if (task.duration != null && task.timeLeft != null) {
//       progress = 1 - (task.timeLeft! / task.duration!);
//     }

//     return GestureDetector(
//       onTap: () => _navigateToTaskDetails(context), // Navigate to details page
//       child: Padding(
//         padding: const EdgeInsets.only(bottom: 12.0),
//         child: Stack(
//           alignment: Alignment.bottomLeft,
//           children: [
//             // Task Card
//             Container(
//               height: 60,
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [
//                     Color(0xFFF38E22),
//                     Color(0xFFF5A147),
//                   ],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//                 borderRadius: BorderRadius.circular(12),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.1),
//                     blurRadius: 4,
//                     offset: Offset(2, 4),
//                   ),
//                 ],
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(left: 16),
//                     child: Text(
//                       task.title,
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(right: 16),
//                     child: Row(
//                       children: [
//                         Icon(Icons.card_giftcard, color: Colors.white),
//                         SizedBox(width: 4),
//                         Text(
//                           task.reward,
//                           style: TextStyle(
//                             fontSize: 18,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             // Dynamic Progress Bar
//             Positioned(
//               bottom: 0,
//               left: 0,
//               right: 0,
//               child: Container(
//                 height: 8, // Height for a bold progress bar
//                 decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(0.3), // Background color
//                   borderRadius: BorderRadius.only(
//                     bottomLeft: Radius.circular(12),
//                     bottomRight: Radius.circular(12),
//                   ),
//                 ),
//                 child: FractionallySizedBox(
//                   widthFactor: progress.clamp(0, 1), // Progress percentage
//                   alignment: Alignment.centerLeft,
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.white, // Foreground progress color
//                       borderRadius: BorderRadius.only(
//                         bottomLeft: Radius.circular(12),
//                         bottomRight: Radius.circular(progress == 1 ? 12 : 0),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class CompletedTaskItem extends StatelessWidget {
//   final Task task;

//   const CompletedTaskItem({
//     Key? key,
//     required this.task,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8.0),
//       child: Container(
//         height: 53,
//         decoration: BoxDecoration(
//           color: Colors.white.withOpacity(0.7),
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: ListTile(
//           title: Text(
//             task.title,
//             style: TextStyle(
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//               color: Colors.grey,
//               decoration: TextDecoration.lineThrough,
//             ),
//           ),
//           trailing: Text(
//             task.reward,
//             style: TextStyle(
//               fontSize: 16,
//               color: Colors.grey,
//               decoration: TextDecoration.lineThrough,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class TasksSection extends StatelessWidget {
  final List<Task> tasks;
  final List<Task> completedTasks;

  const TasksSection({
    Key? key,
    this.tasks = const [
      Task(
        title: 'Water the plants',
        reward: '4 KWD',
        duration: 3,
        timeLeft: 1,
      ),
      Task(
        title: 'Feed the birdies',
        reward: '2 KWD',
        duration: 2,
        timeLeft: 1.5,
      ),
      Task(
        title: 'Eat your veggies',
        reward: '5 KWD',
        duration: 1,
        timeLeft: 0.083, // 5 minutes left = 5/60
      ),
    ],
    this.completedTasks = const [
      Task(title: 'Fold the laundry', reward: '5 KWD'),
      Task(title: 'Comb your hair', reward: '2 KWD'),
    ],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          width: double.infinity,
          constraints: BoxConstraints(
            minWidth: 507,
            minHeight: 487,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tasks:',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFF38E22),
                    ),
                  ),
                  SizedBox(height: 16),
                  ...tasks.map((task) => TaskItem(task: task)),
                  SizedBox(height: 24),
                  Text(
                    'Completed:',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFF38E22),
                    ),
                  ),
                  SizedBox(height: 16),
                  ...completedTasks
                      .map((task) => CompletedTaskItem(task: task)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class Task {
  final String title;
  final String reward;
  final double? duration; // Total task duration in hours
  final double? timeLeft; // Remaining time in hours

  const Task({
    required this.title,
    required this.reward,
    this.duration,
    this.timeLeft,
  });
}

class TaskItem extends StatelessWidget {
  final Task task;

  const TaskItem({
    Key? key,
    required this.task,
  }) : super(key: key);

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Task Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                task.title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Reward: ${task.reward}',
                style: TextStyle(fontSize: 18),
              ),
              if (task.duration != null && task.timeLeft != null) ...[
                SizedBox(height: 8),
                Text(
                  'Time Left: ${task.timeLeft!.toStringAsFixed(2)} hours',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Calculate progress percentage
    double progress = 0;
    if (task.duration != null && task.timeLeft != null) {
      progress = 1 - (task.timeLeft! / task.duration!);
    }

    return GestureDetector(
      onTap: () => _showDialog(context), // Show dialog on tap
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            // Task Card
            Container(
              height: 60,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFF38E22),
                    Color(0xFFF5A147),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: Offset(2, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      task.title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Row(
                      children: [
                        Icon(Icons.card_giftcard, color: Colors.white),
                        SizedBox(width: 4),
                        Text(
                          task.reward,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Dynamic Progress Bar
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 8, // Height for a bold progress bar
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3), // Background color
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: FractionallySizedBox(
                  widthFactor: progress.clamp(0, 1), // Progress percentage
                  alignment: Alignment.centerLeft,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white, // Foreground progress color
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(progress == 1 ? 12 : 0),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CompletedTaskItem extends StatelessWidget {
  final Task task;

  const CompletedTaskItem({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        height: 53,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.7),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          title: Text(
            task.title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
              decoration: TextDecoration.lineThrough,
            ),
          ),
          trailing: Text(
            task.reward,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
              decoration: TextDecoration.lineThrough,
            ),
          ),
        ),
      ),
    );
  }
}
