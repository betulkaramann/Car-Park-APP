import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:io' show Platform;


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPage = 0;
  final qrKey = GlobalKey(debugLabel: 'Qr');
  QRViewController? controller;
  Barcode? barcode;

  @override
  void dispose() {
    // TODO: implement dispose
    controller?.dispose();
    super.dispose();
  }
  void reassemble() async{
    super.reassemble();
    if(Platform.isAndroid){
      await controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }
  @override
  Widget build(BuildContext context) {
    PageController _controller = PageController(
      initialPage: currentPage,
    );

    void onTapIcon(int index){
      _controller.animateToPage(index, duration: Duration(milliseconds: 300), curve: Curves.easeInCubic);
    }

    return Scaffold(
      body: PageView(
        controller: _controller,
        onPageChanged: (value){
          setState(() {
            currentPage =value;
          });
        }
        ,
        children: <Widget>[
          Center(child: Text("Home"),),
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
            buildQrView(context),
            Positioned(bottom:10,child: builtResult()),
          ],),
          Center(child: Text("Setting"),),

        ],
      ),
      backgroundColor: Color.fromRGBO(212, 240, 250, 1),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage,
        fixedColor: Colors.black,

        onTap: onTapIcon,
        items: [
        BottomNavigationBarItem(label: "Anasayfa",icon: Icon(Icons.home, ),),
        BottomNavigationBarItem(label: "Qr Code",icon: Icon( Icons.qr_code_scanner, ),),
        BottomNavigationBarItem(label: "Ayarlar",icon: Icon( Icons.info, ),),
      ],

      ),
    );



  }

  Widget buildQrView(BuildContext context) => QRView(
      key: qrKey,
      onQRViewCreated: onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderRadius: 12,
        borderWidth: 10,
        borderColor: Color.fromRGBO(212, 240, 250, 1),
        cutOutSize: MediaQuery.of(context).size.width * 0.8,
      ),
  );

  void onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller =controller;
    });

    controller.scannedDataStream.listen((barcode) {
      setState(() {
        this.barcode = barcode;
      });
    });
  }

   Widget builtResult()  => Container(
     padding: EdgeInsets.all(12),
     decoration: BoxDecoration(
       borderRadius: BorderRadius.circular(12),
       color: Color.fromRGBO(212, 240, 250, 0.7),
     ),
     child: Text(

       barcode != null ? '${barcode!.code}' : 'Barkodu okutunuz',maxLines: 3,
     ),
   );
}
