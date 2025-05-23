-- after change: xmonad --recompile

import XMonad
import XMonad.Core
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops
import XMonad.Util.EZConfig(additionalKeys)
import qualified Data.Map as M

import XMonad.Util.Dmenu
import System.Exit
import System.IO
import System.Environment (getEnv)
import Control.Monad
quitWithWarning :: X ()
quitWithWarning = do
    let m = "confirm quit"
    s <- dmenu [m]
    when (m == s) (io exitSuccess)

main = do
    xmonad $ def {
        modMask = mod4Mask, -- win-L would lock Windows, ranger modified to g1,g2,...
        -- terminal = "xterm -fa monaco -fs 10 -bg black -fg white",
        -- terminal = "alacritty",
        terminal = "urxvt",
        keys = mixKeys,
        layoutHook = Full ||| Tall 1 (3/100) (1/2)
        }
    xmonad $ ewmhFullscreen $ def

mixKeys x = M.union (M.fromList (newKeys x)) (keys def x)
newKeys x = [
        ((modMask x, xK_s), spawn "scrot -s")
        , ((modMask x, xK_u), spawn "scrot -u")
        , ((modMask x .|. shiftMask,   xK_q), quitWithWarning)
        , ((modMask x .|. shiftMask,   xK_p), spawn "passmenu --type")
        ]

