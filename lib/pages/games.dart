import 'package:flutter/material.dart';
import '../lemonade.dart';

class GamesPage extends StatelessWidget {
  final List<Map<String, dynamic>> games = [
    {
      'imageUrl':
          'https://dashboard.codeparrot.ai/api/image/Z5HohvA8XwfbJP7Y/rectangl.png',
      'title': 'Lemonade stand',
      'description': 'it is about lemons becoming juice',
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
    {
      'imageUrl':
          'https://dashboard.codeparrot.ai/api/image/Z5HohvA8XwfbJP7Y/rectangl-3.png',
      'title': 'Treasure Hunt',
      'description':
          'this is a game description which is about finding treasures',
      'points': 75,
      'isGift': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFFF9500), // Set the background color to #F7B14C
        child: Column(
          children: [
            HeaderSection(),
            Padding(
              padding: EdgeInsets.only(
                left: 16.0,
                top: 16.0,
                right: 16.0,
                bottom: 16.0,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Increase your points by playing these games',
                  style: TextStyle(
                    fontSize: 28, // Enlarged font size
                    color: Colors.white.withOpacity(0.9),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16), // Added padding below the text
            Expanded(
              child: ListView(
                children: [
                  Container(
                    height: 300, // Adjusted height for larger images
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: games.length,
                      itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: GameCard(
                          imageUrl: games[index]['imageUrl'],
                          title: games[index]['title'],
                          description: games[index]['description'],
                          points: games[index]['points'],
                          isGift: games[index]['isGift'],
                        ),
                      ),
                    ),
                  ),
                  UsePointsSection(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HeaderSection extends StatefulWidget {
  const HeaderSection({Key? key}) : super(key: key);

  @override
  _HeaderSectionState createState() => _HeaderSectionState();
}

class _HeaderSectionState extends State<HeaderSection> {
  int eggState = 1; // Tracks the current egg state (1, 2, 3)
  bool isEggBroken = false; // Indicates if the egg has broken

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minWidth: 360,
        minHeight: 140, // Increased height for better spacing
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Games Title
          Row(
            children: [
              Text(
                'Games',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  height: 1.2,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 2.0),
                child: Image.asset(
                  'assets/images/W.png',
                  width: 100, // Adjust the width if necessary
                  height: 100, // Adjust the height if necessary
                  // Apply color if you want to tint the image
                ),
              ),
            ],
          ),

          // Right Section: Egg + Points
          Row(
            children: [
              // Interactive Egg or Secret Message
              GestureDetector(
                onTap: () {
                  if (!isEggBroken) {
                    setState(() {
                      eggState++;
                      if (eggState > 3) {
                        isEggBroken = true; // Egg breaks
                      }
                    });
                  }
                },
                child: isEggBroken
                    ? ClipRRect(
                        borderRadius:
                            BorderRadius.circular(10), // Rounded edges
                        child: Container(
                          width: 300, // Increased size significantly
                          height: 100,
                          child: Image.asset(
                            'assets/images/secretemessage.png',
                            fit: BoxFit.contain, // Ensures full visibility
                          ),
                        ),
                      )
                    : Image.asset(
                        'assets/images/egg$eggState.${eggState == 1 ? "GIF" : "png"}',
                        width: 120, // Increased egg size
                        height: 120,
                        fit: BoxFit.contain,
                      ),
              ),

              SizedBox(width: 20), // Space between egg and points box

              // Points Box
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
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 8.0),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.1),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          // Add your onPressed functionality here
                        },
                        child: Image.asset(
                          'assets/images/Vector.png',
                          height: 24.0, // Adjust the size as needed
                          width: 24.0, // Adjust the size as needed
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
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
    return GestureDetector(
      onTap: () {
        if (title == 'Lemonade stand') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LemonadeGame()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Game "$title" is not yet implemented!')),
          );
        }
      },
      child: Container(
        width: 500, // Adjusted width for larger images
        height: 300, // Adjusted height for larger images
        decoration: BoxDecoration(
          color: Colors.white, // Changed background to white
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: Offset(0, 4), // Subtle shadow for depth
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 254, // Set image width to 254
              height: 254, // Set image height to 254
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFFF9500), // Orange text
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Game',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFFF9500)
                            .withOpacity(0.7), // Lighter orange
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFFF9500)
                            .withOpacity(0.8), // Slightly darker orange
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Text(
                          '+$points',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFFFF9500), // Orange for points
                          ),
                        ),
                        if (isGift) ...[
                          SizedBox(width: 8),
                          Icon(
                            Icons.card_giftcard,
                            color: Color(0xFFFF9500), // Orange gift icon
                            size: 30,
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
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
      {
        'image':
            'https://dashboard.codeparrot.ai/api/image/Z5HohvA8XwfbJP7Y/screensh-3.png',
        'logo':
            'https://dashboard.codeparrot.ai/api/image/Z5HohvA8XwfbJP7Y/logo-3.png',
        'points': '3213/1500',
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
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: cards.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(right: 16.0),
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
      width: 600, // Increased the width of the points card
      height: 200, // Kept the height the same
      decoration: BoxDecoration(
        color: Colors.white, // Card background set to white
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 4), // Subtle shadow for depth
          ),
        ],
      ),
      child: Stack(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  image,
                  width: 150, // Adjusted image width to fit wider card
                  height: 200, // Matches the container height
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        logo,
                        width: 120, // Adjusted logo width for wider card
                        height: 50, // Slightly larger height for the logo
                        fit: BoxFit.contain,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Enjoy a 30% OFF on Kids Entry Ticket!',
                        style: TextStyle(
                          fontSize: 18, // Slightly larger font size
                          color: Color(0xFFFF9500), // Orange text
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 8,
            right: 8,
            child: Text(
              points,
              style: TextStyle(
                fontSize: 18, // Slightly larger font size
                color: Color(0xFFFF9500), // Orange for points
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
