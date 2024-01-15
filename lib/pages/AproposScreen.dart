import 'package:flutter/material.dart';

class AproposScreen extends StatefulWidget {
  const AproposScreen({Key? key}) : super(key: key);

  @override
  State<AproposScreen> createState() => _AproposScreenState();
}

class _AproposScreenState extends State<AproposScreen> {
  final int currentYear = DateTime.now().year;
  @override
  Widget build(BuildContext context) {
    // double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height * 0.4,
            pinned: true,
            stretch: true,
            backgroundColor: Theme.of(context).colorScheme.primary,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.all(0),
              stretchModes: const [StretchMode.zoomBackground],
              title: Container(
                padding: const EdgeInsets.only(left: 20, top: 15),
                height: 56,
                width: screenWidth,
                // color: Colors.white,
                child: const Text(
                  'À propos de l\'application',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              background: Image.asset(
                'assets/images/adult.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    // color: Colors.amber
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.0),
                      Text(
                        'Perikopa App',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 18.0),
                      Text(
                        "L'application  s'adresse spécifiquement aux membres de l'Église Apokalipsy, offrant une solution numérique moderne pour la gestion et l'accès aux versets bibliques prévus chaque samedi. Actuellement, la planification des versets pour toute une année est réalisée, et il est nécessaire de numériser ce processus afin d'optimiser l'expérience des utilisateurs au sein de la communauté.",
                        style: TextStyle(
                            fontSize: 14.0,
                            textBaseline: TextBaseline.alphabetic),
                      ),
                      SizedBox(height: 18.0),
                      Text(
                          "-	Facilite l'accès aux livres, chapitres et versets bibliques, permettant aux utilisateurs de naviguer intuitivement entre toutes les sections des 66 livres de la Bible, et ce, sans se limiter uniquement aux versets du Perikopa."),
                      SizedBox(height: 18.0),
                      Text("-	 Listage des verses Perikopa des chaque mois."),
                      SizedBox(height: 18.0),
                      Text(
                          "-	Pouvoir prendre des notes pour enregistrer des annotations spécifiques."),
                      SizedBox(height: 24.0),
                      Text(
                        'Developpeur & Concepteur:',
                        style: TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8.0),
                      ListTile(
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
                      SizedBox(height: 16.0),
                      Text(
                        'UX & UI Designer',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8.0),
                      ListTile(
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
                      SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '© 2024 Perikopa',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          )
                        ],
                      ),
                      SizedBox(height: 16.0),
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
