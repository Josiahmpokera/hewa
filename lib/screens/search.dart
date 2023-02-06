import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hewa/search/result.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Search extends StatefulWidget {
  const Search({super.key});



  @override
  State<Search> createState() => _SearchState();
}

final _formKey = GlobalKey<FormState>();

final TextEditingController _searchCOntroller = TextEditingController();

void validateForm() {
  if (_searchCOntroller.value == "") {
    print("Please Validate the Form");
  } else {
    print(_searchCOntroller.value);
  }
}


class _SearchState extends State<Search> {

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    final superData = _searchCOntroller.text;

  }


  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/bg.png'), fit: BoxFit.cover)),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 25),
                      child: TextField(
                        onSubmitted: (value) {
                          if (value.isEmpty) {
                            return vallSnack();
                          }
                        },
                        style: const TextStyle(color: Colors.white),
                        controller: _searchCOntroller,
                        decoration: InputDecoration(
                            focusColor: Colors.white,
                            hintText: "Enter City name to search",
                            hintStyle: const TextStyle(
                                fontWeight: FontWeight.w100,
                                fontSize: 16,
                                color: Color.fromARGB(255, 227, 223, 223)),
                            enabledBorder: const OutlineInputBorder(
                                borderSide: (BorderSide(
                                    width: 1, color: Colors.white))),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: Colors.white,
                                ))),
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 15),
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.amber)),
                          onPressed: () {
                            // validateForm();
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              Dataa(reg: _searchCOntroller.text);
                              return Result(search: _searchCOntroller.text);
                            }));
                          },
                          child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(22)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.search,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 06,
                                  ),
                                  Text(
                                    "Search",
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              )),
                        )),

                    Text(_searchCOntroller.text),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

void vallSnack() {
  const SnackBar(
    content: Text("Please type County name"),
  );
}
