-- I'm still not super happy with this config. The COQDeps is kind if annoying to 
-- do as it overrides lazy.nvim window. Will see how I can improve it
return {
    "ms-jpq/coq_nvim",
    dependencies = {
        "ms-jpq/coq.artifacts",
    },
    build = ":COQdeps",
    config = function()
        local coq = require "coq"
        coq.Now("--shut-up") 
    end,
}