return {
   cmd = {
      "jdtls",
      "-configuration", vim.fn.stdpath("cache") .. "/jdtls/config",
      "-data", vim.fn.stdpath("cache") .. "/jdtls/workspace"
   },
   filetypes = { "java" },
   --init_options = {
   --   jvm_args = {},
   --   workspace = "/home/runner/.cache/jdtls/workspace"
   --},
   root_markers = {
      "pom.xml",
      "build.gradle",
      "build.gradle.kts",
      "build.xml",
      "settings.gradle",
      "settings.gradle.kts",
      ".git",
   },
}
