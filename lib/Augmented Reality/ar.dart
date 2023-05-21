import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:saudi_guide/Augmented%20Reality/landmark.dart';
import 'package:saudi_guide/Augmented%20Reality/ocr.dart';
import 'package:saudi_guide/Cubits/ORCCubit/ocrcubit_cubit.dart';

import '../Cubits/ScanCubit/scan_land_mark_cubit.dart';

class AugmentedRealityScreen extends StatelessWidget {
  const AugmentedRealityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getFromCamera(BuildContext context) async {
      PickedFile? pickedFile = await ImagePicker().getImage(
        source: ImageSource.camera,
        maxWidth: 1800,
        maxHeight: 1800,
      );
      if (pickedFile != null) {
        File imageFile = File(pickedFile.path);
        BlocProvider.of<ScanLandMarkCubit>(context)
            .getScanLandMarkData(file: imageFile.path);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LandMark(
                      file: imageFile,
                    )));
      }
    }

    getFromGalley(BuildContext context) async {
      PickedFile? pickedFile = await ImagePicker().getImage(
        source: ImageSource.gallery,
        maxWidth: 1800,
        maxHeight: 1800,
      );
      if (pickedFile != null) {
        File imageFile = File(pickedFile.path);
        BlocProvider.of<ScanLandMarkCubit>(context)
            .getScanLandMarkData(file: imageFile.path);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LandMark(
                      file: imageFile,
                    )));
      }
    }

    getFromCameraOCR(BuildContext context) async {
      PickedFile? pickedFile = await ImagePicker().getImage(
        source: ImageSource.camera,
        maxWidth: 1800,
        maxHeight: 1800,
      );
      if (pickedFile != null) {
        File imageFile = File(pickedFile.path);
        BlocProvider.of<OcrcubitCubit>(context)
            .getOCRData(file: imageFile.path);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OCR(
                      file: imageFile,
                    )));
      }
    }

    getFromGalleryOCR(BuildContext context) async {
      PickedFile? pickedFile = await ImagePicker().getImage(
        source: ImageSource.gallery,
        maxWidth: 1800,
        maxHeight: 1800,
      );
      if (pickedFile != null) {
        File imageFile = File(pickedFile.path);
        BlocProvider.of<OcrcubitCubit>(context)
            .getOCRData(file: imageFile.path);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OCR(
                      file: imageFile,
                    )));
      }
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(color: Colors.grey.withAlpha(50), blurRadius: 5)
        ]),
        height: 70.h,
        child: InkWell(
          onTap: () {},
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 10.sp),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.sp),
              color: const Color(0xff299E97),
            ),
            child: Center(
              child: Text(
                'Lets Chat',
                style: GoogleFonts.cairo(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        toolbarHeight: 90.sp,
        backgroundColor: Colors.white,
        foregroundColor: Colors.white,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(left: 5.sp),
            width: 31.sp,
            height: 31.sp,
            margin: EdgeInsets.only(left: 20.sp),
            decoration: const BoxDecoration(
                color: Color.fromRGBO(41, 158, 151, 1), shape: BoxShape.circle),
            child: Icon(
              Icons.arrow_back_ios,
              size: 20.sp,
            ),
          ),
        ),
        elevation: 3,
        centerTitle: true,
        title: Text(
          'Augmented Reality',
          style: GoogleFonts.cairo(
            fontSize: 22.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF082B34),
          ),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 100.sp,
          ),
          InkWell(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Wrap(
                      children: [
                        ListTile(
                          leading: Icon(Icons.picture_in_picture),
                          title: const Text(
                            'Pick From Gallery',
                          ),
                          onTap: () {
                            getFromGalleryOCR(context);
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.camera),
                          title: Text('Pick From Camera'),
                          onTap: () {
                            getFromCameraOCR(context);
                          },
                        ),
                      ],
                    );
                  });
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 60.sp, vertical: 10.sp),
              width: 197.0.sp,
              height: 158.0.sp,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF474747).withOpacity(0.1),
                    offset: const Offset(0, 3.0),
                    blurRadius: 12.0,
                  ),
                ],
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 20.sp,
                  ),
                  CircleAvatar(
                    backgroundColor: const Color(0xffE7FCFB),
                    radius: 40.sp,
                    child: SvgPicture.string(
                      // augmented-reality
                      '<svg viewBox="0.0 0.0 32.0 32.0" ><path transform="translate(-88.59, 0.0)" d="M 120.3747863769531 15.97830867767334 L 114.6874694824219 12.39662551879883 L 114.6874694824219 2.812512159347534 C 114.6874694824219 1.261701345443726 113.4257888793945 1.52587890625e-05 111.8749771118164 1.52587890625e-05 L 97.31249237060547 1.52587890625e-05 C 95.76168060302734 1.52587890625e-05 94.49999237060547 1.261701345443726 94.49999237060547 2.812512159347534 L 94.49999237060547 4.25001049041748 C 94.49999237060547 4.508947849273682 94.70980834960938 4.718760013580322 94.96874237060547 4.718760013580322 C 95.22768402099609 4.718760013580322 95.43749237060547 4.508947849273682 95.43749237060547 4.25001049041748 L 95.43749237060547 2.812512159347534 C 95.43749237060547 1.778638243675232 96.27861785888672 0.9375142455101013 97.31249237060547 0.9375142455101013 L 111.8749771118164 0.9375142455101013 C 112.9088516235352 0.9375142455101013 113.7499694824219 1.778638243675232 113.7499694824219 2.812512159347534 L 113.7499694824219 11.80618953704834 L 112.6175384521484 11.09300327301025 C 112.3985977172852 10.95512866973877 112.1090393066406 11.0208158493042 111.9710464477539 11.23987865447998 C 111.8331069946289 11.45894145965576 111.8988571166992 11.74837779998779 112.1179122924805 11.88637638092041 L 113.7499694824219 12.91425037384033 L 113.7499694824219 19.83586692810059 L 112.1179122924805 20.86374092102051 C 111.8988571166992 21.00174140930176 111.8331069946289 21.29117774963379 111.9710464477539 21.51024055480957 C 112.1098556518555 21.73117828369141 112.401725769043 21.79380035400391 112.6175384521484 21.65711402893066 L 113.7499694824219 20.94392776489258 L 113.7499694824219 29.1874828338623 C 113.7499694824219 30.22135543823242 112.9088516235352 31.06248092651367 111.8749771118164 31.06248092651367 L 106.8437271118164 31.06248092651367 C 106.5847930908203 31.06248092651367 106.3749771118164 31.27229118347168 106.3749771118164 31.53122901916504 C 106.3749771118164 31.79016876220703 106.5847930908203 31.99997901916504 106.8437271118164 31.99997901916504 L 111.8749771118164 31.99997901916504 C 113.4257888793945 31.99997901916504 114.6874694824219 30.7382926940918 114.6874694824219 29.1874828338623 L 114.6874694824219 20.35336685180664 L 120.3747863769531 16.77161979675293 C 120.5110244750977 16.68581008911133 120.5937118530273 16.53599548339844 120.5937118530273 16.37493515014648 C 120.5937118530273 16.2138729095459 120.5110931396484 16.06418609619141 120.3747863769531 15.97831058502197 Z M 114.6874694824219 19.24542999267578 L 114.6874694824219 13.50462341308594 L 119.2454071044922 16.37499618530273 L 114.6874694824219 19.24542999267578 Z" fill="#299e97" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(0.0, -89.53)" d="M 16.06248092651367 120.5937347412109 L 8.718738555908203 120.5937347412109 C 7.684864521026611 120.5937347412109 6.843740463256836 119.7526168823242 6.843740463256836 118.7187347412109 L 6.843740463256836 110.4750595092773 L 7.976177215576172 111.1882476806641 C 8.191926956176758 111.3249969482422 8.48380184173584 111.2623138427734 8.622676849365234 111.041374206543 C 8.760613441467285 110.8223114013672 8.694863319396973 110.5328750610352 8.475801467895508 110.3948669433594 L 6.843739986419678 109.3670654296875 L 6.843739986419678 102.445442199707 L 8.475801467895508 101.4175720214844 C 8.694863319396973 101.2795715332031 8.760613441467285 100.9901351928711 8.622676849365234 100.7710723876953 C 8.484677314758301 100.5520095825195 8.19517707824707 100.4863204956055 7.976176738739014 100.6241989135742 L 6.843740463256836 101.3374481201172 L 6.843740463256836 95.96876525878906 C 6.843740463256836 95.70983123779297 6.633928298950195 95.50001525878906 6.374991416931152 95.50001525878906 C 6.116054058074951 95.50001525878906 5.906241893768311 95.70983123779297 5.906241893768311 95.96876525878906 L 5.906241893768311 101.9278869628906 L 0.2189355939626694 105.5095672607422 C 0.08268573880195618 105.5953750610352 -1.6689299400241e-06 105.7451934814453 -1.6689299400241e-06 105.90625 C -1.6689299400241e-06 106.0673141479492 0.08268573880195618 106.2171325683594 0.2189355939626694 106.3029403686523 L 5.906241893768311 109.8846206665039 L 5.906241893768311 118.7187347412109 C 5.906241893768311 120.2695465087891 7.167927742004395 121.5312347412109 8.718738555908203 121.5312347412109 L 16.06248092651367 121.5312347412109 C 16.32141876220703 121.5312347412109 16.53123092651367 121.3214263916016 16.53123092651367 121.0624847412109 C 16.53123092651367 120.8035507202148 16.32141876220703 120.5937347412109 16.06248092651367 120.5937347412109 Z M 1.348372220993042 105.90625 L 5.906241893768311 103.0358123779297 L 5.906241893768311 108.7766265869141 L 1.348372220993042 105.90625 Z" fill="#299e97" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-197.81, -28.12)" d="M 214.59375 30 L 211.46875 30 C 211.2098083496094 30 211 30.20981216430664 211 30.46875 C 211 30.72768783569336 211.2098083496094 30.9375 211.46875 30.9375 L 214.59375 30.9375 C 214.8526916503906 30.9375 215.0625 30.72768783569336 215.0625 30.46875 C 215.0625 30.20981216430664 214.8526916503906 30 214.59375 30 Z" fill="#299e97" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-268.14, -28.15)" d="M 286.0902709960938 30.75041580200195 C 286.2256469726562 30.96241569519043 286.5338134765625 31.0239143371582 286.7402648925781 30.88041687011719 C 286.9822692871094 30.72710227966309 287.0197143554688 30.35616683959961 286.8115234375 30.15916633605957 C 286.6382751464844 29.97854042053223 286.3224487304688 29.97697830200195 286.1490173339844 30.15916633605957 C 285.9925231933594 30.31022834777832 285.9668273925781 30.57122802734375 286.0902709960938 30.75041580200195 Z" fill="#299e97" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-152.81, -134.49)" d="M 163.2114868164062 146.9390258789062 C 163.080810546875 147.0230407714844 162.9998779296875 147.175537109375 163 147.3304748535156 L 163 154.3929595947266 C 163 154.5530853271484 163.0816802978516 154.7020263671875 163.2166137695312 154.7881469726562 L 168.5603637695312 158.1973266601562 C 168.7134399414062 158.2948913574219 168.9089965820312 158.2954559326172 169.0625610351562 158.1986389160156 L 174.4687957763672 154.7894592285156 C 174.6049194335938 154.7036437988281 174.6874847412109 154.5538940429688 174.6874847412109 154.3929595947266 L 174.6874847412109 153.1117095947266 C 174.6874847412109 152.852783203125 174.4776763916016 152.6429748535156 174.2187347412109 152.6429748535156 C 173.9597930908203 152.6429748535156 173.7499847412109 152.852783203125 173.7499847412109 153.1117095947266 L 173.7499847412109 154.1343994140625 L 169.2812347412109 156.9523315429688 L 169.2812347412109 150.9982299804688 L 173.7499847412109 148.1802215576172 L 173.7499847412109 150.9242248535156 C 173.7499847412109 151.1831665039062 173.9597930908203 151.3929748535156 174.2187347412109 151.3929748535156 C 174.4776763916016 151.3929748535156 174.6874847412109 151.1831665039062 174.6874847412109 150.9242248535156 L 174.6874847412109 147.3304748535156 C 174.6879272460938 147.1721496582031 174.6030426025391 147.0179748535156 174.4687957763672 146.9339752197266 L 169.0625610351562 143.5247802734375 C 168.9089965820312 143.4278564453125 168.7134399414062 143.4285430908203 168.5603637695312 143.5260925292969 L 163.2166137695312 146.9352874755859 C 163.2148132324219 146.9364166259766 163.2132415771484 146.9378509521484 163.2114868164062 146.9390258789062 Z M 168.8139343261719 144.4764099121094 L 173.3399200439453 147.3304748535156 L 168.8139343261719 150.1845245361328 L 167.3614196777344 149.2578430175781 C 167.143310546875 149.1188354492188 166.8534240722656 149.1827850341797 166.714111328125 149.4009094238281 C 166.5748596191406 149.6191558837891 166.6389923095703 149.9089660644531 166.857177734375 150.0482177734375 L 168.3437347412109 150.9966583251953 L 168.3437347412109 156.947021484375 L 163.9375 154.1360168457031 L 163.9375 148.1855926513672 L 165.0094909667969 148.8695373535156 C 165.2245483398438 149.0075225830078 165.5166778564453 148.9464721679688 165.6567993164062 148.7264709472656 C 165.7960510253906 148.5082092285156 165.73193359375 148.2184143066406 165.5137329101562 148.0791625976562 L 164.3403015136719 147.3304748535156 L 168.8139343261719 144.4764099121094 Z" fill="#299e97" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-145.97, -127.94)" d="M 157.8935394287109 136.5464477539062 L 155.9220581054688 137.7943267822266 C 155.7033081054688 137.9327545166016 155.63818359375 138.2223205566406 155.7766876220703 138.4410705566406 C 155.9159240722656 138.6616973876953 156.2079925537109 138.7237548828125 156.4234313964844 138.5864410400391 L 158.3949279785156 137.3385620117188 C 158.6136779785156 137.2001342773438 158.6788024902344 136.9105682373047 158.5402984619141 136.6918182373047 C 158.4019165039062 136.4730072021484 158.1121215820312 136.4079437255859 157.8935394287109 136.5464477539062 Z" fill="#299e97" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-205.2, -91.88)" d="M 220.9526519775391 98.07228851318359 L 219.1016540527344 99.23797607421875 C 218.8825836181641 99.3759765625 218.8168334960938 99.66541290283203 218.9547729492188 99.88447570800781 C 219.0927734375 100.1035385131836 219.3822174072266 100.1692276000977 219.6012725830078 100.0313491821289 L 221.2024536132812 99.02291107177734 L 222.8036346435547 100.0313491821289 C 223.0194549560547 100.1680374145508 223.3112640380859 100.1054077148438 223.4501495361328 99.88447570800781 C 223.5880737304688 99.66541290283203 223.5223388671875 99.3759765625 223.3032684326172 99.23797607421875 L 221.4522705078125 98.07228851318359 C 221.2995758056641 97.97622680664062 221.1053314208984 97.97622680664062 220.9526519775391 98.07228851318359 Z" fill="#299e97" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-290.35, -128.01)" d="M 312.3761596679688 137.8317718505859 L 310.4202270507812 136.6158905029297 C 310.2002868652344 136.4792022705078 309.9113159179688 136.5465850830078 309.774658203125 136.7664642333984 C 309.637939453125 136.9864044189453 309.7054138183594 137.275390625 309.9252319335938 137.4120178222656 L 311.8811645507812 138.6278991699219 C 312.0975952148438 138.7633972167969 312.3892211914062 138.6990814208984 312.5267333984375 138.4773254394531 C 312.6634826660156 138.2574005126953 312.5960388183594 137.9683990478516 312.3761596679688 137.8317718505859 Z" fill="#299e97" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-290.14, -330.52)" d="M 311.691650390625 352.6275329589844 L 309.7032775878906 353.8482360839844 C 309.4826354980469 353.9836730957031 309.41357421875 354.2722778320312 309.5490417480469 354.4928894042969 C 309.6852722167969 354.7154846191406 309.9765930175781 354.7813415527344 310.1937255859375 354.6471557617188 L 312.1820983886719 353.4264831542969 C 312.4027099609375 353.2910461425781 312.4717712402344 353.0024108886719 312.3363342285156 352.7817993164062 C 312.2009582519531 352.56103515625 311.9122009277344 352.4920959472656 311.691650390625 352.6275329589844 Z" fill="#299e97" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-205.2, -367.83)" d="M 222.8036193847656 392.4206237792969 L 221.2024536132812 393.4290466308594 L 219.6012573242188 392.4206237792969 C 219.3820495605469 392.2828063964844 219.0927429199219 392.3484191894531 218.9547424316406 392.5674743652344 C 218.8168334960938 392.7865600585938 218.882568359375 393.0759887695312 219.1016235351562 393.2139892578125 L 220.95263671875 394.3796691894531 C 221.1053161621094 394.4757995605469 221.299560546875 394.4757995605469 221.4522399902344 394.3796691894531 L 223.3032531738281 393.2139892578125 C 223.5223083496094 393.0759887695312 223.5880737304688 392.7865600585938 223.4501342773438 392.5674743652344 C 223.3121337890625 392.3484191894531 223.0226745605469 392.2828063964844 222.8036193847656 392.4206237792969 Z" fill="#299e97" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-145.92, -330.61)" d="M 155.8648834228516 353.5221252441406 L 157.8429412841797 354.7595520019531 C 158.0590667724609 354.8956909179688 158.3508148193359 354.8320617675781 158.4889526367188 354.6107482910156 C 158.6262054443359 354.3912353515625 158.5596313476562 354.10205078125 158.3401336669922 353.9647521972656 L 156.3620758056641 352.727294921875 C 156.1425628662109 352.5902404785156 155.8533782958984 352.6566162109375 155.7160797119141 352.8760986328125 C 155.5788269042969 353.0955505371094 155.6453857421875 353.3847351074219 155.8648834228516 353.5221252441406 Z" fill="#299e97" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                      width: 32.0.sp,
                      height: 32.0.sp,
                    ),
                  ),
                  Text(
                    'OCR',
                    style: GoogleFonts.cairo(
                      fontSize: 15.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Wrap(
                      children: [
                        ListTile(
                          leading: Icon(Icons.picture_in_picture),
                          title: const Text(
                            'Pick From Gallery',
                          ),
                          onTap: () {
                            getFromGalley(context);
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.camera),
                          title: Text('Pick From Camera'),
                          onTap: () {
                            getFromCamera(context);
                          },
                        ),
                      ],
                    );
                  });
            },
            // getFromCamera(context);

            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 60.sp, vertical: 10.sp),
              width: 197.0.sp,
              height: 158.0.sp,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF474747).withOpacity(0.1),
                    offset: const Offset(0, 3.0),
                    blurRadius: 12.0,
                  ),
                ],
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 20.sp,
                  ),
                  CircleAvatar(
                    backgroundColor: const Color(0xffE7FCFB),
                    radius: 40.sp,
                    child: SvgPicture.asset('assets/icons/scan.svg'),
                  ),
                  Text(
                    'Scan LandMark',
                    style: GoogleFonts.cairo(
                      fontSize: 15.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
