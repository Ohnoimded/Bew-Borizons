// Defines task adder window, task editor window

import 'package:flutter/material.dart';
import 'package:todo/utilities/button_widget.dart';

class DialogBox extends StatelessWidget {
  final TextEditingController controllerTitle;
  final TextEditingController controllerDesc;
  final bool createOrEdit;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final GlobalKey<FormState> formKey;

  const DialogBox({
    super.key,
    required this.controllerTitle,
    required this.controllerDesc,
    required this.onSave,
    required this.onCancel,
    required this.createOrEdit,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        createOrEdit ? "Create Task" : "Edit Task",
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: const Color.fromARGB(255, 32, 32, 32),
      content: SizedBox(
        height: 240,
        width: 250,
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // FIrst Input
              TextFormField(
                style: TextStyle(color: Colors.white),
                autofocus: true,
                controller: controllerTitle,
                validator: (value) {
                  // Validation to avoid overflow and unwanted sizes
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title!';
                  } else if (value.length > 40) {
                    return 'Not more than 40 characters!';
                  } return null;
                },
                // Styling for the input boxes
                decoration: InputDecoration(
                    labelText: "Task Title",
                    labelStyle: TextStyle(color: Colors.grey),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 2.0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey, width: 3)),
                    hintText: "Type here",
                    hintStyle: TextStyle(color: Colors.white24)),
              ),

              // Second input
              TextFormField(
                style: TextStyle(color: Colors.white),

                controller: controllerDesc,
                validator: (value) {
                  // Validation to avoid overflow and unwanted sizes
                  if (value != null && value.length > 400) {
                    return 'Not more than 400 characters!';
                  } return null;
                },
                maxLines: null, // will dynamically increase the size of the input box

                // Styling for the input boxes
                decoration: InputDecoration(
                    labelText: "Task Description",
                    labelStyle: TextStyle(color: Colors.grey),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 2.0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    fillColor: Colors.amber,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    hintText: "Type here",
                    hintStyle: TextStyle(color: Colors.white24)),
              ),

              //Button row
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ButtonWidget(onPressed: onSave, text: "Save"), // SAve button
                  const SizedBox(width: 8),
                  ButtonWidget(onPressed: onCancel, text: "Cancel"), // Cancel Button
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
