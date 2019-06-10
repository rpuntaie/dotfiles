-- after change: xmonad --recompile
import XMonad
import XMonad.Core
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import qualified Data.Map as M
main = do
    xmonad $ defaultConfig {
        terminal = "alacritty",
	keys = myKeys,
        layoutHook = Tall 1 (3/100) (1/2) ||| Full
        }
myKeys x = M.union (M.fromList (newKeys x)) (keys defaultConfig x)
newKeys x = [
	((modMask x, xK_p), spawn "dmenu_run")
	]
  
