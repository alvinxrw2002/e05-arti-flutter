import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:string_validator/string_validator.dart';
import 'package:e05_arti_flutter/UserProfile/user/user_data.dart';
import 'package:e05_arti_flutter/UserProfile/widgets/appbar_widget.dart';
import 'package:email_validator/email_validator.dart';

// This class handles the Page to edit the Name Section of the User Profile.
class EditNameFormPage extends StatefulWidget {
  const EditNameFormPage({Key? key}) : super(key: key);

  @override
  EditNameFormPageState createState() {
    return EditNameFormPageState();
  }
}

class EditNameFormPageState extends State<EditNameFormPage> {
  final _formKey = GlobalKey<FormState>();
  var user = UserData.myUser;
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController secondNameController = TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();

    super.dispose();
  }

  void updateUserValue(String name) {
    user.name = name;
  }

  void updateUserValueEmail(String email) {
    user.email = email;
  }

  void updateUserValuePhone(String phone) {
    String formattedPhoneNumber = "(" +
        phone.substring(0, 3) +
        ") " +
        phone.substring(3, 6) +
        "-" +
        phone.substring(6, phone.length);
    user.phone = formattedPhoneNumber;
  }

  void updateUserValueAddress(String description) {
    user.address = description;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    Future<void> editProfile(
      String username, String email, String phone, String address) {
    Uri url = Uri.parse("https://arti-pbp-e05.up.railway.app/profileuser/profile-save");
    return request.post("https://arti-pbp-e05.up.railway.app/profileuser/profile-save",
      {
        "username": username,
        "email": email,
        "phone": phone,
        "address": address,
      }
    );
      
  }

    return Scaffold(
        appBar: buildAppBar(context),
        body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                      width: 330,
                      child: Text(
                        "What's Your Name?",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                          padding: EdgeInsets.fromLTRB(0, 40, 16, 0),
                          child: SizedBox(
                              height: 100,
                              width: 150,
                              child: TextFormField(
                                // Handles Form Validation for First Name
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your first name';
                                  } else if (!isAlpha(value)) {
                                    return 'Only Letters Please';
                                  }
                                  return null;
                                },
                                decoration:
                                    InputDecoration(labelText: 'First Name'),
                                controller: firstNameController,
                              ))),
                      Padding(
                          padding: EdgeInsets.fromLTRB(0, 40, 16, 0),
                          child: SizedBox(
                              height: 100,
                              width: 150,
                              child: TextFormField(
                                // Handles Form Validation for Last Name
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your last name';
                                  } else if (!isAlpha(value)) {
                                    return 'Only Letters Please';
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                    labelText: 'Last Name'),
                                controller: secondNameController,
                              )))
                    ],
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: SizedBox(
                            width: 330,
                            height: 50,
                          ))),
                  const SizedBox(
                      width: 320,
                      child: const Text(
                        "What's your email?",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      )),
                  Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: SizedBox(
                          height: 100,
                          width: 320,
                          child: TextFormField(
                            // Handles Form Validation
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email.';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                                labelText: 'Your email address'),
                            controller: emailController,
                          ))),
                  const SizedBox(
                      width: 320,
                      child: Text(
                        "What's Your Phone Number?",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      )),
                  Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: SizedBox(
                          height: 100,
                          width: 320,
                          child: TextFormField(
                            // Handles Form Validation
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your phone number';
                              } else if (isAlpha(value)) {
                                return 'Only Numbers Please';
                              } else if (value.length < 10) {
                                return 'Please enter a VALID phone number';
                              }
                              return null;
                            },
                            controller: phoneController,
                            decoration: const InputDecoration(
                              labelText: 'Your Phone Number',
                            ),
                          ))),
                  SizedBox(
                      width: 350,
                      child: const Text(
                        "What is your address?",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      )),
                  Padding(
                      padding: EdgeInsets.all(20),
                      child: SizedBox(
                          height: 250,
                          width: 350,
                          child: TextFormField(
                            // Handles Form Validation
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.length > 200) {
                                return 'Write your address under 200 characters.';
                              }
                              return null;
                            },
                            controller: addressController,
                            textAlignVertical: TextAlignVertical.top,
                            decoration: const InputDecoration(
                                alignLabelWithHint: true,
                                contentPadding:
                                    EdgeInsets.fromLTRB(10, 15, 10, 100),
                                hintMaxLines: 3,
                                hintText: 'Write Your Address Here!'),
                          ))),
                  Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: SizedBox(
                            width: 320,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate() &&
                                    isAlpha(firstNameController.text +
                                        secondNameController.text) &&
                                    EmailValidator.validate(
                                        emailController.text) &&
                                    isNumeric(phoneController.text)) {
                                  updateUserValue(firstNameController.text +
                                      " " +
                                      secondNameController.text);
                                  updateUserValueEmail(emailController.text);
                                  updateUserValuePhone(phoneController.text);
                                  updateUserValueAddress(
                                      addressController.text);

                                  editProfile(
                                      firstNameController.text +
                                          " " +
                                          secondNameController.text,
                                      emailController.text,
                                      phoneController.text,
                                      addressController.text);

                                  Navigator.pop(context);
                                }
                              },
                              child: const Text(
                                'Update',
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ))),
                ],
              ),
            )));
  }
}
