import 'package:flutter/material.dart';

import '../../Games/Speak/CatSel.dart';


class LearningPage extends StatelessWidget {
  const LearningPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Learning'),
      ),
      body: Column(
        children: [
          _buildAgeSection(context, '2-3 years'),
          _buildAgeSection(context, '4-5 years'),
          _buildAgeSection(context, '6-10 years'),
        ],
      ),
    );
  }

  Widget _buildAgeSection(BuildContext context, String ageRange) {
    return GestureDetector(
      onTap: () {
        if(ageRange == '2-3 years')
        {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>CategorySelectionScreen()));
        }

      },
      child: Card(
        child: ListTile(
          title: Text(ageRange),
          subtitle: Text('Learning content for $ageRange'),
        ),
      ),
    );
  }
}
