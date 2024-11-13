# Add your ProGuard rules here
# By default, the flags in this file are appended to flags specified
# in /usr/share/android/proguard/proguard-android.txt
# You can edit the include path and order by changing the proguardFiles
# directive in build.gradle.

# Add any project specific keep options here:
#PUSHER
-keep class com.pusher.client.** { *; }

# For example:
# -keep class com.example.myproject.** { *; }
# الحفاظ على جميع الأنشطة (Activities) في التطبيق
-keep class * extends android.app.Activity

# الحفاظ على جميع الخدمات (Services) في التطبيق
-keep class * extends android.app.Service

# الحفاظ على جميع مستلمي البث (Broadcast Receivers) في التطبيق
-keep class * extends android.content.BroadcastReceiver

# الحفاظ على جميع مزودي المحتوى (Content Providers) في التطبيق
-keep class * extends android.content.ContentProvider

# الحفاظ على جميع طرق (Methods) الأون كليك (onClick) المستخدمة في XML
-keepclassmembers class * {
    public void onClick(android.view.View);
}

# الحفاظ على جميع طرق (Methods) الأون كرييت (onCreate) في الأنشطة (Activities)
-keepclassmembers class * {
    void onCreate(android.os.Bundle);
}

# الحفاظ على جميع العناصر الداخلية (Inner Classes) كما هي
-keepattributes InnerClasses

# الحفاظ على جميع التعليقات التوضيحية (Annotations)
-keepattributes *Annotation*

# الحفاظ على جميع الأنواع (Enums)
-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}

# الحفاظ على جميع واجهات (Interfaces) Parcelable
-keep class * implements android.os.Parcelable {
    public static final android.os.Parcelable$Creator *;
}
