allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

subprojects {
    val project = this
    if (project.state.executed) {
        configureAndroidNamespace(project)
    } else {
        project.afterEvaluate {
            configureAndroidNamespace(project)
        }
    }
}

fun configureAndroidNamespace(project: Project) {
    if (project.extensions.findByName("android") != null) {
        @Suppress("UNCHECKED_CAST")
        val android = project.extensions.getByName("android") as com.android.build.gradle.BaseExtension
        if (android.namespace == null) {
            android.namespace = "com.example.musicplayer.${project.name.replace(":", ".")}"
        }
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
