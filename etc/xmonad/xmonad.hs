-------------------------
-- Fnux's Xmonad setup --
-------------------------

---- Imports ----

-- XMonad
import XMonad
import XMonad.ManageHook
import XMonad.Hooks.ManageDocks
import qualified XMonad.StackSet as W
-- Layouts
import XMonad.Layout.Spacing
import XMonad.Layout.Gaps
import XMonad.Layout.Tabbed
import XMonad.Layout.ResizableTile
import XMonad.Layout.Reflect                -- Turn layout by 180°.
import XMonad.Layout.MultiToggle            -- Toggle layout transformers.
import XMonad.Layout.MultiToggle.Instances  -- Layout transformers.
-- Workspaces
import XMonad.Hooks.DynamicLog              -- WS info for xmobar.
import XMonad.Actions.DynamicWorkspaces
import XMonad.Actions.CycleWS               -- Goto nex/previous WS.
-- Prompt
import XMonad.Prompt
import XMonad.Prompt.Shell
import XMonad.Prompt.Window
import Text.Regex.Base
import Text.Regex.Posix
-- Misc
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.ManageDocks
import XMonad.Util.EZConfig                 -- Emacs style keybindings
import XMonad.Util.NamedScratchpad
import XMonad.Util.Run
import qualified Data.Map as M
import System.Exit
import Data.Maybe

---- Run XMonad ----

main = do
  bar <- spawnPipe "xmobar"
  xmonad $ withUrgencyHook NoUrgencyHook
         $ myConfig bar `additionalKeys` legacyKeybindings

myConfig bar = def { borderWidth        = 1
               , focusFollowsMouse  = True
               , normalBorderColor  = "#6e6b5e"
               , focusedBorderColor = "#8e2803"
               , terminal           = "urxvt256c"
               , modMask            = mod4Mask
               , keys               = myKeys
               , mouseBindings      = myMouseBindings
               , workspaces         = myWorkspaces
               , layoutHook         = myLayout
               , manageHook         = myManageHook
               , handleEventHook = docksEventHook
               , logHook            = dynamicLogWithPP $ myPP bar
               }

---- Helpers ----

lockScreen       = "lock.sh"
programLauncher  = "exe=`dmenu_path | dmenu` && eval \"exec $exe\""
passMenu         = "pass-menu"
xmonadExit       = io exitSuccess
xmonadRestart    = spawn "xmonad --recompile; xmonad --restart"
toggleFullscreen = sequence_ [sendMessage $ Toggle NBFULL, sendMessage $ ToggleGaps]
arandr           = spawn "arandr"
setKeyboard      = spawn "setxkbmap -layout ch -variant fr -option caps:escape -option shift:both_capslock"

---- Keybindings ----

myKeys conf = mkKeymap conf $
    -- Basics
    [ ("M-<Return>"  , spawn $ XMonad.terminal conf      ) -- Open a new terminal
    , ("M-d"         , spawn programLauncher             ) -- Launcher
    , ("M-e"         , spawn passMenu                    ) -- Password menu
    , ("M-S-s"       , spawn lockScreen                  ) -- Lock screen
    , ("M-c"         , kill                              ) -- Close focused window
    , ("M-S-<Delete>", xmonadExit                        ) -- Quit XMonad
    , ("M1-S-r"      , xmonadRestart                     ) -- Restart XMonad
    ] ++
    -- Layout(s)
    [ ("M-,"         , sendMessage (IncMasterN 1)         ) -- Increment the number of windows in the master area
    , ("M-."         , sendMessage (IncMasterN (-1))      ) -- Decrement the number of windows in the master area
    , ("M-f"         , toggleFullscreen                   ) -- Toggle FullScreen
    , ("M-z"         , sendMessage ToggleStruts           ) -- Toggle top margin (xmobar)
    , ("M-<Space>"   , sendMessage NextLayout             ) -- Rotate through the available layout algorithms
    , ("M-S-<Space>" , setLayout $ XMonad.layoutHook conf ) --  Reset the layouts on the current workspace to default
    ] ++
    -- WorkSpaces
    [ ("M-q"         , cleanWss $ moveTo Prev nonNSPHiddenWs                       )
    , ("M-w"         , cleanWss $ moveTo Next nonNSPHiddenWs                       )
    , ("M-<Tab>"     , toggleWS' ["NSP"]                                           )
    , ("M-p"         , cleanWss $ selectWorkspace myPromptConfig                   )
    , ("M-S-p"       , cleanWss $ withWorkspace myPromptConfig (windows . W.shift) )
    , ("M-C-p"       , cleanWss $ renameWorkspace myPromptConfig                   )

    -- I should learn Haskell in order to make this fit in 2-3 lines
    , ("M-1"         , windows $ W.greedyView "main"      )
    , ("M-S-l"       , windows $ W.shift "main"           )
    , ("M-2"         , windows $ W.greedyView "www"       )
    , ("M-S-2"       , windows $ W.shift "www"            )
    , ("M-3"         , windows $ W.greedyView "chat"      )
    , ("M-S-3"       , windows $ W.shift "chat"           )
    , ("M-4"         , windows $ W.greedyView "mail"      )
    , ("M-S-4"       , windows $ W.shift "mail"           )
    ] ++
    -- Focus/Moving
    [ ("M-j"          , windows W.focusDown                                     ) -- Move focus to the previous window
    , ("M-k"         , windows W.focusUp                                       ) -- Move focus to the next window
    , ("M-S-j"       , windows W.swapDown                                      ) -- Swap the current window with the previous window
    , ("M-S-k"       , windows W.swapUp                                        ) -- Swap the current window with the next window
    , ("M-a"         , windows W.focusMaster                                   ) -- Focus the master window
    , ("M-s"         , windows W.swapMaster                                    ) -- Swap the focused window and the master window
    , ("M-S-r"       , cleanWss $ windowPrompt myPromptConfig Bring allWindows )
    , ("M-r"         , cleanWss $ windowPrompt myPromptConfig Goto  allWindows )
    ] ++
    -- Resizing
    [ ("M-h"         , sendMessage Shrink                 ) -- Horizontally shrink the master pane
    , ("M-l"         , sendMessage Expand                 ) -- Horizontally expand the master pane
    , ("M-<Down>"    , sendMessage MirrorShrink           ) -- Vertically expand the focused window
    , ("M-<Up>"      , sendMessage MirrorExpand           ) -- Vertically shrink the focused window
    ] ++
    -- Floating
    [ ("M-g"         , withFocused $ float                ) -- Switch the focused window to floating
    , ("M-y"         , withFocused $ windows . W.sink     ) -- Put back the focused window in tiling
    ] ++
    -- Function keys
    [ ("<XF86Display>" , arandr                           ) -- Launch arandr
    , ("<XF86Tools>"   , setKeyboard                      ) -- (Re)configure the kayboard's layout
    ]

legacyKeybindings =
  -- Scratchpad(s)
  [((mod4Mask, xK_section), namedScratchpadAction myScratchpads "tmux-scratchpad")]

---- Mouse bindings ----

myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $
    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))
    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))
    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))
    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

---- Layouts ----

myLayout = avoidStruts $ mkToggle (single NBFULL) (tiled |||  Mirror tiled ||| reflectHoriz tiled ||| simpleTabbed)
  where
    -- default tiling algorithm partitions the screen into two panes
    tiled   = spacing 5 $ ResizableTall nmaster delta ratio []

    -- Tabbed layout
    -- tabbedLayout = tabbed shrinkText def { inactiveBorderColor = "#FF0000", activeTextColor = "#00FF00"}

    -- The default number of windows in the master pane
    nmaster = 1

    -- Default proportion of screen occupied by master pane
    ratio   = 1/2

    -- Percent of screen to increment by when resizing panes
    delta   = 3/100

    -- Gaps
    outer_gaps = gaps [(U,5), (R,5), (D,5), (L,5)]

---- Scratchpads ----

myScratchpads = [
    NS "tmux-scratchpad" "urxvt -e tmux-scratchpad" (title =? "tmux-scratchpad") (customFloating $ W.RationalRect (1/6) (1/6) (2/3) (2/3))
  ] where role = stringProperty "WM_WINDOW_ROLE"

---- ManageHook ----

myManageHook = composeAll
   [ title =? "pinentry-gtk-2"      --> doFloat
   , title =? "Colour picker"       --> doFloat
   , className =? "Thunderbird"     --> doShift "mail"
   , className =? "Riot"            --> doShift "chat"
   , className =? "TelegramDesktop" --> doShift "chat"
   , namedScratchpadManageHook myScratchpads
   , manageDocks
   ]

---- PrettyPrinter for xmobar ----

myPP bar = xmobarPP { ppHidden = wrap "[" "]"
                    , ppHiddenNoWindows = pad
                    , ppCurrent = xmobarColor "yellow" "" . wrap "[" "]"
                    , ppOutput = hPutStrLn bar
                    }

-- Prompt

myPromptConfig = def { font        = "xft:DejaVu Sans Mono:pixelsize=13"
                     , position    = Top
                     , fgColor     = "grey"
                     , bgColor     = "black"
                     , fgHLight    = "yellow"
                     , bgHLight    = "black"
                     , borderColor = "#6e6b5e"
                     , searchPredicate = mySearchPredicate
                     }

mySearchPredicate :: String -> String -> Bool
mySearchPredicate typed = (=~ typed)

-- Workspace-related

myWorkspaces     = ["main", "www", "chat", "mail"]
cleanWss         = removeEmptyWorkspaceAfterExcept myWorkspaces
isHidden         = do hs <- gets (map W.tag . W.hidden . windowset)
                      return (\w -> W.tag w `elem` hs)

nonNSPHiddenWs = WSIs $ do
                        hi <- isHidden
                        return (\w -> nnsp w && hi w)
                          where nnsp (W.Workspace tag _ _) = tag /= "NSP"
