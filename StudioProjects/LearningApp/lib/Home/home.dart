import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:learningapp/Home/games/gameh.dart';
import 'learn/learn.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 12,),
            const Text(
              'Learn English Easily:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            CarouselSlider(
              items: [
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://images-eds-ssl.xboxlive.com/image?url=4rt9.lXDC4H_93laV1_eHM0OYfiFeMI2p9MWie0CvL99U4GA1gf6_kayTt_kBblFwHwo8BW8JXlqfnYxKPmmBRA5PxOPgA1t5gL880fa1uFuYG3sSc635gxez60Elk4Y.5bj_Q2UsOLyyRcpQWYC1c119MQp0xRzAEoW2eMoVQo-&format=source&h=576',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://img.freepik.com/free-vector/flat-back-school-background_52683-88370.jpg',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://play-lh.googleusercontent.com/O1J6mcabIENe6PN9prEEEPedlw_pI1-H_4pAOHrGvrTntop3mNqRf8Cv0ziFuTJVlp8=w526-h296-rw',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
              options: CarouselOptions(
                // autoPlay: true,
                aspectRatio: 16 / 9,
                viewportFraction: 1.0,
                enlargeCenterPage: false,
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Select Category:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true, // Added this line
              children: [
                _buildCategoryCard(context, "Learning", "Learn English more easily"),
                _buildCategoryCard(context, "Games", "Interactive games to play"),
              ],
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                  child: Image.network('https://www.shutterstock.com/image-vector/cartoon-fruits-characters-on-summer-260nw-2204875377.jpg')),
            )
          ],
        ),
      ),
    );
  }
}

Widget _buildCategoryCard(BuildContext context, String title, String description) {
  return GestureDetector(
    onTap: () {
      if (title == 'Learning') {
        Navigator.push(context, MaterialPageRoute(builder: (context) => LearningPage()));
      } else if (title == 'Games') {
        Navigator.push(context, MaterialPageRoute(builder: (context) => GameHomePage()));
      }
    },
    child: Card(
      child: Column(
        children: [
          const SizedBox(height: 10,),
          const Icon(Icons.sports_basketball_sharp),
          Text(title, style: const TextStyle(fontSize: 25, color: Colors.deepPurple),),
          const SizedBox(height: 10,),
          Text(description)
        ],
      ),
    ),
  );
}



