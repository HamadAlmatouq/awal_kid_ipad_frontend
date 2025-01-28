import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../lemonade.dart';

class GamesPage extends StatelessWidget {
  final List<Map<String, dynamic>> games = [
    {
      'imagePath': 'assets/images/LMN.png',
      'title': 'Lemonade stand',
      'description': 'It is about lemons becoming juice',
      'points': 100,
      'isGift': true,
      'isComingSoon': false,
    },
    {
      'imagePath': 'assets/images/COINC.png',
      'title': 'Coin Collector',
      'description': 'This is a game about collecting coins',
      'points': 50,
      'isGift': true,
      'isComingSoon': true,
    },
    {
      'imagePath': 'assets/images/INVQ.png',
      'title': 'Investment Quiz',
      'description': 'Test your knowledge about investments',
      'points': 75,
      'isGift': true,
      'isComingSoon': true,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFFFF9500), // Set the background color
        child: Column(
          children: [
            HeaderSection(),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Increase your points by playing these games',
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.white.withOpacity(0.9),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16), // Added padding below the text
            Expanded(
              child: ListView(
                children: [
                  SizedBox(
                    height: 300, // Adjusted height for larger images
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: games.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: GameCard(
                          imagePath: games[index]['imagePath'],
                          title: games[index]['title'],
                          description: games[index]['description'],
                          points: games[index]['points'],
                          isGift: games[index]['isGift'],
                          isComingSoon: games[index]['isComingSoon'],
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
                'Games ',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  height: 1.2,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 2.0),
                child: Icon(
                  Icons.videogame_asset, // Joystick icon
                  size: 80, // Adjusted to match the original image size
                  color: Colors.white, // Matches the theme color
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
  final String imagePath;
  final String title;
  final String description;
  final int points;
  final bool isGift;
  final bool isComingSoon;

  const GameCard({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.description,
    required this.points,
    required this.isGift,
    required this.isComingSoon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!isComingSoon && title == 'Lemonade stand') {
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
      child: Stack(
        children: [
          Container(
            width: 500,
            height: 300,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 180,
                  height: 300,
                  margin: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: AssetImage(imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFFF9500),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          description,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Text(
                              '+$points',
                              style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFFF9500),
                              ),
                            ),
                            if (isGift) ...[
                              const SizedBox(width: 8),
                              const Icon(
                                Icons.card_giftcard,
                                color: Color(0xFFFF9500),
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
          if (isComingSoon)
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 71, 71, 71),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: const Text(
                  'Coming Soon',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
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
        'brand': 'Dabdoob',
        'image': 'assets/images/dabdoobi.png',
        'logo': 'assets/images/dabdob.png',
        'description': 'Get 20% OFF on your next toy purchase!',
      },
      {
        'brand': 'Kidzania',
        'image': 'assets/images/kidzaniai.png',
        'logo': 'assets/images/kids.png',
        'description': 'Enjoy 30% OFF on Kids Entry Ticket!',
      },
      {
        'brand': 'SEPHORA',
        'image': 'assets/images/sephorai.png',
        'logo': 'assets/images/sephora.png',
        'description': 'Redeem your points for a free beauty sample!',
      },
    ],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: cards.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: _buildShopCard(
                    brand: cards[index]['brand']!,
                    image: cards[index]['image']!,
                    logo: cards[index]['logo']!,
                    description: cards[index]['description']!,
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
    required String brand,
    required String image,
    required String logo,
    required String description,
  }) {
    return Container(
      width: 560,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
            child: Image.asset(
              image,
              width: 150,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    logo,
                    width: 100,
                    height: 50,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    brand,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFF9500),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
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
