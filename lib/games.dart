// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: GamesPage(),
//       ),
//     );
//   }
// }

// class GamesPage extends StatelessWidget {
//   final List<Map<String, dynamic>> games = [
//     {
//       'imageUrl':
//           'https://dashboard.codeparrot.ai/api/image/Z5HohvA8XwfbJP7Y/rectangl.png',
//       'title': 'Lemonade stand',
//       'description':
//           'this is a game description which is about lemons becoming juice',
//       'points': 100,
//       'isGift': true,
//     },
//     {
//       'imageUrl':
//           'https://dashboard.codeparrot.ai/api/image/Z5HohvA8XwfbJP7Y/rectangl-2.png',
//       'title': 'Coin Collector',
//       'description':
//           'this is a game description which is about collecting coins',
//       'points': 50,
//       'isGift': true,
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             Color(0xFFFFDE5A),
//             Color(0xFFF5A147),
//             Color(0xFFF6AE60),
//             Color(0xFFF49734),
//           ],
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//         ),
//       ),
//       child: Column(
//         children: [
//           HeaderSection(),
//           Padding(
//             padding: EdgeInsets.only(left: 16.0, top: 16.0),
//             child: Text(
//               'Increase your points by playing these games',
//               style: TextStyle(
//                 fontSize: 24,
//                 color: Colors.white.withOpacity(0.8),
//                 fontWeight: FontWeight.w400,
//               ),
//             ),
//           ),
//           Expanded(
//             child: ListView(
//               children: [
//                 Container(
//                   height: 300,
//                   child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: games.length,
//                     itemBuilder: (context, index) => GameCard(
//                       imageUrl: games[index]['imageUrl'],
//                       title: games[index]['title'],
//                       description: games[index]['description'],
//                       points: games[index]['points'],
//                       isGift: games[index]['isGift'],
//                     ),
//                   ),
//                 ),
//                 UsePointsSection(),
//               ],
//             ),
//           ),
//           CustomBottomNavigationBar(
//             selectedIndex: 0,
//             onItemSelected: (index) {
//               // Handle navigation
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// class HeaderSection extends StatelessWidget {
//   const HeaderSection({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       constraints: BoxConstraints(
//         minWidth: 360,
//         minHeight: 80,
//       ),
//       padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Row(
//             children: [
//               Text(
//                 'Games',
//                 style: TextStyle(
//                   fontSize: 48,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.white,
//                   height: 1.2,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 8.0),
//                 child: Image.network(
//                   'https://dashboard.codeparrot.ai/api/image/Z5HohvA8XwfbJP7Y/vector.png',
//                   width: 26,
//                   height: 26,
//                   color: Colors.white,
//                 ),
//               ),
//             ],
//           ),
//           Container(
//             padding:
//                 const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.25),
//               borderRadius: BorderRadius.circular(8.0),
//             ),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(
//                   'Points: 3213',
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.w700,
//                     color: Colors.white,
//                   ),
//                 ),
//                 SizedBox(width: 8.0),
//                 Container(
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Colors.white.withOpacity(0.1),
//                   ),
//                   child: IconButton(
//                     icon: Icon(Icons.add, color: Colors.white),
//                     onPressed: () {
//                       // Handle points history display
//                     },
//                     padding: EdgeInsets.all(4),
//                     constraints: BoxConstraints(
//                       minWidth: 32,
//                       minHeight: 32,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class GameCard extends StatelessWidget {
//   final String imageUrl;
//   final String title;
//   final String description;
//   final int points;
//   final bool isGift;

//   const GameCard({
//     Key? key,
//     required this.imageUrl,
//     required this.title,
//     required this.description,
//     required this.points,
//     required this.isGift,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//       constraints: BoxConstraints(minWidth: 300, maxWidth: 574, minHeight: 271),
//       decoration: BoxDecoration(
//         color: Color(0xFFF7B977),
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Row(
//         children: [
//           Container(
//             width: 150,
//             height: 150,
//             margin: EdgeInsets.all(16.0),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(20),
//               image: DecorationImage(
//                 image: NetworkImage(imageUrl),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           Expanded(
//             child: Padding(
//               padding: EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     title,
//                     style: TextStyle(
//                       fontSize: 32,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.white,
//                     ),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     'Game',
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.w400,
//                       color: Colors.white.withOpacity(0.6),
//                     ),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     description,
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.w700,
//                       color: Colors.white.withOpacity(0.6),
//                     ),
//                   ),
//                   Spacer(),
//                   Row(
//                     children: [
//                       Text(
//                         '+$points',
//                         style: TextStyle(
//                           fontSize: 40,
//                           fontWeight: FontWeight.w700,
//                           color: Colors.white,
//                         ),
//                       ),
//                       if (isGift) ...[
//                         SizedBox(width: 8),
//                         Icon(
//                           Icons.card_giftcard,
//                           color: Colors.white,
//                           size: 37,
//                         ),
//                       ],
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class UsePointsSection extends StatelessWidget {
//   final String title;
//   final List<Map<String, String>> cards;

//   UsePointsSection({
//     this.title = 'Use Your Points:',
//     this.cards = const [
//       {
//         'image':
//             'https://dashboard.codeparrot.ai/api/image/Z5HohvA8XwfbJP7Y/screensh.png',
//         'logo':
//             'https://dashboard.codeparrot.ai/api/image/Z5HohvA8XwfbJP7Y/logo.png',
//         'points': '3213/1150',
//       },
//       {
//         'image':
//             'https://dashboard.codeparrot.ai/api/image/Z5HohvA8XwfbJP7Y/screensh-2.png',
//         'logo':
//             'https://dashboard.codeparrot.ai/api/image/Z5HohvA8XwfbJP7Y/logo-2.png',
//         'points': '3213/1150',
//       },
//     ],
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: EdgeInsets.only(left: 16.0, bottom: 16.0),
//             child: Text(
//               title,
//               style: TextStyle(
//                 fontSize: 32,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//           Container(
//             height: 160,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               padding: EdgeInsets.symmetric(horizontal: 16.0),
//               itemCount: cards.length,
//               itemBuilder: (context, index) {
//                 return Padding(
//                   padding: EdgeInsets.only(right: 16.0),
//                   child: _buildShopCard(
//                     image: cards[index]['image']!,
//                     logo: cards[index]['logo']!,
//                     points: cards[index]['points']!,
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildShopCard({
//     required String image,
//     required String logo,
//     required String points,
//   }) {
//     return Container(
//       width: 300,
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.25),
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Row(
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(20),
//             child: Image.network(
//               image,
//               width: 100,
//               height: 100,
//               fit: BoxFit.cover,
//             ),
//           ),
//           Expanded(
//             child: Padding(
//               padding: EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Image.network(
//                     logo,
//                     width: 100,
//                     height: 25,
//                     fit: BoxFit.contain,
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     'Enjoy a 30% OFF on Kids Entry Ticket!',
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: Colors.white,
//                     ),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     points,
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.all(16.0),
//             child: Image.network(
//               'https://dashboard.codeparrot.ai/api/image/Z5HohvA8XwfbJP7Y/ic-basel.png',
//               width: 24,
//               height: 24,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class CustomBottomNavigationBar extends StatefulWidget {
//   final int selectedIndex;
//   final Function(int) onItemSelected;

//   const CustomBottomNavigationBar({
//     Key? key,
//     this.selectedIndex = 0,
//     required this.onItemSelected,
//   }) : super(key: key);

//   @override
//   _CustomBottomNavigationBarState createState() =>
//       _CustomBottomNavigationBarState();
// }

// class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 128,
//       decoration: BoxDecoration(
//         color: Colors.white,
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           _buildNavItem(0, 'Games',
//               'https://dashboard.codeparrot.ai/api/image/Z5HohvA8XwfbJP7Y/famicons.png'),
//           _buildNavItem(1, 'Home',
//               'https://dashboard.codeparrot.ai/api/image/Z5HohvA8XwfbJP7Y/home.png'),
//           _buildNavItem(2, 'Goals',
//               'https://dashboard.codeparrot.ai/api/image/Z5HohvA8XwfbJP7Y/group.png'),
//         ],
//       ),
//     );
//   }

//   Widget _buildNavItem(int index, String label, String iconUrl) {
//     final isSelected = widget.selectedIndex == index;
//     final color = isSelected ? const Color(0xFFF59D3E) : Colors.black;
//     final backgroundColor =
//         isSelected ? const Color.fromRGBO(243, 142, 34, 1) : Colors.transparent;

//     return GestureDetector(
//       onTap: () => widget.onItemSelected(index),
//       child: Container(
//         width: 90,
//         padding: EdgeInsets.symmetric(vertical: 8),
//         decoration: BoxDecoration(
//           color: backgroundColor,
//           borderRadius: isSelected ? BorderRadius.circular(100) : null,
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Image.network(
//               iconUrl,
//               width: 48,
//               height: 48,
//               color: color,
//             ),
//             SizedBox(height: 8),
//             Text(
//               label,
//               style: TextStyle(
//                 color: color,
//                 fontSize: 20,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class GamesPage extends StatelessWidget {
  final List<Map<String, dynamic>> games = [
    {
      'imageUrl':
          'https://dashboard.codeparrot.ai/api/image/Z5HohvA8XwfbJP7Y/rectangl.png',
      'title': 'Lemonade stand',
      'description':
          'this is a game description which is about lemons becoming juice',
      'points': 100,
      'isGift': true,
    },
    {
      'imageUrl':
          'https://dashboard.codeparrot.ai/api/image/Z5HohvA8XwfbJP7Y/rectangl-2.png',
      'title': 'Coin Collector',
      'description':
          'this is a game description which is about collecting coins',
      'points': 50,
      'isGift': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFFFDE5A),
            Color(0xFFF5A147),
            Color(0xFFF6AE60),
            Color(0xFFF49734),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          HeaderSection(),
          Padding(
            padding: EdgeInsets.only(left: 16.0, top: 16.0),
            child: Text(
              'Increase your points by playing these games',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white.withOpacity(0.8),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                Container(
                  height: 300,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: games.length,
                    itemBuilder: (context, index) => GameCard(
                      imageUrl: games[index]['imageUrl'],
                      title: games[index]['title'],
                      description: games[index]['description'],
                      points: games[index]['points'],
                      isGift: games[index]['isGift'],
                    ),
                  ),
                ),
                UsePointsSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HeaderSection extends StatelessWidget {
  const HeaderSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minWidth: 360,
        minHeight: 80,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Text(
                'Games',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Image.network(
                  'https://dashboard.codeparrot.ai/api/image/Z5HohvA8XwfbJP7Y/famicons.png',
                  width: 48,
                  height: 48,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.25),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Points: 3213',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 8.0),
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.star,
                    color: Color(0xFFF59D3E),
                    size: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class GameCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final int points;
  final bool isGift;

  const GameCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.points,
    required this.isGift,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      constraints: BoxConstraints(minWidth: 300, maxWidth: 574, minHeight: 271),
      decoration: BoxDecoration(
        color: Color(0xFFF7B977),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: 150,
            height: 150,
            margin: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    children: [
                      Text(
                        'Points: $points',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      if (isGift)
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Icon(
                            Icons.card_giftcard,
                            color: Colors.white,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class UsePointsSection extends StatelessWidget {
  final String title;
  final List<Map<String, String>> cards;

  UsePointsSection({
    this.title = 'Use Your Points:',
    this.cards = const [
      {
        'image':
            'https://dashboard.codeparrot.ai/api/image/Z5HohvA8XwfbJP7Y/screensh.png',
        'logo':
            'https://dashboard.codeparrot.ai/api/image/Z5HohvA8XwfbJP7Y/logo.png',
        'points': '3213/1150',
      },
      {
        'image':
            'https://dashboard.codeparrot.ai/api/image/Z5HohvA8XwfbJP7Y/screensh-2.png',
        'logo':
            'https://dashboard.codeparrot.ai/api/image/Z5HohvA8XwfbJP7Y/logo-2.png',
        'points': '3213/1150',
      },
    ],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16.0, bottom: 16.0),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            height: 160,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: cards.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: _buildShopCard(
                    image: cards[index]['image']!,
                    logo: cards[index]['logo']!,
                    points: cards[index]['points']!,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShopCard({
    required String image,
    required String logo,
    required String points,
  }) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.25),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              image,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    points,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Image.network(
                    logo,
                    width: 24,
                    height: 24,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
