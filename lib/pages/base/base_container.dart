import 'package:esalesapp/pages/chatting/roomcari_list.dart';
import 'package:esalesapp/pages/groupchat/groupchat_page.dart';
import 'package:esalesapp/pages/home/home_page.dart';
import 'package:esalesapp/menu/app_menu_drawer.dart';
import 'package:esalesapp/pages/base/base_page.dart';
import 'package:esalesapp/common/styles.dart';
import 'package:esalesapp/pages/jobreal/jobrealcari_main.dart';
import 'package:esalesapp/pages/mstcob/cobcari_main.dart';
import 'package:esalesapp/pages/mstcustcat/custcatcari_main.dart';
import 'package:esalesapp/pages/mstjabatan/jabatancari_main.dart';
import 'package:esalesapp/pages/mstjob/jobcari_main.dart';
import 'package:esalesapp/pages/mstjobcat/jobcatcari_main.dart';
import 'package:esalesapp/pages/mstmedia/mediacari_main.dart';
import 'package:esalesapp/pages/mstrekan/rekancari_main.dart';
import 'package:esalesapp/pages/mststaff/staffcari_main.dart';
import 'package:esalesapp/pages/msttitle/titlecari_main.dart';
import 'package:esalesapp/pages/polis/poliscari_main.dart';
import 'package:flutter/material.dart';
import 'package:esalesapp/pages/profile/profile_main_page.dart';
import 'package:esalesapp/repositories/user/user_repository.dart';

class PageContainerWithUserRepository extends PageContainerBase {
  final int userid;
  final UserRepository userRepository;
  final PageType pageType;

  const PageContainerWithUserRepository(
      {required super.key,
      required this.userid,
      required this.userRepository,
      required this.pageType});

  @override
  Widget get menuDrawer => const AppMenu();

  @override
  String get pageTitle {
    //debugPrint("PageContainerWithUserRepository -> pageTitle");
    switch (pageType) {
      case PageType.profile:
        return "Profile";      
      default:
        return "Login Page";
    }
  }

  @override
  Widget get body {
    Widget? page;
    //debugPrint("PageContainerWithUserRepository -> body");
    switch (pageType) {
      case PageType.home:
        page = HomePage(
          userid: userid,
          userRepository: userRepository,
          key: null,
        );
        break;      
      case PageType.profile:
        page = ProfileMainPage(
          userid: userid,
          userRepository: userRepository,
        );
        break;      
      default:
        page = null;
    }
    return Padding(
      padding: EdgeInsets.all(Spacing.matGridUnit()),
      child: page,
    );
  }

  @override
  Widget get background => Container();

  @override
  Color get backgroundColor => AppColors.background;

  @override
  PageType? get parentModal => null;
}

class PageContainer extends PageContainerBase {
  final PageType pageType;
  final String? recId;

  const PageContainer({super.key, required this.pageType, this.recId});

  @override
  Widget get menuDrawer => const AppMenu();

  @override
  String get pageTitle {
    switch (pageType) {
      case PageType.profile:
        return "Profile";      
      case PageType.roomchat:
        return "Chat Support";
      case PageType.action:
        return "Action";
      case PageType.media:
        return "Master Media";
      case PageType.jobcat:
        return "Task Category";
      case PageType.job:
        return "Master Task";
      case PageType.customer:
        return "Master Customer";
      case PageType.insurer:
        return "Master Asuransi";
      case PageType.title:
        return "Master Title";
      case PageType.jabatan:
        return "Master Jabatan";
      case PageType.staff:
        return "Master Karyawan";
      case PageType.custcat:
        return "Master Client Category";
      case PageType.polis:
        return "List Policy";
      case PageType.cob:
        return "Master Class of Business";
      default:
        return "Login Page";
    }
  }

  @override
  Widget get body {
    Widget? page;

    switch (pageType) {
      
      case PageType.groupchat:
        page = const ChatPage(roomId: "support");
        break;
      case PageType.roomchat:
        page = const RoomCariPage();
        break;      
      case PageType.action:
        page = const JobRealCariMainPage();
        break;      
      case PageType.media:
        page = const MediaCariMainPage();
        break;      
      case PageType.jobcat:
        page = const JobCatCariMainPage();
        break;      
      case PageType.job:
        page = const JobCariMainPage();
        break;      
      case PageType.customer:
        page = const RekanCariMainPage(rekanTypeId: "00010");
        break;      
      case PageType.insurer:
        page = const RekanCariMainPage(rekanTypeId: "00030");
        break;
      case PageType.title:
        page = const TitleCariMainPage();
        break;
      case PageType.jabatan:
        page = const JabatanCariMainPage();
        break;
      case PageType.staff:
        page = const StaffCariMainPage();
        break;
      case PageType.custcat:
        page = const CustCatCariMainPage();
        break;
      case PageType.polis:
        page = const PolisCariMainPage();
        break;
      case PageType.cob:
        page = const CobCariMainPage();
        break;
      default:
        page = null;
    }
    return Padding(
      padding: EdgeInsets.all(Spacing.matGridUnit()),
      child: page,
    );
  }

  @override
  Widget get background => Container();

  @override
  Color get backgroundColor => AppColors.background;

  @override
  PageType? get parentModal => null;
}