import 'package:flutter/material.dart';

class classa extends StatefulWidget {
  const classa({super.key});

  @override
  State<classa> createState() => _classaState();
}

class _classaState extends State<classa> {
  List<Celas> classes = [];

  void addClass(Celas celas) {
    setState(() {
      classes.add(celas);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "lib/asset/images/casey-horner-4rDCa5hBlCs-unsplash.jpg",
            ),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black26, BlendMode.darken),
          ),
        ),
        padding: EdgeInsets.fromLTRB(
          MediaQuery.of(context).size.height / 25,
          MediaQuery.of(context).size.height / 10,
          MediaQuery.of(context).size.height / 25,
          MediaQuery.of(context).size.height / 25,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Your Classes",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => AddClassBottomSheet(
                        addClassCallback: addClass,
                      ),
                      isScrollControlled: true,
                    );
                  },
                  child: const Row(
                    children: [
                      Text(
                        "Add Class",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                      SizedBox(width: 16),
                      Icon(
                        Icons.add,
                        color: Colors.cyan,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: classes.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white60,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.cyan.shade100,
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.school,
                                    size: 30, color: Colors.cyan),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Class ${index + 1}',
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      const Divider(
                                        color: Colors.cyan,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            const Row(
                              children: [
                                Icon(Icons.numbers,
                                    size: 20, color: Colors.cyan),
                                SizedBox(width: 8),
                                Text(
                                  "Credit: 3",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            const Row(
                              children: [
                                Icon(Icons.class_,
                                    size: 20, color: Colors.cyan),
                                SizedBox(width: 8),
                                Text(
                                  "Assignment: 5",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            const Row(
                              children: [
                                Icon(Icons.star,
                                    size: 20, color: Colors.cyan),
                                SizedBox(width: 8),
                                Text(
                                  "Best Student: Ali Alavi",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddClassBottomSheet extends StatefulWidget {
  final Function(Celas) addClassCallback;

  const AddClassBottomSheet({super.key, required this.addClassCallback});

  @override
  State<AddClassBottomSheet> createState() => _AddClassBottomSheetState();
}

class _AddClassBottomSheetState extends State<AddClassBottomSheet> {
  TextEditingController codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Add New Class',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.cyan,
            ),
          ),
          TextFormField(
            controller: codeController,
            decoration: InputDecoration(
              labelText: "Enter Class Code",
              labelStyle: TextStyle(
                fontSize: 18,
                color: Colors.grey[700],
              ),
              filled: true,
              fillColor: Colors.grey[200],
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.cyan),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.cyan),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              final celas = Celas();
              widget.addClassCallback(celas);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
            ),
            child: const Text(
              'Add Class',
              style: TextStyle(fontSize: 18),
            ),
          ),
          const SizedBox(
            height: 40,
          )
        ],
      ),
    );
  }
}

class Celas {}
