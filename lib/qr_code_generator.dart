
import 'package:canvanime/qr_code.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'dart:async';
//import 'dart:convert' show utf8, base64;
import 'dart:typed_data';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:file_selector/file_selector.dart';

import 'package:canvanime/provider/DarkThemeProvider.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
class QrCodeGen extends StatefulWidget {
  @override
  _QrCodeGenState createState() => _QrCodeGenState();
}

class _QrCodeGenState extends State<QrCodeGen> {
  //Color
  Color currentColor = Colors.black;
  List<Color> currentColors = [Colors.black, Colors.black45];

  void changeColor(Color color) => setState(() => currentColor = color);
  void changeColors(List<Color> colors) => setState(() => currentColors = colors);
  GlobalKey<FormState> _dataKey = GlobalKey<FormState>();

  TextEditingController _dataController = TextEditingController();
  String? data;
  String? dropValue2='100';
  String? dropValue1='1';
  String? dropValue3='L';
  bool? roundEyes=false;
  int? typenumber=1;
  double? qrsize=300;
  int? errorcorrectlevel=1;
  Qr_code? qrCode;
  bool? okGen=false;


  String? fileName;
  String? filePath="null";
  String? imgPath;
  //Uint8List? bytes;
  //Uint8List? imagee;
// Add logo to Qr Code
  void _openImageFile(BuildContext context) async {
    final XTypeGroup typeGroup = XTypeGroup(
      label: 'images',
      extensions: ['png'],
    );
    final List<XFile> files = await openFiles(acceptedTypeGroups: [typeGroup]);
    if (files.isEmpty) {
      // Operation was canceled by the user.
      return;
    }
    final XFile file = files[0];
    fileName = file.name;
    filePath = file.path;



    await showDialog(
      context: context,
      builder: (context) => ImageDisplay(fileName!, filePath!),
    );
  }
  //Future method to build the Qr Code
  Future<void> _generate (Color color, String image,int typeNumber, double size, String data, int errorCorrectLevel, bool roundEdges) async {

    //
     qrCode = new Qr_code(
        elementColor: color,
        image: image,
        typeNumber: typeNumber,
        size: size,
        data: data,
        errorCorrectLevel:errorCorrectLevel,
        roundEdges: roundEdges,
      );
     setState(()  {

           print("Qr_code generated.");


          okGen=true;
          filePath="null";
          fileName="";

     });



  }




  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider?.of<DarkThemeProvider>(context);



    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      // Drawer Start
      drawer: Drawer(
        child: ListView(
          children: <Widget>[

            ListTile(
              leading: themeProvider.darkTheme
                  ?Icon(

                Icons.nights_stay,
                color: Colors.blueGrey,
              )

                  :Icon(

                Icons.wb_sunny,
                color: Colors.amberAccent,
              ) ,
              title: Text("Dark Mode"),
              //Dark mode switch
              trailing:CupertinoSwitch(
                  value: themeProvider.darkTheme,
                  onChanged: (bool? value) {
                    themeProvider.darkTheme = value!;
                  }),
            ),

          ],
        ),
      ),
      // Drawer ends
      appBar: AppBar(
        titleSpacing: 2.0,
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text("QR DIGY" ,style: TextStyle( fontSize:25, color: themeProvider.darkTheme?Color.fromRGBO(187, 134, 252, 0.60):Color.fromRGBO(68,44,46, 1.0), fontWeight: FontWeight.bold, fontFamily:'Pacifico'),),
        // Showing Cart Icon
        actions: <Widget>[

        ],
      ),
      body:LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          //to have responsive design
          if (constraints.maxWidth > 600) {
            return _buildWideContainers();
          } else {
            return _buildNormalContainer();
          }
        },
      ),



    );
  }



//if screen maxWidth < 600 px
  Widget _buildNormalContainer() {
    final themeProvider = Provider?.of<DarkThemeProvider>(context);
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: okGen!? Container(
                          padding: EdgeInsets.all(10.0),
                          alignment: Alignment.center,
                          child:qrCode):Container(

                        alignment: Alignment.center,
                        child:Column(
                          children: <Widget>[
                            Text(
                              "Your Qr Code will be displayed here",
                              style: TextStyle(fontWeight: FontWeight.bold,
                                color:  themeProvider.darkTheme?Color.fromRGBO(187, 134, 252, 0.60):Color.fromRGBO(68,44,46, 1.0),
                                fontSize: 18.0,
                                fontFamily:'Goldman',
                              ),
                            ),
                            Image.asset(
                              "images/qrcoka.gif",
                              height: MediaQuery.of(context).size.height*0.6,
                              width: MediaQuery.of(context).size.width*0.90,
                            ),
                          ],
                        ),
                        padding: EdgeInsets.all(3.0),
                      ),
                    ),
                    //WHAT IS QR-CODE?
                    Container(
                        width: MediaQuery.of(context).size.width*0.90,

                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                        child:Column(
                          children: <Widget>[
                            Text(
                                "What is a QR Code?"
                                ,
                                style: TextStyle(
                                  color:themeProvider.darkTheme?Color.fromRGBO(187, 134, 252, 0.60):Color.fromRGBO(68,44,46, 1.0),
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Goldman',
                                  // fontStyle: FontStyle.italic,
                                )
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text("A QR code consists of black squares arranged in a square grid on a white background, which can be read by an imaging device such as a camera, and processed using Reed–Solomon error correction until the image can be appropriately interpreted."
                                " The required data is then extracted from patterns that are present in both horizontal and vertical components of the image.(Wikipedia)",
                              style: TextStyle(

                                color:themeProvider.darkTheme?  Colors.white70:Color.fromRGBO(68,44,46, 1.0),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Goldman',
                                // fontStyle: FontStyle.italic,
                              ),
                              textAlign: TextAlign.justify,
                            )

                          ],
                        )
                    )
                    //Padding(
                    //padding: const EdgeInsets.only(left: 5.0, top: 20.0, bottom: 20.0),
                    //child:

                    //  ),
                  ],
                ),
              ),
              Container(

                // color:Color.fromRGBO(254,219,208, 0.80),
                width: MediaQuery.of(context).size.width*0.95,
                child:AutofillGroup(


                    child: Form(
                      key: _dataKey,
                      //autovalidateMode: AutovalidateMode.always,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Card(

                          color:themeProvider.darkTheme? Color.fromRGBO(33, 33, 33, 1.0):Color.fromRGBO(215, 204, 200, 1.0),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text("GENERATE YOUR QR CODE",style:TextStyle(fontFamily:'Goldman', fontWeight: FontWeight.w800,fontSize: 20, color: themeProvider.darkTheme?Color.fromRGBO(187, 134, 252, 0.60):Color.fromRGBO(68,44,46, 1.0),),),
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                                child: Material(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.grey.withOpacity(0.3),
                                  elevation: 0.0,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top:15.0,right: 14,left: 14,bottom: 8),
                                    child:
                                    TextFormField(
                                      controller: _dataController,
                                      autofillHints: [AutofillHints.name],
                                      keyboardType: TextInputType.name,
                                      textAlign: TextAlign.center,
                                      onChanged: (value) {
                                        data = value;
                                      },
                                      decoration: InputDecoration(
                                        hintText: "Enter your website url or your text here",
                                        labelText: "Enter your website url or your text here",
                                        hintStyle: TextStyle(fontSize: 15,color: Color.fromRGBO(68,44,46, 1.0)) ,
                                        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                      ),
                                      cursorColor:Colors.blue,
                                      //A enlever ou non?
                                      inputFormatters: [
                                        FilteringTextInputFormatter.deny(RegExp(r"\d+([\.]\d+)?")),

                                      ],
                                      // ignore: missing_return
                                      //à enlever ou non?
                                      validator: (value) {
                                        if (value!.isEmpty) {

                                          RegExp regex = new RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
                                          if (!regex.hasMatch(value))
                                            return 'Please enter your website url or your text here';
                                          else
                                            return null;
                                        }
                                      },
                                      onSaved: (value) {
                                        _dataController.text = value!;
                                      },
                                      autocorrect: true,



                                    ),),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(15.0),
                                child: MaterialButton(
                                  onPressed: () {},
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "TYPE NUMBER :",
                                        style: TextStyle(

                                            color:themeProvider.darkTheme?Color.fromRGBO(187, 134, 252, 0.60):Color.fromRGBO(68,44,46, 1.0),
                                            fontWeight: FontWeight.bold,
                                            fontFamily:'Goldman',
                                            fontSize: 16.0),
                                      ),
                                      SizedBox(
                                        width: 28.0,
                                      ),
                                      // Spacer(flex: 2,),
                                      DropdownButton<String>(
                                        dropdownColor:  themeProvider.darkTheme?Color.fromRGBO(33, 33, 33, 0.78):Color.fromRGBO(254,219,208, 0.90),
                                        value: dropValue1,
                                        icon: Icon(Icons.keyboard_arrow_down_sharp),
                                        iconSize: 24,
                                        elevation: 16,
                                        style: TextStyle(color: Colors.redAccent),
                                        underline: Container(
                                          height: 2,
                                          color:themeProvider.darkTheme?Color.fromRGBO(187, 134, 252, 0.60):Color.fromRGBO(68,44,46, 1.0),
                                        ),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            dropValue1= newValue;

                                            typenumber=int.parse(dropValue1!);
                                            print(typenumber);
                                          });
                                        },
                                        items:<String>['1', '2', '3', '4','5','6','7','8','9','10'].map<DropdownMenuItem<String>>((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      )

                                    ],
                                  ),
                                ),
                              ),





                              SizedBox(
                                height: 10.0,
                              ),
                              Container(
                                padding: EdgeInsets.all(15.0),
                                // alignment: FractionalOffset.topLeft,
                                child: MaterialButton(
                                  onPressed: () {},
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "WIDGET  SIZE :",
                                        style: TextStyle(
                                            color:themeProvider.darkTheme?Color.fromRGBO(187, 134, 252, 0.60):Color.fromRGBO(68,44,46, 1.0),
                                            fontWeight: FontWeight.bold,
                                            fontFamily:'Goldman',
                                            fontSize: 16.0),
                                      ),
                                      SizedBox(
                                        width: 30.0,
                                      ),
                                      //Spacer(flex: 2,),
                                      DropdownButton<String>(
                                        dropdownColor: themeProvider.darkTheme?Color.fromRGBO(33, 33, 33, 0.78):Color.fromRGBO(254,219,208, 0.90),
                                        value: dropValue2,
                                        icon: Icon(Icons.keyboard_arrow_down_sharp),
                                        iconSize: 24,
                                        elevation: 16,
                                        style: TextStyle(color: Colors.redAccent),
                                        underline: Container(
                                          height: 2,
                                          color:themeProvider.darkTheme?Color.fromRGBO(187, 134, 252, 0.60):Color.fromRGBO(68,44,46, 1.0),
                                        ),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            dropValue2 = newValue!;

                                            qrsize=double.parse(dropValue2!);
                                            print("size"+qrsize.toString()+"");
                                          });
                                        },
                                        items:<String>['100', '200', '300', '400'].map<DropdownMenuItem<String>>((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      )

                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Container(
                                padding: EdgeInsets.all(15.0),
                                child: MaterialButton(
                                  onPressed: () {},
                                  child: Row(

                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "ERR. CORR. LvL:",
                                        style: TextStyle(
                                            color:themeProvider.darkTheme?Color.fromRGBO(187, 134, 252, 0.60):Color.fromRGBO(68,44,46, 1.0),
                                            fontWeight: FontWeight.bold,
                                            fontFamily:'Goldman',
                                            fontSize: 16.0),
                                      ),
                                      SizedBox(
                                        width: 20.0,
                                      ),
                                      DropdownButton<String>(
                                        dropdownColor: themeProvider.darkTheme?Color.fromRGBO(33, 33, 33, 0.78):Color.fromRGBO(254,219,208, 0.90),
                                        value: dropValue3,
                                        icon: Icon(Icons.keyboard_arrow_down_sharp),
                                        iconSize: 24,
                                        elevation: 16,
                                        style: TextStyle(color: Colors.redAccent),
                                        underline: Container(
                                          height: 2,
                                          color:themeProvider.darkTheme?Color.fromRGBO(187, 134, 252, 0.60):Color.fromRGBO(68,44,46, 1.0),
                                        ),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            dropValue3 = newValue!;


                                            if(dropValue3=="L")
                                            { errorcorrectlevel=1;  print("ErrorCorrectLevel"); print(errorcorrectlevel.toString());}
                                            else if(dropValue3=="M")
                                            { errorcorrectlevel=0;}
                                            else if(dropValue3=="Q")
                                            { errorcorrectlevel=3;}
                                            else if(dropValue3=="H")
                                            { errorcorrectlevel=2; }
                                          });
                                        },
                                        items:<String>['L', 'M', 'Q', 'H'].map<DropdownMenuItem<String>>((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      )

                                    ],
                                  ),
                                ),
                              ),


                              SizedBox(
                                height: 10.0,
                              ),
                              //Round Eyes
                              Container(
                                alignment: Alignment.center,
                                child: CheckboxListTile(

                                  title: Text("ROUND EYES", style: TextStyle(fontFamily:'Goldman',color: themeProvider.darkTheme?Color.fromRGBO(187, 134, 252, 0.60):Color.fromRGBO(68,44,46, 1.0),),),
                                  value: roundEyes,
                                  onChanged: (newValue) {
                                    setState(() {
                                      roundEyes = newValue;
                                    });
                                  },
                                  controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                                ),

                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              ElevatedButton(
                                // elevation: 3.0,
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        titlePadding: const EdgeInsets.all(0.0),
                                        contentPadding: const EdgeInsets.all(0.0),
                                        content: SingleChildScrollView(
                                          child: ColorPicker(
                                            pickerColor: currentColor,
                                            onColorChanged: changeColor,
                                            colorPickerWidth: 300.0,
                                            pickerAreaHeightPercent: 0.7,
                                            enableAlpha: true,
                                            displayThumbColor: true,
                                            showLabel: true,
                                            paletteType: PaletteType.hsv,
                                            pickerAreaBorderRadius: const BorderRadius.only(
                                              topLeft: const Radius.circular(2.0),
                                              topRight: const Radius.circular(2.0),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: currentColor,
                                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                                    textStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color:useWhiteForeground(currentColor)
                                          ? const Color(0xffffffff)
                                          : const Color(0xff000000),
                                    )),
                                child: const Text('COLOR', style: TextStyle(fontFamily:'Goldman')),


                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Container(

                                alignment: Alignment.center,
                                child: Text(
                                  "Upload a png file",
                                  style: TextStyle(fontWeight: FontWeight.bold,
                                    color:  themeProvider.darkTheme?Color.fromRGBO(187, 134, 252, 0.60):Color.fromRGBO(68,44,46, 1.0),
                                    fontSize: 16.0,
                                    fontFamily: 'Goldman',
                                  ),
                                ),
                                padding: EdgeInsets.all(3.0),
                              ),

                              FloatingActionButton(
                                onPressed:() => _openImageFile(context),
                                tooltip: 'Pick A Logo',
                                child: Icon(Icons.upload_outlined),
                              ),

                              SizedBox(
                                height: 10.0,
                              ),
                              Container(
                                padding: EdgeInsets.all(5),
                                alignment: Alignment.bottomRight,
                                child:ElevatedButton(
                                  onPressed:() async {
                                    if (_dataKey.currentState!.validate()) {

                                      _dataKey.currentState!.save();

                                      await  _generate(
                                          currentColor,
                                          filePath!,
                                          typenumber!,
                                          qrsize!,
                                          data!,
                                          errorcorrectlevel!,
                                          roundEyes!);

                                    } else {
                                      //"Entrez votre message",


                                    }


                                  } ,
                                  // minWidth: 200.0,
                                  // height: 45.0,
                                  style: ElevatedButton.styleFrom(
                                      primary: themeProvider.darkTheme?Color.fromRGBO(221, 44, 0, 1.0):Color.fromRGBO(0,051,51,1.0),
                                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                                      textStyle: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color:themeProvider.darkTheme?Color.fromRGBO(3, 218, 213, 1.0):Color.fromRGBO(68,44,46, 1.0),

                                      )),
                                  child: Text(
                                    "GENERATE",
                                    style:
                                    TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, fontStyle: FontStyle.normal, fontFamily:'Goldman'),
                                  ),
                                ),

                              ),



                              SizedBox(height: 5,),






                            ],),
                        ),),
                    )


                ),//autofil

              ),
              //vertical divider

            ],),




          //grid view

        ],
      ),
    );

  }

  Widget _buildWideContainers() {
    final themeProvider = Provider?.of<DarkThemeProvider>(context);
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[


          Row(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: <Widget>[


              Container(

                // color:Color.fromRGBO(254,219,208, 0.80),
                width: MediaQuery.of(context).size.width*0.5,
                child:AutofillGroup(


                    child: Form(
                      key: _dataKey,
                      //autovalidateMode: AutovalidateMode.always,
                      child: Padding(
                        padding: const EdgeInsets.only(top:5.0,bottom:15,left: 10,right: 10),
                        child: Card(

                          color:themeProvider.darkTheme? Color.fromRGBO(33, 33, 33, 1.0):Color.fromRGBO(215, 204, 200, 1.0),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text("GENERATE YOUR QR CODE",style:TextStyle(fontFamily:'Goldman', fontWeight: FontWeight.w800,fontSize: 20, color: themeProvider.darkTheme?Color.fromRGBO(187, 134, 252, 0.60):Color.fromRGBO(68,44,46, 1.0),),),
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                                child: Material(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.grey.withOpacity(0.3),
                                  elevation: 0.0,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top:15.0,right: 14,left: 14,bottom: 8),
                                    child:
                                    TextFormField(
                                      controller: _dataController,
                                      autofillHints: [AutofillHints.name],
                                      keyboardType: TextInputType.name,
                                      textAlign: TextAlign.center,
                                      onChanged: (value) {
                                        data = value;
                                      },
                                      decoration: InputDecoration(


                                        /*prefixIcon: Icon(
                                                      Icons.mail_rounded,
                                                      color: Colors.blueGrey,
                                                    ),*/
                                        hintText: "Enter your website url or your text here",
                                        labelText: "Enter your website url or your text here",
                                        hintStyle: TextStyle(fontSize: 15,color: Color.fromRGBO(68,44,46, 1.0)) ,
                                        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                        // errorText: isEmailInv ? "" : "*Le champ de l' e-mail ne peut pas être vide"
                                      ),
                                      cursorColor:Colors.blue,
                                      //A enlever ou non?
                                      inputFormatters: [
                                        FilteringTextInputFormatter.deny(RegExp(r"\d+([\.]\d+)?")),
                                        // .singleLineFormatter,
                                      ],
                                      // ignore: missing_return
                                      //à enlever ou non?
                                      validator: (value) {
                                        if (value!.isEmpty) {

                                          RegExp regex = new RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
                                          if (!regex.hasMatch(value))
                                            return 'Please enter your website url or your text here';
                                          else
                                            return null;
                                        }
                                      },
                                      onSaved: (value) {
                                        _dataController.text = value!;
                                      },
                                      autocorrect: true,



                                    ),),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(15.0),
                                //alignment: FractionalOffset.topLeft,
                                child: MaterialButton(
                                  onPressed: () {},
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,

                                    // crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "TYPE NUMBER :",
                                        style: TextStyle(

                                            color:themeProvider.darkTheme?Color.fromRGBO(187, 134, 252, 0.60):Color.fromRGBO(68,44,46, 1.0),
                                            fontWeight: FontWeight.bold,
                                            fontFamily:'Goldman',
                                            fontSize: 16.0),
                                      ),
                                      SizedBox(
                                        width: 28.0,
                                      ),
                                      // Spacer(flex: 2,),
                                      DropdownButton<String>(
                                        dropdownColor:  themeProvider.darkTheme?Color.fromRGBO(33, 33, 33, 0.78):Color.fromRGBO(254,219,208, 0.90),
                                        value: dropValue1,
                                        icon: Icon(Icons.keyboard_arrow_down_sharp),
                                        iconSize: 24,
                                        elevation: 16,
                                        style: TextStyle(color: Colors.redAccent),
                                        underline: Container(
                                          height: 2,
                                          color:themeProvider.darkTheme?Color.fromRGBO(187, 134, 252, 0.60):Color.fromRGBO(68,44,46, 1.0),
                                        ),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            dropValue1= newValue;

                                            typenumber=int.parse(dropValue1!);
                                            print(typenumber);
                                          });
                                        },
                                        items:<String>['1', '2', '3', '4','5','6','7'].map<DropdownMenuItem<String>>((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      )

                                    ],
                                  ),
                                ),
                              ),





                              SizedBox(
                                height: 10.0,
                              ),
                              Container(
                                padding: EdgeInsets.all(15.0),
                                // alignment: FractionalOffset.topLeft,
                                child: MaterialButton(
                                  onPressed: () {},
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "WIDGET  SIZE :",
                                        style: TextStyle(
                                            color:themeProvider.darkTheme?Color.fromRGBO(187, 134, 252, 0.60):Color.fromRGBO(68,44,46, 1.0),
                                            fontWeight: FontWeight.bold,
                                            fontFamily:'Goldman',
                                            fontSize: 16.0),
                                      ),
                                      SizedBox(
                                        width: 30.0,
                                      ),
                                      //Spacer(flex: 2,),
                                      DropdownButton<String>(
                                        dropdownColor: themeProvider.darkTheme?Color.fromRGBO(33, 33, 33, 0.78):Color.fromRGBO(254,219,208, 0.90),
                                        value: dropValue2,
                                        icon: Icon(Icons.keyboard_arrow_down_sharp),
                                        iconSize: 24,
                                        elevation: 16,
                                        style: TextStyle(color: Colors.redAccent),
                                        underline: Container(
                                          height: 2,
                                          color:themeProvider.darkTheme?Color.fromRGBO(187, 134, 252, 0.60):Color.fromRGBO(68,44,46, 1.0),
                                        ),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            dropValue2 = newValue!;

                                            qrsize=double.parse(dropValue2!);
                                            print("size"+qrsize.toString()+"");
                                          });
                                        },
                                        items:<String>['100', '200', '300', '400'].map<DropdownMenuItem<String>>((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      )

                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Container(
                                padding: EdgeInsets.all(15.0),
                                child: MaterialButton(
                                  onPressed: () {},
                                  child: Row(

                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "ERR. CORR. LvL:",
                                        style: TextStyle(
                                            color:themeProvider.darkTheme?Color.fromRGBO(187, 134, 252, 0.60):Color.fromRGBO(68,44,46, 1.0),
                                            fontWeight: FontWeight.bold,
                                            fontFamily:'Goldman',
                                            fontSize: 16.0),
                                      ),
                                      SizedBox(
                                        width: 20.0,
                                      ),
                                      DropdownButton<String>(
                                        dropdownColor: themeProvider.darkTheme?Color.fromRGBO(33, 33, 33, 0.78):Color.fromRGBO(254,219,208, 0.90),
                                        value: dropValue3,
                                        icon: Icon(Icons.keyboard_arrow_down_sharp),
                                        iconSize: 24,
                                        elevation: 16,
                                        style: TextStyle(color: Colors.redAccent),
                                        underline: Container(
                                          height: 2,
                                          color:themeProvider.darkTheme?Color.fromRGBO(187, 134, 252, 0.60):Color.fromRGBO(68,44,46, 1.0),
                                        ),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            dropValue3 = newValue!;


                                            if(dropValue3=="L")
                                            { errorcorrectlevel=1;  print("ErrorCorrectLevel"); print(errorcorrectlevel.toString());}
                                            else if(dropValue3=="M")
                                            { errorcorrectlevel=0;}
                                            else if(dropValue3=="Q")
                                            { errorcorrectlevel=3;}
                                            else if(dropValue3=="H")
                                            { errorcorrectlevel=2; }
                                          });
                                        },
                                        items:<String>['L', 'M', 'Q', 'H'].map<DropdownMenuItem<String>>((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      )

                                    ],
                                  ),
                                ),
                              ),


                              SizedBox(
                                height: 10.0,
                              ),
                              //Round Eyes
                              Container(
                                alignment: Alignment.center,
                                child: CheckboxListTile(

                                  title: Text("ROUND EYES", style: TextStyle(fontFamily:'Goldman',color: themeProvider.darkTheme?Color.fromRGBO(187, 134, 252, 0.60):Color.fromRGBO(68,44,46, 1.0),),),
                                  value: roundEyes,
                                  onChanged: (newValue) {
                                    setState(() {
                                      roundEyes = newValue;
                                    });
                                  },
                                  controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                                ),

                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              ElevatedButton(
                                // elevation: 3.0,
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        titlePadding: const EdgeInsets.all(0.0),
                                        contentPadding: const EdgeInsets.all(0.0),
                                        content: SingleChildScrollView(
                                          child: ColorPicker(
                                            pickerColor: currentColor,
                                            onColorChanged: changeColor,
                                            colorPickerWidth: 300.0,
                                            pickerAreaHeightPercent: 0.7,
                                            enableAlpha: true,
                                            displayThumbColor: true,
                                            showLabel: true,
                                            paletteType: PaletteType.hsv,
                                            pickerAreaBorderRadius: const BorderRadius.only(
                                              topLeft: const Radius.circular(2.0),
                                              topRight: const Radius.circular(2.0),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: currentColor,
                                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                                    textStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color:useWhiteForeground(currentColor)
                                          ? const Color(0xffffffff)
                                          : const Color(0xff000000),
                                    )),
                                child: const Text('COLOR', style: TextStyle(fontFamily:'Goldman')),


                              ),
                              SizedBox(
                                height: 10.0,
                              ),

                              SizedBox(
                                height: 10.0,
                              ),
                              Container(

                                alignment: Alignment.center,
                                child: Text(
                                  "Upload a png file",
                                  style: TextStyle(fontWeight: FontWeight.bold,
                                    color:  themeProvider.darkTheme?Color.fromRGBO(187, 134, 252, 0.60):Color.fromRGBO(68,44,46, 1.0),
                                    fontSize: 16.0,
                                    fontFamily: 'Goldman',
                                  ),
                                ),
                                padding: EdgeInsets.all(3.0),
                              ),

                              FloatingActionButton(
                                onPressed:() => _openImageFile(context),
                                tooltip: 'Pick A Logo',
                                child: Icon(Icons.upload_outlined),
                              ),

                              SizedBox(
                                height: 10.0,
                              ),
                              Container(
                                padding: EdgeInsets.all(5),
                                alignment: Alignment.bottomRight,
                                child:ElevatedButton(
                                  onPressed:() async {
                                    if (_dataKey.currentState!.validate()) {

                                      _dataKey.currentState!.save();

                                      await  _generate(
                                          currentColor,
                                          filePath!,
                                          typenumber!,
                                          qrsize!,
                                          data!,
                                          errorcorrectlevel!,
                                          roundEyes!);

                                    } else {
                                      //"Entrez votre message",


                                    }


                                  } ,
                                  // minWidth: 200.0,
                                  // height: 45.0,
                                  style: ElevatedButton.styleFrom(
                                      primary: themeProvider.darkTheme?Color.fromRGBO(221, 44, 0, 1.0):Color.fromRGBO(0,051,51,1.0),
                                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                                      textStyle: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color:themeProvider.darkTheme?Color.fromRGBO(3, 218, 213, 1.0):Color.fromRGBO(68,44,46, 1.0),

                                      )),
                                  child: Text(
                                    "GENERATE",
                                    style:
                                    TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, fontStyle: FontStyle.normal, fontFamily:'Goldman'),
                                  ),
                                ),

                              ),



                              SizedBox(height: 5,),

                            ],),
                        ),),
                    )


                ),//autofil

              ),
              //vertical divider
              Container(height: MediaQuery.of(context).size.height*0.8, child: VerticalDivider(color: Colors.redAccent, thickness: 0.25, width:20,)),

              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: okGen!? Container(
                          padding: EdgeInsets.all(10.0),
                          alignment: Alignment.centerRight,
                          child:qrCode):Container(

                        alignment: Alignment.centerRight,
                        child:Column(
                          children: <Widget>[
                            Text(
                              "Your Qr Code will be displayed here",
                              style: TextStyle(fontWeight: FontWeight.bold,
                                color:  themeProvider.darkTheme?Color.fromRGBO(187, 134, 252, 0.60):Color.fromRGBO(68,44,46, 1.0),
                                fontSize: 18.0,
                                fontFamily:'Goldman',
                              ),
                            ),
                            Image.asset(
                              "images/qrcoka.gif",
                              height: MediaQuery.of(context).size.height*0.6,
                              width: MediaQuery.of(context).size.width*0.45,
                            ),
                          ],
                        ),
                        padding: EdgeInsets.all(3.0),
                      ),
                    ),
                    //WHAT IS QR-CODE?
                    Container(
                        width: MediaQuery.of(context).size.width*0.40,

                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                        child:Column(
                          children: <Widget>[
                            Text(
                                "What is a QR Code?"
                                ,
                                style: TextStyle(
                                  color:themeProvider.darkTheme?Color.fromRGBO(187, 134, 252, 0.60):Color.fromRGBO(68,44,46, 1.0),
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Goldman',
                                  // fontStyle: FontStyle.italic,
                                )
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text("A QR code consists of black squares arranged in a square grid on a white background, which can be read by an imaging device such as a camera, and processed using Reed–Solomon error correction until the image can be appropriately interpreted."
                                " The required data is then extracted from patterns that are present in both horizontal and vertical components of the image.(Wikipedia)",
                              style: TextStyle(

                                color:themeProvider.darkTheme?  Colors.white70:Color.fromRGBO(68,44,46, 1.0),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Goldman',
                                // fontStyle: FontStyle.italic,
                              ),
                              textAlign: TextAlign.justify,
                            )

                          ],
                        )
                    )

                    //  ),
                  ],
                ),
              )

            ],),




          //grid view

        ],
      ),
    );
  }


}
class ImageDisplay extends StatelessWidget {
  /// Image's name
  final String fileName;

  /// Image's path
  final String filePath;

  /// Default Constructor
  ImageDisplay(this.fileName, this.filePath);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(fileName),
      // On web the filePath is a blob url
      // while on other platforms it is a system path.
      content: kIsWeb ? Image.network(filePath) : Image.file(File(filePath)),
      actions: [
        TextButton(
          child: const Text('Close'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}