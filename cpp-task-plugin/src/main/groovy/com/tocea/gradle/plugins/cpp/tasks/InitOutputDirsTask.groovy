package com.tocea.gradle.plugins.cpp.tasks

import com.tocea.gradle.plugins.cpp.CppPluginUtils
import org.gradle.api.DefaultTask
import org.gradle.api.tasks.TaskAction

/**
 * Created by jguidoux on 08/09/15.
 */
public class InitOutputDirsTask extends DefaultTask {

    def outpoutDirs = CppPluginUtils.OUTPUT_DIRS

    @TaskAction
    void initOutputs() {
        def buildDirSet = new HashSet()
        outpoutDirs.each {
            buildDirSet << new File(project.buildDir, it)
        }

        buildDirSet.each { File file ->
            if (!file.exists()) {
                file.mkdirs()
            }
        }


    }

}
