import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OneMonthScreen extends StatefulWidget {
  final String monthName;
  final String faneva;

  const OneMonthScreen(
      {Key? key, required this.monthName, required this.faneva})
      : super(key: key);

  @override
  State<OneMonthScreen> createState() => _OneMonthScreenState();
}

class _OneMonthScreenState extends State<OneMonthScreen> {
  List<bool> boutonClique = List.generate(4, (index) => false);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(0.0),
              child: Container(
                height: 20,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Container(
                  height: 5,
                  width: 30,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                ),
              ),
            ),
            expandedHeight: MediaQuery.of(context).size.height * 0.4,
            pinned: true,
            stretch: true,
            elevation: 5,
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarBrightness: Brightness.dark,
            ),
            backgroundColor: Theme.of(context).colorScheme.primary,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.all(0),
              stretchModes: const [StretchMode.zoomBackground],
              title: Container(
                padding: const EdgeInsets.only(left: 40, top: 15),
                height: 56,
                width: screenWidth,
                child: Text(
                  widget.monthName,
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              background: Image.asset(
                'assets/images/adult.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                children: [
                  Text(
                    "${widget.faneva} lorem lorem lorem lorem lorem lore lorem lorem lorem lorem lorem lorem lorem lorem lorem",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "26 Avril 2024",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      Icon(
                        Icons.heart_broken,
                        color: Theme.of(context).colorScheme.primary,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Divider(
                    height: 1,
                    color: Color.fromARGB(255, 231, 229, 229),
                  ),
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Text(
                            "Loha-hevitra",
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "lorem lbalzeb albzfkbl azlfbazlbf labzlfbalzf aklbzsfbazlbfa zlabflabzfa falbzflabzf fzlabfa fzalbfz; zflbz;f lbazlfblaflabzf labzflbalzf zlbflabzf zfkbzeibazfa kabzf",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      const Row(
                        children: [
                          Text(
                            "Perikopa",
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ExpansionPanelList(
                        dividerColor: Colors.grey,
                        elevation: 1,
                        expandedHeaderPadding: EdgeInsets.zero,
                        expansionCallback: (int index, bool isExpanded) {
                          setState(() {
                            boutonClique[index] = isExpanded;
                          });
                          print("INDEX ${boutonClique[index]} ${index}");
                        },
                        children: List.generate(
                          4,
                          (index) {
                            return ExpansionPanel(
                              backgroundColor: Colors.white,
                              
                              headerBuilder:
                                  (BuildContext context, bool isExpanded) {
                                return buildContainerHeader(index);
                              },
                              body: buildContainerBody(index),
                              isExpanded: boutonClique[index],
                            );
                          },
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

  Widget buildContainerHeader(int index) {
    return Container(
      decoration: BoxDecoration(
        // color: Colors.amber,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            Icons.check,
            color: Colors.green,
          ),
          SizedBox(width: 10),
          Text("SABATA LE 26 Septembre 2024"),
          // IconButton(
          //   onPressed: () {
          //     setState(() {
          //       boutonClique[index] = !boutonClique[index];
          //     });
          //   },
          //   icon: Icon(
          //     boutonClique[index] ? Icons.expand_less : Icons.expand_more,
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget buildContainerBody(int index) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(children: [
        Row(
          children: [
            Text(
              "Body content for item $index",
              style: TextStyle(color: Colors.grey),
            )
          ],
        )
      ]),
    );
  }
}
