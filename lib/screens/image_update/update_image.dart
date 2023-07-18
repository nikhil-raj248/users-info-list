import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UpdateImage extends StatefulWidget {
  const UpdateImage({Key? key, required this.token}) : super(key: key);

  final String token;

  @override
  State<UpdateImage> createState() => _UpdateImageState();
}

class _UpdateImageState extends State<UpdateImage> {

  XFile? image;
  bool isUpdating = false;
  String? showErrorMessage;
  TextEditingController latController = TextEditingController();
  TextEditingController lonController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButton(color: Colors.white),
          title: const Text("UpdateImageAndLocation"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20,),
              GestureDetector(
                onTap: (){
                  selectImage(true);
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.red,width: 2),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  alignment: Alignment.center,
                  child: Text('Select Image From Gallery',textAlign: TextAlign.center,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                ),
              ),
              const SizedBox(height: 50,),
              GestureDetector(
                onTap: (){
                  selectImage(false);
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.red,width: 2),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  alignment: Alignment.center,
                  child: Text('Capture Image',textAlign: TextAlign.center,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                ),
              ),
              const SizedBox(height: 40,),
              if(image != null)
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text('Selected file -> '+image!.path,textAlign: TextAlign.center,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600),)),

              Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, right: 20, top: 50, bottom: 20),
                child: TextField(
                  controller: latController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                  onChanged: (value) {},
                  decoration: const InputDecoration(
                    hintText: "Enter Latitude",
                    hintStyle: TextStyle(color: Colors.black, fontSize: 18),
                    labelText: "Enter Latitude",
                    labelStyle: TextStyle(color: Colors.black, fontSize: 18),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.black, width: 2)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromRGBO(214, 31, 38, 1), width: 2),
                      //borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, right: 20, top: 20, bottom: 20),
                child: TextField(
                  controller: lonController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                  onChanged: (value) {},
                  decoration: const InputDecoration(
                    hintText: "Enter Longitude",
                    hintStyle: TextStyle(color: Colors.black, fontSize: 18),
                    labelText: "Enter Longitude",
                    labelStyle: TextStyle(color: Colors.black, fontSize: 18),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.black, width: 2)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromRGBO(214, 31, 38, 1), width: 2),
                      //borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                ),
              ),


              if(isUpdating)
                const CircularProgressIndicator(color: Colors.red,),

              const SizedBox(height: 30,),

              if(image != null && latController.value.text.isNotEmpty && lonController.value.text.isNotEmpty)
                GestureDetector(
                  onTap: (){
                    updateImage();
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.red,width: 2),
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: const Text('upload Image',textAlign: TextAlign.center,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                  ),
                ),

              if (showErrorMessage != null)
                Container(
                    margin: const EdgeInsets.all(40),
                    child: Text(
                      showErrorMessage!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.red,
                          fontWeight: FontWeight.w600),
                    )),
            ],
          ),
        ),
      ),
    );
  }

  void selectImage(bool isFromGallery) async{
    final ImagePicker picker = ImagePicker();
    image = await picker.pickImage(source: (isFromGallery)?ImageSource.gallery:ImageSource.camera);
    setState(() {});
  }

  void updateImage() async{
    setState(() {
      isUpdating = true;
      showErrorMessage = null;
    });
    var dio = Dio();
    var token = widget.token;
    dio.options.headers['Authorization'] = 'Bearer $token';
    Map<String, dynamic>  data = {
      "location": json.encode({
        "location":{
          "latitude":latController.value.text,
          "longitude":lonController.value.text
        }
      }),
      'image': await MultipartFile.fromFile(image!.path, filename: image!.path.split('/').last)
    };
    try {
      FormData formData = new FormData.fromMap(data);
      var response = await dio.patch('https://flutter.magadh.co/api/v1/users',data: formData);
      setState(() {
        isUpdating = false;
      });
      Navigator.of(context).popUntil((route) => route.isFirst);
    } catch (e) {
      DioException temp = e as DioException;
      setState(() {
        isUpdating = false;
        showErrorMessage = temp.response?.statusMessage;
      });
    }
  }
}
