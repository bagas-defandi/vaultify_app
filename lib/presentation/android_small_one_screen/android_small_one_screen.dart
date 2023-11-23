import 'package:flutter/material.dart';
import 'package:vaulity_application1/core/app_export.dart';
import 'package:vaulity_application1/widgets/custom_elevated_button.dart';

class AndroidSmallOneScreen extends StatelessWidget {
  const AndroidSmallOneScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 28.h,
            vertical: 41.v,
          ),
          child: Column(
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgLogoVaulitify1,
                height: 160.v,
                width: 251.h,
              ),
              SizedBox(height: 12.v),
              _buildOneRow(context),
              SizedBox(height: 12.v),
              _buildThreeRow(context),
              SizedBox(height: 21.v),
              _buildAndroidSmallColumn(context),
              SizedBox(height: 5.v),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildChooseFileButton(BuildContext context) {
    return CustomElevatedButton(
      height: 30.v,
      width: 95.h,
      text: "Choose File",
      margin: EdgeInsets.only(bottom: 1.v),
      buttonStyle: CustomButtonStyles.fillBlueGray,
      buttonTextStyle: theme.textTheme.bodySmall!,
    );
  }

  /// Section Widget
  Widget _buildOneRow(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 1.h),
      padding: EdgeInsets.symmetric(
        horizontal: 9.h,
        vertical: 7.v,
      ),
      decoration: AppDecoration.outlinePrimary.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder5,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildChooseFileButton(context),
          Padding(
            padding: EdgeInsets.only(
              left: 8.h,
              top: 7.v,
              bottom: 8.v,
            ),
            child: Text(
              "File Name",
              style: theme.textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildUploadButton(BuildContext context) {
    return CustomElevatedButton(
      height: 29.v,
      width: 83.h,
      text: "Upload",
      buttonStyle: CustomButtonStyles.fillBlueGray,
      buttonTextStyle: theme.textTheme.bodySmall!,
    );
  }

  /// Section Widget
  Widget _buildThreeRow(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 1.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildUploadButton(context),
          Container(
            decoration: AppDecoration.fillBlueGray.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder5,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 5.v,
                    bottom: 7.v,
                  ),
                  child: Text(
                    "Search",
                    style: theme.textTheme.bodySmall,
                  ),
                ),
                CustomImageView(
                  imagePath: ImageConstant.imgGroup4,
                  height: 29.v,
                  width: 30.h,
                  margin: EdgeInsets.only(left: 6.h),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildListOfFilesButton(BuildContext context) {
    return CustomElevatedButton(
      height: 43.v,
      text: "List of Files",
      buttonStyle: CustomButtonStyles.outlinePrimary,
      buttonTextStyle: theme.textTheme.bodyMedium!,
    );
  }

  /// Section Widget
  Widget _buildDelete(BuildContext context) {
    return CustomElevatedButton(
      width: 55.h,
      text: "Delete",
    );
  }

  /// Section Widget
  Widget _buildDelete1(BuildContext context) {
    return CustomElevatedButton(
      width: 55.h,
      text: "Delete",
    );
  }

  /// Section Widget
  Widget _buildDelete2(BuildContext context) {
    return CustomElevatedButton(
      width: 55.h,
      text: "Delete",
    );
  }

  /// Section Widget
  Widget _buildAndroidSmallColumn(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 1.h),
      decoration: AppDecoration.outlinePrimary.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder5,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildListOfFilesButton(context),
          SizedBox(height: 21.v),
          Padding(
            padding: EdgeInsets.only(
              left: 15.h,
              right: 12.h,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Daftar Belanja November",
                      style: theme.textTheme.bodySmall,
                    ),
                    SizedBox(height: 1.v),
                    Text(
                      "10/10/23",
                      textAlign: TextAlign.center,
                      style: CustomTextStyles.bodySmall10,
                    ),
                    SizedBox(height: 28.v),
                    Text(
                      "Latihan Coding",
                      style: theme.textTheme.bodySmall,
                    ),
                    Text(
                      "18/11/23",
                      textAlign: TextAlign.center,
                      style: CustomTextStyles.bodySmall10,
                    ),
                    SizedBox(height: 28.v),
                    Text(
                      "Tugas Mobile Deveploment",
                      style: theme.textTheme.bodySmall,
                    ),
                    SizedBox(height: 1.v),
                    Padding(
                      padding: EdgeInsets.only(left: 2.h),
                      child: Text(
                        "18/11/23",
                        textAlign: TextAlign.center,
                        style: CustomTextStyles.bodySmall10,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 5.v,
                    bottom: 8.v,
                  ),
                  child: Column(
                    children: [
                      _buildDelete(context),
                      SizedBox(height: 34.v),
                      _buildDelete1(context),
                      SizedBox(height: 42.v),
                      _buildDelete2(context),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 54.v),
        ],
      ),
    );
  }
}
