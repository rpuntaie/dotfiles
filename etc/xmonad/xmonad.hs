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
import XMonad.Actions.CycleWS               -- Goto nex/previous WS.
-- Misc
import XMonad.Hooks.UrgencyHook
import XMonad.Util.EZConfig                 -- Emacs style keybindings
import XMonad.Util.NamedScratchpad
import XMonad.Actions.WindowBringer
import XMonad.Util.Run(spawnPipe)
import qualified Data.Map as M
import System.Exit
import Data.Maybe

---- Run XMonad ----

main = xmonad =<< xmobar (
  withUrgencyHook NoUrgencyHook $ myConfig `additionalKeys` legacyKeybindings
                         )

myConfig = def { borderWidth        = 1
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
               }


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
    [ ("M-q"         , moveTo Prev nonNSPNonEmptyHiddenWs ) -- Previous non-NSP and non-empty workspace
    , ("M-w"         , moveTo Next nonNSPNonEmptyHiddenWs ) -- Next non-NSP and non-empty workspace
    , ("M-<Tab>"     , toggleWS' ["NSP"]                  ) -- Go to the workspace displayed previously (except NSP)
    -- I should learn Haskell in order to make this fit in 2-3 lines
    , ("M-1"         , windows $ W.greedyView "1"         )
    , ("M-S-l"       , windows $ W.shift "1"              )
    , ("M-2"         , windows $ W.greedyView "2"         )
    , ("M-S-2"       , windows $ W.shift "2"              )
    , ("M-3"         , windows $ W.greedyView "3"         )
    , ("M-S-3"       , windows $ W.shift "3"              )
    , ("M-4"         , windows $ W.greedyView "4"         )
    , ("M-S-4"       , windows $ W.shift "4"              )
    , ("M-5"         , windows $ W.greedyView "5"         )
    , ("M-S-5"       , windows $ W.shift "5"              )
    , ("M-6"         , windows $ W.greedyView "6"         )
    , ("M-S-6"       , windows $ W.shift "6"              )
    , ("M-7"         , windows $ W.greedyView "7"         )
    , ("M-S-7"       , windows $ W.shift "7"              )
    , ("M-8"         , windows $ W.greedyView "8"         )
    , ("M-S-8"       , windows $ W.shift "8"              )
    , ("M-9"         , windows $ W.greedyView "9"         )
    , ("M-S-9"       , windows $ W.shift "9"              )
    , ("M-0"         , windows $ W.greedyView "0"         )
    , ("M-S-0"       , windows $ W.shift "0"              )
    ] ++
    -- Focus/Moving
    [ ("M-j"         , windows W.focusDown         ) -- Move focus to the previous window
    , ("M-k"         , windows W.focusUp           ) -- Move focus to the next window
    , ("M-S-j"       , windows W.swapDown          ) -- Swap the current window with the previous window
    , ("M-S-k"       , windows W.swapUp            ) -- Swap the current window with the next window
    , ("M-a"         , windows W.focusMaster       ) -- Focus the master window
    , ("M-s"         , windows W.swapMaster        ) -- Swap the focused window and the master window
    , ("M-r"         , gotoMenu                    )
    , ("M-S-r"       , bringMenu                   )
    ] ++
    -- Resizing
    [ ("M-h"         , sendMessage Shrink          ) -- Horizontally shrink the master pane
    , ("M-l"         , sendMessage Expand          ) -- Horizontally expand the master pane
    , ("M-<Down>"    , sendMessage MirrorShrink    ) -- Vertically expand the focused window
    , ("M-<Up>"      , sendMessage MirrorExpand    ) -- Vertically shrink the focused window
    ] ++
    -- Floating
    [ ("M-g"         , withFocused $ float            ) -- Switch the focused window to floating
    , ("M-y"         , withFocused $ windows . W.sink ) -- Put back the focused window in tiling
    ] ++
    -- Function keys
    [ ("<XF86Display>" , arandr      ) -- Launch arandr
    , ("<XF86Tools>"   , setKeyboard ) -- (Re)configure the kayboard's layout
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
   [ title =? "pinentry-gtk-2" --> doFloat
   , namedScratchpadManageHook myScratchpads
   , manageDocks
   ]

---- Helpers ----

lockScreen       = "lock.sh"
programLauncher  = "exe=`dmenu_path | dmenu` && eval \"exec $exe\""
passMenu         = "pass-menu"
xmonadExit       = io exitSuccess
xmonadRestart    = spawn "xmonad --recompile; xmonad --restart"
toggleFullscreen = sequence_ [sendMessage $ Toggle NBFULL, sendMessage $ ToggleGaps]
arandr           = spawn "arandr"
setKeyboard      = spawn "setxkbmap -layout ch -variant fr -option caps:escape -option shift:both_capslock"

-- Workspace-related

myWorkspaces     = ["1","2","3","4","5","6","7","8","9","0"]
isHidden         = do hs <- gets (map W.tag . W.hidden . windowset)
                      return (\w -> W.tag w `elem` hs)

nonNSPNonEmptyHiddenWs = WSIs $ do
                                hi <- isHidden
                                return (\w -> nnsp w && ne w && hi w)
                                    where nnsp (W.Workspace tag _ _) = tag /= "NSP"
                                          ne = isJust . W.stack
