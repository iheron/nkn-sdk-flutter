plugins {
    id("com.android.library")
    id("org.jetbrains.kotlin.android")
}

group = "org.nkn.nkn_sdk_flutter"
version = "1.0-SNAPSHOT"

repositories {
    google()
    mavenCentral()
}

android {
    namespace = "org.nkn.nkn_sdk_flutter"
    compileSdk = 34

    sourceSets {
        getByName("main") {
            java.srcDirs("src/main/kotlin")
        }
    }

    defaultConfig {
        minSdk = 21
    }

    lint {
        disable += "InvalidPackage"
    }
}

dependencies {
    // File dependency (not flatDir) so consuming apps resolve this AAR from the
    // plugin module path instead of looking for app/libs/nkn.aar.
    implementation(files(layout.projectDirectory.file("libs/nkn.aar")))
    implementation("org.bouncycastle:bcprov-jdk15to18:1.68")
    implementation("org.jetbrains.kotlinx:kotlinx-coroutines-android:1.6.4")
    implementation("androidx.lifecycle:lifecycle-viewmodel-ktx:2.7.0")
}
