plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    // END: FlutterFire Configuration
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.taskly"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
        isCoreLibraryDesugaringEnabled = true   // ✔ KTS syntax
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

   defaultConfig {
    applicationId = "com.example.taskly"

    minSdk = flutter.minSdkVersion        
    targetSdk = 34

    versionCode = 1
    versionName = "1.0"
}


    buildTypes {
        getByName("release") {
            isMinifyEnabled = false
            isShrinkResources = false
        }
    }

}

flutter {
    source = "../.."
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
}
