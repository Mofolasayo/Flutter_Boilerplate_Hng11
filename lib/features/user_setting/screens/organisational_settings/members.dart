import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_hng11/features/user_setting/widgets/dialogs/delete_member_dialog.dart';
import 'package:flutter_boilerplate_hng11/features/user_setting/widgets/invite_dialog.dart';
import 'package:flutter_boilerplate_hng11/utils/global_colors.dart';
import 'package:flutter_boilerplate_hng11/utils/widgets/custom_search_field.dart';
import 'package:flutter_boilerplate_hng11/utils/widgets/custom_toast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../utils/widgets/custom_avatar.dart';
import '../../../../utils/widgets/custom_button.dart';
import '../../../../utils/widgets/custom_dropdown_button.dart';

class MembersSettings extends StatefulWidget {
  const MembersSettings({super.key});

  @override
  State<MembersSettings> createState() => _MembersSettingsState();
}

class _MembersSettingsState extends State<MembersSettings> {
  bool isInviteLinkActive = false;

  void showCustomToast(BuildContext context) {
    CustomToast.show(
      context,
      CustomToast(
        message: "Invite Sent Successfully",
        backgroundColor: GlobalColors.toastBgSurface2,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: GlobalColors.green, width: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Members',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: GlobalColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Manage who has access to this workspace",
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                  color: GlobalColors.darkOne,
                ),
              ),
              Divider(
                color: GlobalColors.borderColor,
                thickness: 1.h,
              ),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                value: isInviteLinkActive,
                onChanged: (bool value) {
                  setState(() {
                    isInviteLinkActive = value;
                  });
                },
                inactiveTrackColor: GlobalColors.borderColor,
                inactiveThumbColor: GlobalColors.white,
                activeColor: GlobalColors.white,
                activeTrackColor: GlobalColors.orange,
                title: Text(
                  'Invite Link',
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: const Color.fromARGB(255, 48, 47, 47),
                  ),
                ),
                subtitle: Text(
                  'This provides a unique URL that allows anyone to join your workspace',
                  style: GoogleFonts.inter(
                    fontSize: 12.5.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff525252),
                  ),
                ),
              ),
              if (isInviteLinkActive) ...[
                SizedBox(height: 10.h),
                Row(
                  children: [
                    SizedBox(
                      height: 80.h,
                      width: 350.w,
                      child: TextField(
                        readOnly: true,
                        maxLines: null,
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 10.5),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Wrap(
                                children: [
                                  InkWell(
                                      onTap: () {},
                                      child: Icon(Icons.refresh,
                                          color: GlobalColors.orange)),
                                  SizedBox(
                                    width: 15.w,
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: Icon(Icons.copy,
                                        color: GlobalColors.orange),
                                  ),
                                ],
                              ),
                            ),
                            hintText:
                                'https://www.figma.com/design/7hCSTNzQOJLj9aww6wEEd1/',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: GlobalColors.borderColor),
                            )),
                      ),
                    )
                  ],
                ),
              ],
              Divider(
                color: GlobalColors.borderColor,
                thickness: 1.h,
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Text(
                    'Manage Members',
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: const Color(0xff0A0A0A)),
                  ),
                  const Spacer(),
                  CustomButton(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const InviteDialog();
                            });
                      },
                      borderColor: const Color(0xffF97316),
                      text: 'Invite people',
                      height: 31.h,
                      containerColor: const Color(0xffF97316),
                      width: 105.h,
                      textColor: const Color(0xffFFFFFF))
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                'On the Free plan all members in a workspace are administrators. ',
                style: GoogleFonts.inter(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color.fromARGB(255, 51, 50, 50),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  SizedBox(
                    height: 40.h,
                    width: 250.w,
                    child: CustomSearchField(
                      hintText: 'Search by name or email',
                      leading:
                          Icon(Icons.search, color: GlobalColors.gray200Color),
                    ),
                  ),
                  SizedBox(width: 13.w),
                  Expanded(
                    child: CustomDropdownButton(
                        initialValue: 'All',
                        items: const [
                          'All',
                          'Members',
                          'Suspended',
                          'Left workspace'
                        ],
                        borderColor: const Color(0xffCBD5E1),
                        height: 40.h,
                        containerColor: Colors.white,
                        width: 100.w,
                        textColor: const Color(0xff0F172A)),
                  )
                ],
              ),
              SizedBox(height: 10.w),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '3 active members',
                    style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff525252)),
                  ),
                  PopupMenuButton<String>(
                    offset: const Offset(0, 30),
                    padding: EdgeInsets.zero,
                    icon: const Icon(
                      Icons.more_vert_rounded,
                      size: 25,
                      color: Color(0xff525252),
                    ),
                    onSelected: (value) {
                      // Handle the selected action here
                      if (value == 'delete') {
                        showDialog(
                          context: context,
                          builder: (context) => const DeleteMemberDialog(),
                        );
                      }
                    },
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<String>>[
                      PopupMenuItem<String>(
                        value: 'delete',
                        padding: EdgeInsets.zero,
                        child: SizedBox(
                          height: 20,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                bottom: 4.0,
                              ),
                              child: Text(
                                'Delete member',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xff09090B),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  CustomAvatar(
                      profileEmailStyle: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff525252),
                      ),
                      profileNameStyle: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xff525252),
                      ),
                      padding: 0,
                      radius: 23,
                      profileName: 'Chad Bosewick',
                      profileEmail: 'ChadBoseW@gmail.com'),
                  const Spacer(),
                  CustomDropdownButton(
                      initialValue: 'Admin',
                      items: const ['Admin', 'User', 'Guest'],
                      borderColor: Colors.transparent,
                      height: 40.h,
                      containerColor: Colors.white,
                      width: 90.w,
                      textColor: const Color(0xff525252)),
                ],
              ),
              const Divider(),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  CustomAvatar(
                      profileEmailStyle: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff525252),
                      ),
                      profileNameStyle: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xff525252),
                      ),
                      padding: 0,
                      radius: 23,
                      profileName: 'Chad Bosewick',
                      profileEmail: 'ChadBoseW@gmail.com'),
                  const Spacer(),
                  CustomDropdownButton(
                      initialValue: 'Admin',
                      items: const ['Admin', 'User', 'Guest'],
                      borderColor: Colors.transparent,
                      height: 40.h,
                      containerColor: Colors.white,
                      width: 90.w,
                      textColor: const Color(0xff525252)),
                ],
              ),
              const Divider(),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  CustomAvatar(
                      profileEmailStyle: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff525252),
                      ),
                      profileNameStyle: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xff525252),
                      ),
                      padding: 0,
                      radius: 23,
                      profileName: 'Chad Bosewick',
                      profileEmail: 'ChadBoseW@gmail.com'),
                  const Spacer(),
                  CustomDropdownButton(
                      initialValue: 'Admin',
                      items: const ['Admin', 'User', 'Guest'],
                      borderColor: Colors.transparent,
                      height: 40.h,
                      containerColor: Colors.white,
                      width: 90.w,
                      textColor: const Color(0xff525252)),
                ],
              ),
              const Divider(),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    'Export Members List',
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: const Color(0xff0A0A0A)),
                  ),
                  const Spacer(),
                  CustomButton(
                      onTap: () {},
                      borderColor: const Color(0xffF97316),
                      text: 'Export CSV',
                      height: 31.h,
                      containerColor: Colors.white,
                      width: 91.h,
                      textColor: const Color(0xffF97316))
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                'Export a CSV with information of all members of your team',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff525252),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
