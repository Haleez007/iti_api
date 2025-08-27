import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/counter_cubit.dart';
import 'cubit/counter_state.dart';

class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({super.key});

  @override
  State<ImagePickerScreen> createState() => _ImagePickerState();
}

class _ImagePickerState extends State<ImagePickerScreen> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Picker with Counter'),
        centerTitle: true,
      ),
      body: Padding(padding: EdgeInsets.symmetric(vertical: 14,horizontal: 14),
     child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey, width: 2),
                  color: Colors.grey[200],
                ),
                child: _image == null
                    ? const Icon(Icons.add_a_photo, size: 40, color: Colors.grey)
                    : ClipOval(
                        child: Image.file(_image!, fit: BoxFit.cover),
                      ),
              ),
            ),
            const SizedBox(height: 40),
            
            BlocBuilder<CounterCubit, CounterState>(
              builder: (context, state) {
                final counter = state.counter;

                Color counterColor = Colors.black;

                // Check the type of state to determine the color
                if (state is IncrementCounter) {
                  return Text("${state.counter}",style: TextStyle(color: Colors.green),);
                } else if (state is DecrementCounter) {
                  return Text("${state.counter}",style: TextStyle(color: Colors.red),);
                }

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () => context.read<CounterCubit>().increment(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(200, 50),
                      ),
                      icon: const Icon(Icons.add),
                      label: const Text('Increment'),
                    ),
                    
                    const SizedBox(height: 20),

                    Text(
                      '$counter',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: counterColor,
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Decrement Button
                    ElevatedButton.icon(
                      onPressed: () => context.read<CounterCubit>().decrement(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(200, 50),
                      ),
                      icon: const Icon(Icons.remove),
                      label: const Text('Decrement'),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
      ),);
  }
}