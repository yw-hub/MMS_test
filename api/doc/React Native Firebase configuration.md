# Set up Firebase Notification in React-native App (Android only)

What need to be edited and applied is made bold in the code.

## Settings
Because currently we don't have Paid Apple Developer Account, the Firebase configuration is only available on Android device.

Firstly, created a new project fcm (should be our project Medical Secretary here).

    react-native init fcm
    cd fcm
    yarn
    yarn add react-native-firebase
    react-native link react-native-firebase

Go to Firebase console <https://firebase.google.com/console>, create a project there.

You can know the package name from android/app/src/main/java/com/fcm/MainApplication.java. In that file you can see something like this

    package com.fcm;
    
It is the package name we need when we create the Android app in Firebase.

Create an Android app, download google-services.json file. Copy that json file to android/app

**Go to `android/build.gradle`**

<pre>
// Top-level build file where you can add configuration options common to all sub-projects/modules.

buildscript {
    repositories {
        <b>google()</b>
        jcenter()
        maven {
            url 'https://maven.google.com/'
            name 'Google'
        }
    }
    dependencies {
        <b>classpath 'com.android.tools.build:gradle:3.1.2'
        classpath 'com.google.gms:google-services:3.2.1'</b>
        // NOTE: Do not place your application dependencies here; they belong
        // in the individual module build.gradle files
    }
}
	
allprojects {
    repositories {
        mavenLocal()
        <b>google()</b>
        jcenter()
        maven {
            // All of React Native (JS, Obj-C sources, Android binaries) is installed from npm
            url "$rootDir/../node_modules/react-native/android"
        }
        maven {
            url 'https://maven.google.com/'
            name 'Google'
        }
    }
}
<b>	
ext {
    buildToolsVersion = "26.0.3"
    minSdkVersion = 16
    compileSdkVersion = 26
    targetSdkVersion = 26
    supportLibVersion = "26.1.0"
}</b>
</pre>

**Go to `android/app/build.gradle`**

<pre>
project.ext.react = [
    entryFile: "index.js"
]

apply from: "../../node_modules/react-native/react.gradle"

/**
 * Set this to true to create two separate APKs instead of one:
 *   - An APK that only works on ARM devices
 *   - An APK that only works on x86 devices
 * The advantage is the size of the APK is reduced by about 4MB.
 * Upload all the APKs to the Play Store and people will download
 * the correct one based on the CPU architecture of their device.
 */
def enableSeparateBuildPerCPUArchitecture = false

/**
 * Run Proguard to shrink the Java bytecode in release builds.
 */
def enableProguardInReleaseBuilds = false

android {
   <b> compileSdkVersion rootProject.ext.compileSdkVersion
    buildToolsVersion rootProject.ext.buildToolsVersion </b>

    defaultConfig {
        applicationId "com.fcm"
       <b> minSdkVersion rootProject.ext.minSdkVersion
        targetSdkVersion rootProject.ext.targetSdkVersion </b>
        versionCode 1
        versionName "1.0"
        ndk {
            abiFilters "armeabi-v7a", "x86"
        }
    }
    splits {
        abi {
            reset()
            enable enableSeparateBuildPerCPUArchitecture
            universalApk false  // If true, also generate a universal APK
            include "armeabi-v7a", "x86"
        }
    }
    buildTypes {
        release {
            minifyEnabled enableProguardInReleaseBuilds
            proguardFiles getDefaultProguardFile("proguard-android.txt"), "proguard-rules.pro"
        }
    }
    // applicationVariants are e.g. debug, release
    applicationVariants.all { variant ->
        variant.outputs.each { output ->
            // For each separate APK per architecture, set a unique version code as described here:
            // http://tools.android.com/tech-docs/new-build-system/user-guide/apk-splits
            def versionCodes = ["armeabi-v7a":1, "x86":2]
            def abi = output.getFilter(OutputFile.ABI)
            if (abi != null) {  // null for the universal-debug, universal-release variants
                output.versionCodeOverride =
                        versionCodes.get(abi) * 1048576 + defaultConfig.versionCode
            }
        }
    }
}
dependencies {
    <b>implementation project(':react-native-firebase')
    implementation fileTree(dir: "libs", include: ["*.jar"])
    implementation "com.android.support:appcompat-v7:${rootProject.ext.supportLibVersion}"
    implementation "com.facebook.react:react-native:+"  // From node_modules
    implementation "com.google.android.gms:play-services-base:15.0.0"
    implementation "com.google.firebase:firebase-core:15.0.2"
    implementation "com.google.firebase:firebase-messaging:15.0.2"
    implementation 'me.leolin:ShortcutBadger:1.1.21@aar'</b>
}

// Run this once to be able to run the application with BUCK
// puts all compile dependencies into folder libs for BUCK to use
task copyDownloadableDepsToLibs(type: Copy) {
    from configurations.compile
    into 'libs'
}
<b>apply plugin: 'com.google.gms.google-services'</b>
</pre>

**Go to `android/gradle/wrapper/gradle-wrapper.properties`**

<pre>
distributionBase=GRADLE_USER_HOME
distributionPath=wrapper/dists
zipStoreBase=GRADLE_USER_HOME
zipStorePath=wrapper/dists
distributionUrl=https\://services.gradle.org/distributions/<b>gradle-4.4-all.zip</b>
</pre>

**Go to `android/app/src/main/java/com/fcm/MainApplication.java`**

<pre>
package com.fcm;
import android.app.Application;
import com.facebook.react.ReactApplication;
import io.invertase.firebase.RNFirebasePackage;
<b>import io.invertase.firebase.messaging.RNFirebaseMessagingPackage;
import io.invertase.firebase.notifications.RNFirebaseNotificationsPackage;</b>
import com.facebook.react.ReactNativeHost;
import com.facebook.react.ReactPackage;
import com.facebook.react.shell.MainReactPackage;
import com.facebook.soloader.SoLoader;
import java.util.Arrays;
import java.util.List;
public class MainApplication extends Application implements ReactApplication {
  private final ReactNativeHost mReactNativeHost = new ReactNativeHost(this) {
    @Override
    public boolean getUseDeveloperSupport() {
      return BuildConfig.DEBUG;
    }
    @Override
    protected List<ReactPackage> getPackages() {
      return Arrays.<ReactPackage>asList(
          new MainReactPackage(),
            new RNFirebasePackage(),
              <b>new RNFirebaseMessagingPackage(),
                new RNFirebaseNotificationsPackage()</b>
      );
    }
    @Override
    protected String getJSMainModuleName() {
      return "index";
    }
  };
  @Override
  public ReactNativeHost getReactNativeHost() {
    return mReactNativeHost;
  }
  @Override
  public void onCreate() {
    super.onCreate();
    SoLoader.init(this, /* native exopackage */ false);
  }
}
</pre>

**Go to `android/app/src/main/AndroidManifest.xml`**

```
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.fcm">
    
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.SYSTEM_ALERT_WINDOW"/>
    <uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED" />
    <uses-permission android:name="android.permission.VIBRATE" />

    <application
      android:name=".MainApplication"
      android:label="@string/app_name"
      android:icon="@mipmap/ic_launcher"
      android:allowBackup="false"
      android:theme="@style/AppTheme">
      <activity
        android:name=".MainActivity"
        android:label="@string/app_name"
        android:configChanges="keyboard|keyboardHidden|orientation|screenSize"
        android:windowSoftInputMode="adjustResize"
        android:launchMode="singleTop">
        <intent-filter>
            <action android:name="android.intent.action.MAIN" />
            <category android:name="android.intent.category.LAUNCHER" />
        </intent-filter>
      </activity>
      <activity android:name="com.facebook.react.devsupport.DevSettingsActivity" />
        <service android:name="io.invertase.firebase.messaging.RNFirebaseMessagingService">
            <intent-filter>
                <action android:name="com.google.firebase.MESSAGING_EVENT" />
            </intent-filter>
        </service>
        <service android:name="io.invertase.firebase.messaging.RNFirebaseInstanceIdService">
            <intent-filter>
                <action android:name="com.google.firebase.INSTANCE_ID_EVENT"/>
            </intent-filter>
        </service>
        <service android:name="io.invertase.firebase.messaging.RNFirebaseBackgroundMessagingService" />
    </application>

</manifest>
```

Try to run it to see it there is any problems

	react-native run-android

##Coding
Go to your `App.js` file

<pre>
/**
 * Sample React Native App
 * https://github.com/yangnana11/react-native-fcm-demo
 *
 * @format
 * @flow
 */
import React, {Component} from 'react';
import {Platform, StyleSheet, Text, View} from 'react-native';
<b>import firebase from 'react-native-firebase';
import type { Notification, NotificationOpen } from 'react-native-firebase';</b>

const instructions = Platform.select({
  ios: 'Press Cmd+R to reload,\n' + 'Cmd+D or shake for dev menu',
  android:
    'Double tap R on your keyboard to reload,\n' +
    'Shake or press menu button for dev menu',
});

export default class App extends Component {
    <b>async componentDidMount() {
    // Before you are able to send and receive Cloud Messages, 
    // you need to ensure that the user has granted the correct permissions
    const enabled = await firebase.messaging().hasPermission();
    if (enabled) {
        // user has permissions
    } else {
        // user doesn't have permission
        try {
            await firebase.messaging().requestPermission();
            // User has authorised
        } catch (error) {
            // User has rejected permissions
            alert('No permission for notification');
        }
    }
    //console.log("delete")
    //firebase.iid().deleteToken();
    // Retrieve the current registration token
    const fcmToken = await firebase.messaging().getToken();
    if (fcmToken) {
        // user has a device token
        console.log("token: " + fcmToken)
    } else {
        // user doesn't have a device token yet
        alert('No device token yet');

    }

    // The onTokenRefresh callback fires with the latest registration token whenever a new token is generated.
    firebase.messaging().onTokenRefresh(fcmToken => {
            // Process your token as required
            console.log("refreshtoken: " + fcmToken)

    }); 

    // when app is closed
    const  notificationOpen: NotificationOpen = await firebase.notifications().getInitialNotification();
    if (notificationOpen) {
        // App was opened by a notification
        // Get the action triggered by the notification being opened
        const action = notificationOpen.action;
        const notification: Notification = notificationOpen.notification;
        if (notification.body!==undefined) {
            alert(notification.body);
        } else {
        console.log(notification)
        var seen = [];
        alert(JSON.stringify(notification.data, function(key, val) {
            if (val != null && typeof val == "object") {
                if (seen.indexOf(val) >= 0) {
                    return;
                }
                seen.push(val);
            }
            return val;
        }));
    }
    firebase.notifications().removeDeliveredNotification(notification.notificationId);
    }
    
    const channel = new firebase.notifications.Android.Channel('test-channel', 'Test Channel', firebase.notifications.Android.Importance.Max)
            .setDescription('My apps test channel');
    // Create the channel
    firebase.notifications().android.createChannel(channel);

    firebase.messaging().subscribeToTopic('news1');


    /*
    when app is opened
    */
    // onNotificationDisplayed - Triggered when a particular notification has been displayed
    this.notificationDisplayedListener = firebase.notifications().onNotificationDisplayed((notification: Notification) => {
        // Process your notification as required
        // ANDROID: Remote notifications do not contain the channel ID. You will have to specify this manually if you'd like to re-display the notification.
        console.log('onNotificationDisplayed')
        console.log(notification);
    });

    // onNotification - Triggered when a particular notification has been received
    this.notificationListener = firebase.notifications().onNotification((notification: Notification) => {
        // Process your notification as required
        console.log('get Message');
        console.log(notification);
        notification
            .android.setChannelId('test-channel')
            .android.setSmallIcon('ic_launcher');
        firebase.notifications()
            .displayNotification(notification);

    });
    

    // If your app is in the foreground, or background, 
    // you can listen for when a notification is clicked / tapped / opened as follows:
    this.notificationOpenedListener = firebase.notifications().onNotificationOpened((notificationOpen: NotificationOpen) => {
        // Get the action triggered by the notification being opened
        const action = notificationOpen.action;
        // Get information about the notification that was opened
        const notification: Notification = notificationOpen.notification;
        // if app is in the foreround, notification is defined
        if (notification.body!==undefined) {
            alert(notification.body);
        } else {
        // if app is in the backround, notification is undefined
          console.log(notification)
          var seen = [];
          alert(JSON.stringify(notification.data, function(key, val) {
              if (val != null && typeof val == "object") {
                  if (seen.indexOf(val) >= 0) {
                      return;
                  }
                  seen.push(val);
              }
              return val;
          }));
        }
        firebase.notifications().removeDeliveredNotification(notification.notificationId);

    });
} 
   
componentWillUnmount() {
        this.notificationDisplayedListener();
        this.notificationListener();
        this.notificationOpenedListener();
}</b>

render() {
    return (
      <View style={styles.container}>
        <Text style={styles.welcome}>Welcome to React Native!</Text>
        <Text style={styles.instructions}>To get started, edit App.js</Text>
        <Text style={styles.instructions}>{instructions}</Text>
      </View>
    );
  }
}
const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
});
</pre>

##Test

There are two [types of message](https://firebase.google.com/docs/cloud-messaging/concept-options?authuser=0#notifications_and_data_messages) in that one way to send **Generic Notification** using [Notification Composer](https://console.firebase.google.com/u/0/project/_/notification/compose):

![Testing FCM — Generic Notification](https://cdn-images-1.medium.com/max/1600/1*qdT257IH2HqPOyToGDJ2Dw.png)

> As per documentation,

> - **Notification Message** - FCM automatically displays the message to end-user devices on behalf of the client app. Notification messages have a predefined set of user-visible keys and an optional data payload of custom key-value pairs.
- **Data Message** - Client app is responsible for processing data messages. Data messages have only custom key-value pairs.

###Send Data Message using HTTP protocol with POSTMAN

You have to copy **_Legecy Server Key_** from _Firebase Console > Project Settings > Cloud Messaging_

Note: Firebase has upgraded our server keys to a new version. You may continue to use your Legacy server key, but it is recommended that you upgrade to the newest version.

- Select `POST.` Enter request URL as **<https://fcm.googleapis.com/fcm/send>**
- Add **Headers** `Authorization: key=<legacy_server_key>` OR `Authorization: key=<server_key>` and `Content-Type: application/json`.

![Setting-up with POSTMAN](https://cdn-images-1.medium.com/max/1600/1*36bkM5NH__LZpISMLIw-4Q.png)

- Now Select **Body > raw > JSON (application/json)** and add following code:

<pre>
{
 "to" : <b>"YOUR_FCM_TOKEN_WILL_BE_HERE"</b>,
 "collapse_key" : "type_a",
 "notification" : {
     "body" : "Body of Your Notification",
     "title": "Title of Your Notification"
 },
 "data" : {
     "body" : "Body of Your Notification in Data",
     "title": "Title of Your Notification in Title",
     "key_1" : "Value for key_1",
     "key_2" : "Value for key_2"
 }
}
</pre>

- Now You can send a **Generic** notification (using `notification` payload) or a Custom notifications (using `notification` and `data` payload) and Click on **Send**.

<pre>
{
 "to" : <b>"YOUR_FCM_TOKEN_WILL_BE_HERE"</b>,
 "collapse_key" : "type_a",
 "data" : {
     "body" : "Sending Notification Body From Data",
     "title": "Notification Title from Data",
     "key_1" : "Value for key_1",
     "key_2" : "Value for key_2"
 }
}
</pre>

- Note that **Custom** notification will only trigger if there is only `data` (without `notification`) node in the payload. Hence, you’d need to move the `body` and `title` to `data` node.