import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:perikopa_flutter/config/Update.dart';
import 'package:perikopa_flutter/widgets/CustomHeader.dart';

class AproposScreen extends StatefulWidget {
  const AproposScreen({Key? key}) : super(key: key);

  @override
  State<AproposScreen> createState() => _AproposScreenState();
}

class _AproposScreenState extends State<AproposScreen> {
  final int currentYear = DateTime.now().year;

  late double percentage;

  late bool isDownloading;

  @override
  void initState() {
    percentage = 0.0;
    isDownloading = false;
  }

  @override
  Widget build(BuildContext context) {
    // double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
         const CustomHeader(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    // color: Colors.amber
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20.0),
                      const Text(
                        'Perikopa App',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 18.0),
                      const Text(
                        "L'application  s'adresse spécifiquement aux membres de l'Église Apokalipsy, offrant une solution numérique moderne pour la gestion et l'accès aux versets bibliques prévus chaque samedi. Actuellement, la planification des versets pour toute une année est réalisée, et il est nécessaire de numériser ce processus afin d'optimiser l'expérience des utilisateurs au sein de la communauté.",
                        style: TextStyle(
                            fontSize: 14.0,
                            textBaseline: TextBaseline.alphabetic),
                      ),
                      const SizedBox(height: 18.0),
                      const Text(
                          "-	Facilite l'accès aux livres, chapitres et versets bibliques, permettant aux utilisateurs de naviguer intuitivement entre toutes les sections des 66 livres de la Bible, et ce, sans se limiter uniquement aux versets du Perikopa."),
                      const SizedBox(height: 18.0),
                      const Text(
                          "-	 Listage des verses Perikopa des chaque mois."),
                      const SizedBox(height: 18.0),
                      const Text(
                          "-	Pouvoir prendre des notes pour enregistrer des annotations spécifiques."),
                      const SizedBox(height: 24.0),
                      const Text(
                        'Developpeur & Concepteur:',
                        style: TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8.0),
                      const ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage(
                            'assets/images/aina.png',
                          ),
                          radius: 20,
                        ),
                        title: Text(
                          'RAFANDEFERANA Maminiaina Mercia',
                          style: TextStyle(fontSize: 12),
                        ),
                        subtitle: Row(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.email),
                                SizedBox(width: 5),
                                Text(
                                  'merciaaina@gmail.com',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      const Text(
                        'UX & UI Designer',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8.0),
                      const ListTile(
                        leading: CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/images/lucien.jpg'),
                          radius: 20,
                        ),
                        title: Text(
                          'RANDRIAMAHAVELONA Lala Lucien',
                          style: TextStyle(fontSize: 12),
                        ),
                        subtitle: Row(
                          children: [
                            Icon(Icons.email),
                            SizedBox(width: 5),
                            Text(
                              'lucienlala@gmail.com',
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: ElevatedButton(
                          onPressed: isDownloading == false &&percentage<1.0
                              ? () {
                                  Update()
                                      .downloadAndSaveFile((double progress) {
                                    setState(() {
                                      percentage = percentage + progress;
                                    });
                                    // if (percentage < 1.0) {
                                    //   isDownloading = false;
                                    // }
                                  });
                                }
                              : null,
                          child: percentage == 1.0
                              ? const Text('Telechargement avec succées')
                              : const Text('Telecharger le mise a jours'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: LinearPercentIndicator(
                          width: MediaQuery.of(context).size.width - 50,
                          animation: true,
                          lineHeight: 20.0,
                          animationDuration: 2000,
                          percent: percentage,
                          center: Text("${percentage * 100}%"),
                          linearStrokeCap: LinearStrokeCap.roundAll,
                          progressColor: Colors.greenAccent,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '© $currentYear Perikopa',
                            style: const TextStyle(fontSize: 16, color: Colors.grey),
                          )
                        ],
                      ),
                      const SizedBox(height: 16.0),
                    ],
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
