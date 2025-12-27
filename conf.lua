function love.conf(t)
	t.identity = "nikowa_nuclearrl"       -- The name of the save directory (string)
	t.appendidentity = true               -- Search files in source directory before save directory (boolean)
	t.version = "11.4"                    -- The LÖVE version this game was made for (string)
	t.console = true
	
	t.window.title = "NuclearRL"          -- The window title (string)
	t.window.fullscreentype = "exclusive" -- Choose between "desktop" fullscreen or "exclusive" fullscreen mode (string)
	
    t.window.width = 800                  -- The window width (number)
    t.window.height = 480                 -- The window height (number)
	
	t.window.resizable = true             -- Let the window be user-resizable (boolean)
	t.window.minwidth = 800               -- Minimum window width if the window is resizable (number)
	t.window.minheight = 480              -- Minimum window height if the window is resizable (number)
end