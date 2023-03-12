-- This dependency adds some more faster fzf to telescope
-- We need to be careful with this as it needs make/compile so may not work
-- out of the box on any machine
return {
        'nvim-telescope/telescope-fzf-native.nvim', 
        module = true,
        build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
        lazy = false,
}