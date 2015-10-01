# Metal Gear Solid V: The Phantom Pain Teleport Bind Script
A basic Lua script to save and warp to saved location, along with warping to your buddy's position.

### Controls
Circle + DPAD Left - Save your current position

Circle + DPAD Right - Load your saved position

Circle + DPAD Down - Teleport to buddy's position

### Installing
The script belongs in the TppPlayer.lua file, and uses the e.Update function as a hook. Find the e.Update function and replace the entire function with the teleport code. Load into the world and try one of the binds above. It will alert you when you use a command successfully.
