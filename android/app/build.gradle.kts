plugins {
    id("com.android.application")
    id("kotlin-android")

    // Apply the Google Services plugin for Firebase
    id("com.google.gms.google-services")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.newdemo"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    defaultConfig {
        applicationId = "com.example.newdemo"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // Firebase BoM - centralized version management
    implementation(platform("com.google.firebase:firebase-bom:33.12.0"))

    // Add the Firebase SDKs you want to use
    implementation("com.google.firebase:firebase-analytics-ktx")
    // implementation("com.google.firebase:firebase-auth-ktx")         // Optional
    // implementation("com.google.firebase:firebase-firestore-ktx")    // Optional
    // implementation("com.google.firebase:firebase-storage-ktx")      // Optional
}
