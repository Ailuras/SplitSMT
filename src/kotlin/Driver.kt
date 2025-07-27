import java.io.File

fun findJarRecursively(directory: File): List<File> {
    val jarFiles = mutableListOf<File>()
    
    directory.listFiles()?.forEach { file ->
        when {
            file.isFile && file.name.endsWith(".jar") -> jarFiles.add(file)
            file.isDirectory -> jarFiles.addAll(findJarRecursively(file))
        }
    }
    
    return jarFiles
}

fun main(args: Array<String>) {
    if (args.isNotEmpty()) {
        // 如果提供了参数，测试单个项目
        val targetPath = args[0]
        val targetFolder = File(targetPath)
        if (targetFolder.exists() && targetFolder.isDirectory()) {
            println("Testing single project: ${targetFolder.name}")
            println("Path: ${targetFolder.absolutePath}")
            try {
                File(targetFolder, "smt").deleteRecursively()
                interpret(targetFolder.absolutePath)
                println("✅ Analysis completed for ${targetFolder.name}")
            } catch (e: Throwable) {
                println("❌ Error processing ${targetFolder.name}: $e")
            }
        } else {
            println("❌ Directory not found: $targetPath")
            println("Usage: gradle run --args='path/to/project'")
            return
        }
    } else {
        // 如果没有参数，运行所有项目
        println("Running analysis on all projects in ./dataset")
        for (folder in File("./dataset").listFiles { file -> file.isDirectory() }!!){
            println("processing ${folder.name}")
            
            val jarFiles = findJarRecursively(folder)
            if (jarFiles.isEmpty()) {
                println("⚠️  No jar files found in ${folder.name} or its subdirectories")
                continue
            }
            
            println("Found ${jarFiles.size} jar file(s) in ${folder.name}")
            
            jarFiles.forEach { jarFile ->
                val projectDir = jarFile.parentFile
                println("  Processing: ${projectDir.name} (${jarFile.name})")
                try {
                    File(projectDir, "smt").deleteRecursively()
                    interpret(projectDir.absolutePath)
                    println("  ✅ Analysis completed for ${projectDir.name}")
                } catch (e: Throwable) {
                    println("  ❌ Error processing ${projectDir.name}: $e")
                }
            }
        }
    }
}
