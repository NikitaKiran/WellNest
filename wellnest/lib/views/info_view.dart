import 'package:flutter/material.dart';


class MentalHealthInfoScreen extends StatelessWidget {
  // Define a list of mental health information.
  final List<MentalHealthInfo> mentalHealthInfoList = [
    MentalHealthInfo(
      title: 'Understanding OCD',
      description:
          'Obsessive-compulsive disorder (OCD) is a mental health condition in which you have frequent unwanted thoughts that cause you to perform repetitive behaviors. Treatment for OCD usually involves psychotherapy and medication. The sooner OCD is diagnosed and treated, the better the outlook.',
      symptoms:
          'Behavioural:   compulsive behaviour, agitation, compulsive hoarding, hypervigilance, impulsivity, meaningless repetition of own words, repetitive movements, ritualistic behaviour, social isolation, or persistent repetition of words or actions\nMood:   anxiety, apprehension, guilt, or panic attack\nPsychological:   depression or fear\n Also common:   food aversion, nightmares, or repeatedly going over thoughts',
      treatments: 'Treatment includes talk therapy, medication or both.',
    ),
    MentalHealthInfo(
      title: 'Understanding Anxiety',
      description:
          'Anxiety is a feeling of fear, dread, and uneasiness. It might cause you to sweat, feel restless and tense, and have a rapid heartbeat. It can be a normal reaction to stress. For example, you might feel anxious when faced with a difficult problem at work, before taking a test, or before making an important decision.',
      symptoms:
          'Intense, excessive and persistent worry and fear about everyday situations.\nFast heart rate, rapid breathing, sweating and feeling tired may occur.',
      treatments:
          'SELF-TREATMENT:\n Physical activity, a healthy diet, regular sleep and relaxation exercises may all help to reduce anxiety. \nJoining a support group may also help.\n To manage symptoms effectively, it\'s best to avoid caffeine, alcohol, and nicotine.\nSEEKING MEDICAL CARE: \nSee a doctor immediately if you: \nAre thinking about suicide. \nCan\'t work or complete activities of daily living. \nMake an appointment to see a doctor if you: \nCan\'t work or maintain relationships. \nAbuse alcohol or other substances. \nFeel sad and slowed down.',
    ),
    MentalHealthInfo(
      title: 'Understanding Burnout',
      description:
          'Burnout is a state of emotional, physical, and mental exhaustion caused by excessive and prolonged stress. It occurs when you feel overwhelmed, emotionally drained, and unable to meet constant demands. As the stress continues, you begin to lose the interest and motivation that led you to take on a certain role in the first place.',
      symptoms:
          'Sense of failure and self-doubt.\n1.   Feeling helpless, trapped, and defeated.\n2.   Detachment, feeling alone in the world.\n3.   Loss of motivation.\n 4.   Increasingly cynical and negative outlook.\n5.   Decreased satisfaction and sense of accomplishment.\n\nBehavioral signs and symptoms of burnout\n\n1.   Withdrawing from responsibilities.\n2.   Isolating from others. \n3.   Procrastinating, taking longer to get things done.\n4.   Using food, drugs, or alcohol to cope. \n5.   Taking frustrations out on others. \n 6.   Skipping work or coming in late and leaving early.',
      treatments:
          'Dealing with burnout requires the “Three R” approach:\nRecognize. Watch for the warning signs of burnout.\nReverse. Undo the damage by seeking support and managing stress.\nResilience. Build your resilience to stress by taking care of your physical and emotional health.',
    ),
    MentalHealthInfo(
      title: 'Understanding Clinical Depression',
      description:
          'Depression is a mood disorder that causes a persistent feeling of sadness and loss of interest in things and activities you once enjoyed. It can also cause difficulty with thinking, memory, eating and sleeping. It’s normal to feel sad about or grieve over difficult life situations, such as losing your job or a divorce. But depression is different in that it persists practically every day for at least two weeks and involves other symptoms than sadness alone.\n NOTE: It requires a medical diagnosis. Do not self-diagnose',
      symptoms:
          'People may experience:\nMood:   anxiety, apathy, general discontent, guilt, hopelessness, loss of interest, loss of interest or pleasure in activities, mood swings, or sadness\nSleep:   early awakening, excess sleepiness, insomnia, or restless sleep\nWhole body:   excessive hunger, fatigue, loss of appetite, or restlessness\nBehavioural:   agitation, excessive crying, irritability, or social isolation\nCognitive:   lack of concentration, slowness in activity, or thoughts of suicide\nWeight:   weight gain or weight loss\nAlso common:   poor appetite or repeatedly going over thoughts',
      treatments:
          'Treatment consists of antidepressants.The mainstay of treatment is usually medication, talk therapy or a combination of the two. Increasingly, research suggests that these treatments may normalise brain changes associated with depression.',
    ),
    MentalHealthInfo(
      title: 'Understanding ADHD',
      description:
          'ADHD or Attention Deficit Disorder is A chronic condition including attention difficulty, hyperactivity and impulsiveness.ADHD often begins in childhood and can persist into adulthood. It may contribute to low self-esteem, troubled relationships and difficulty at school or work. Symptoms include limited attention and hyperactivity. Treatments include medication and talk therapy.',
      symptoms:
          'People may experience:\n\nBehavioural:   aggression, excitability, fidgeting, hyperactivity, impulsivity, irritability, lack of restraint, or persistent repetition of words or actions\nCognitive:   absent-mindedness, difficulty focusing, forgetfulness, problem paying attention, or short attention span\nMood:   anger, anxiety, boredom, excitement, or mood swings\n Also common:   depression or learning disability',
      treatments: 'Treatments include medication and talk therapy.',
    ),
    MentalHealthInfo(
      title: 'Understanding PTSD',
      description:
          'Post-traumatic stress disorder (PTSD) is a mental health condition that is triggered by a terrifying event — either experiencing it or witnessing it. ',
      symptoms:
          'Behavioural:   agitation, irritability, hostility, hypervigilance, self-destructive behaviour, or social isolation\nPsychological:   flashback, fear, severe anxiety, or mistrust\nMood:   loss of interest or pleasure in activities, guilt, or loneliness\nSleep:   insomnia or nightmares\nAlso common:   emotional detachment or unwanted thoughts',
      treatments:
          'Treatment includes different types of psychotherapy as well as medications to manage symptoms.',
    ),
    MentalHealthInfo(
      title: 'Understanding Social Anxiety',
      description:
          'Social anxiety disorder (social phobia) is a medical condition that causes fear and anxiety when you are around people in social situations. People with social anxiety fear being judged or watched by others. ',
      symptoms:
          'Psychological:   depression or fear\nAlso common:   anxiety, palpitations, social isolation, or sweating',
      treatments:
          'Talk therapy and antidepressants can help increase confidence and improve ability to interact with others.',
    ),
    // Add more MentalHealthInfo items here
  ];

MentalHealthInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mental Health Information'),
      ),
      body: ListView.builder(
        itemCount: mentalHealthInfoList.length,
        itemBuilder: (BuildContext context, int index) {
          return MentalHealthCard(
              mentalHealthInfo: mentalHealthInfoList[index]);
        },
      ),
    );
  }
}

class MentalHealthInfo {
  final String title;
  final String description;
  final String symptoms;
  final String treatments;

  MentalHealthInfo({
    required this.title,
    required this.description,
    required this.symptoms,
    required this.treatments,
  });
}

class MentalHealthCard extends StatefulWidget {
  final MentalHealthInfo mentalHealthInfo;

  MentalHealthCard({super.key, required this.mentalHealthInfo});

  @override
  _MentalHealthCardState createState() => _MentalHealthCardState();
}

class _MentalHealthCardState extends State<MentalHealthCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      elevation: 6.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        children: [
          ListTile(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            title: Text(
              widget.mentalHealthInfo.title,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
            trailing: Icon(
              isExpanded ? Icons.expand_less : Icons.expand_more,
              color: Colors.purple,
            ),
          ),
          if (isExpanded)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Description:',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    widget.mentalHealthInfo.description,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    'Symptoms:',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: widget.mentalHealthInfo.symptoms
                        .split('\n')
                        .map((line) => Text(
                              line.trim(),
                              style: const TextStyle(fontSize: 16.0),
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    'Treatments:',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: widget.mentalHealthInfo.treatments
                        .split('\n')
                        .map((line) => Text(
                              line.trim(),
                              style: const TextStyle(fontSize: 16.0),
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
