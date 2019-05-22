  
--
-- xmonad example config file.
--
-- A template showing all available configuration hooks,
-- and how to override the defaults in your own xmonad.hs conf file.
--
-- Normally, you'd only override those defaults you care about.
--

import XMonad
import Data.Monoid
import System.Exit

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal      = "xterm"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = False

-- Width of the window border in pixels.
--
myBorderWidth   = 1

-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask       = mod1Mask

-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--
myWorkspaces    = ["1","2","3","4","5","6","7","8","9"]

-- Border colors for unfocused and focused windows, respectively.
--
myNormalBorderColor  = "#dddddd"
myFocusedBorderColor = "#ff0000"

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch a terminal
    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)

    -- launch dmenu
    , ((modm,               xK_p     ), spawn "dmenu_run")

    -- launch gmrun
    , ((modm .|. shiftMask, xK_p     ), spawn "gmrun")

    -- close focused window
    , ((modm .|. shiftMask, xK_c     ), kill)

     -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)

    -- Move focus to the next window
    , ((modm,               xK_Tab   ), windows W.focusDown)

    -- Move focus to the next window
    , ((modm,               xK_j     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modm,               xK_k     ), windows W.focusUp  )

    -- Move focus to the master window
    , ((modm,               xK_m     ), windows W.focusMaster  )

    -- Swap the focused window and the master window
    , ((modm,               xK_Return), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )

    -- Shrink the master area
    , ((modm,               xK_h     ), sendMessage Shrink)

    -- Expand the master area
    , ((modm,               xK_l     ), sendMessage Expand)

    -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))

    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --
    -- , ((modm              , xK_b     ), sendMessage ToggleStruts)

    -- Quit xmonad
    , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))

    -- Restart xmonad
    , ((modm              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")

    -- Run xmessage with a summary of the default keybindings (useful for beginners)
    , ((modm .|. shiftMask, xK_slash ), spawn ("echo \"" ++ help ++ "\" | xmessage -file -"))
    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
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

------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
myLayout = tiled ||| Mirror tiled ||| Full
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100

------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = composeAll
    [ className =? "MPlayer"        --> doFloat
    , className =? "Gimp"           --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore ]

------------------------------------------------------------------------
-- Event handling

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook
--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
myEventHook = mempty

------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
myLogHook = return ()

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook = return ()

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
--
main = xmonad defaults

-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
--
-- No need to modify this.
--
defaults = def {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook         = myLayout,
        manageHook         = myManageHook,
        handleEventHook    = myEventHook,
        logHook            = myLogHook,
        startupHook        = myStartupHook
    }

-- | Finally, a copy of the default bindings in simple textual tabular format.
help :: String
help = unlines ["The default modifier key is 'alt'. Default keybindings:",
    "",
    "-- launching and killing programs",
    "mod-Shift-Enter  Launch xterminal",
    "mod-p            Launch dmenu",
    "mod-Shift-p      Launch gmrun",
    "mod-Shift-c      Close/kill the focused window",
    "mod-Space        Rotate through the available layout algorithms",
    "mod-Shift-Space  Reset the layouts on the current workSpace to default",
    "mod-n            Resize/refresh viewed windows to the correct size",
    "",
    "-- move focus up or down the window stack",
    "mod-Tab        Move focus to the next window",
    "mod-Shift-Tab  Move focus to the previous window",
    "mod-j          Move focus to the next window",
    "mod-k          Move focus to the previous window",
    "mod-m          Move focus to the master window",
    "",
    "-- modifying the window order",
    "mod-Return   Swap the focused window and the master window",
    "mod-Shift-j  Swap the focused window with the next window",
    "mod-Shift-k  Swap the focused window with the previous window",
    "",
    "-- resizing the master/slave ratio",
    "mod-h  Shrink the master area",
    "mod-l  Expand the master area",
    "",
    "-- floating layer support",
    "mod-t  Push window back into tiling; unfloat and re-tile it",
    "",
    "-- increase or decrease number of windows in the master area",
    "mod-comma  (mod-,)   Increment the number of windows in the master area",
    "mod-period (mod-.)   Deincrement the number of windows in the master area",
    "",
    "-- quit, or restart",
    "mod-Shift-q  Quit xmonad",
    "mod-q        Restart xmonad",
    "mod-[1..9]   Switch to workSpace N",
    "",
    "-- Workspaces & screens",
    "mod-Shift-[1..9]   Move client to workspace N",
    "mod-{w,e,r}        Switch to physical/Xinerama screens 1, 2, or 3",
    "mod-Shift-{w,e,r}  Move client to screen 1, 2, or 3",
    "",
    "-- Mouse bindings: default actions bound to mouse events",
    "mod-button1  Set the window to floating mode and move by dragging",
    "mod-button2  Raise the window to the top of the stack",
    "mod-button3  Set the window to floating mode and resize by dragging"]
  
  
--    -------------------------
--    -- Fnux's Xmonad setup --
--    -------------------------
--    
--    ---- Imports ----
--    
--    -- XMonad
--    import XMonad
--    import XMonad.ManageHook
--    import XMonad.Hooks.ManageDocks
--    import XMonad.Actions.WindowBringer
--    import qualified XMonad.StackSet as W
--    -- Layouts
--    import XMonad.Layout.Spacing
--    import XMonad.Layout.Gaps
--    import XMonad.Layout.Tabbed
--    import XMonad.Layout.ResizableTile
--    import XMonad.Layout.Reflect                -- Turn layout by 180°.
--    import XMonad.Layout.MultiToggle            -- Toggle layout transformers.
--    import XMonad.Layout.MultiToggle.Instances  -- Layout transformers.
--    -- Workspaces
--    import XMonad.Hooks.DynamicLog              -- WS info for xmobar.
--    import XMonad.Actions.DynamicWorkspaces
--    import XMonad.Actions.CycleWS               -- Goto nex/previous WS.
--    -- Prompt
--    import XMonad.Prompt
--    import XMonad.Prompt.Shell
--    import XMonad.Prompt.Window
--    import Text.Regex.Base
--    -- Misc
--    import XMonad.Hooks.UrgencyHook
--    import XMonad.Hooks.ManageDocks
--    import XMonad.Util.EZConfig                 -- Emacs style keybindings
--    import XMonad.Util.NamedScratchpad
--    import XMonad.Util.Run
--    import qualified Data.Map as M
--    import System.Exit
--    import Data.Maybe
--    
--    ---- Run XMonad ----
--    
--    main = do
--      bar <- spawnPipe "xmobar"
--      xmonad $ withUrgencyHook NoUrgencyHook
--             $ myConfig bar `additionalKeys` legacyKeybindings
--    
--    myConfig bar = def { borderWidth        = 1
--                   , focusFollowsMouse  = True
--                   , normalBorderColor  = "#6e6b5e"
--                   , focusedBorderColor = "#8e2803"
--                   , terminal           = "urxvt256c"
--                   , modMask            = mod4Mask
--                   , keys               = myKeys
--                   , mouseBindings      = myMouseBindings
--                   , workspaces         = myWorkspaces
--                   , layoutHook         = myLayout
--                   , manageHook         = myManageHook
--                   , handleEventHook    = docksEventHook
--                   , logHook            = dynamicLogWithPP $ myPP bar
--                   }
--    
--    ---- Helpers ----
--    
--    lockScreen       = "lock.sh"
--    programLauncher  = "exe=`dmenu_path | dmenu` && eval \"exec $exe\""
--    passMenu         = "pass-menu"
--    xmonadExit       = io exitSuccess
--    xmonadRestart    = spawn "xmonad --recompile; xmonad --restart"
--    toggleFullscreen = sequence_ [sendMessage $ Toggle NBFULL, sendMessage $ ToggleGaps]
--    arandr           = spawn "arandr"
--    setKeyboard      = spawn "setxkbmap -layout ch -variant fr -option caps:escape -option shift:both_capslock"
--    
--    ---- Keybindings ----
--    
--    myKeys conf = mkKeymap conf $
--        -- Basics
--        [ ("M-<Return>"  , spawn $ XMonad.terminal conf      ) -- Open a new terminal
--        , ("M-d"         , spawn programLauncher             ) -- Launcher
--        , ("M-e"         , spawn passMenu                    ) -- Password menu
--        , ("M-S-s"       , spawn lockScreen                  ) -- Lock screen
--        , ("M-c"         , kill                              ) -- Close focused window
--        , ("M-S-<Delete>", xmonadExit                        ) -- Quit XMonad
--        , ("M1-S-r"      , xmonadRestart                     ) -- Restart XMonad
--        ] ++
--        -- Layout(s)
--        [ ("M-,"         , sendMessage (IncMasterN 1)         ) -- Increment the number of windows in the master area
--        , ("M-."         , sendMessage (IncMasterN (-1))      ) -- Decrement the number of windows in the master area
--        , ("M-f"         , toggleFullscreen                   ) -- Toggle FullScreen
--        , ("M-z"         , sendMessage ToggleStruts           ) -- Toggle top margin (xmobar)
--        , ("M-<Space>"   , sendMessage NextLayout             ) -- Rotate through the available layout algorithms
--        , ("M-S-<Space>" , setLayout $ XMonad.layoutHook conf ) --  Reset the layouts on the current workspace to default
--        ] ++
--        -- WorkSpaces
--        [ ("M-q"         , cleanWss $ moveTo Prev nonNSPHiddenWs                       )
--        , ("M-w"         , cleanWss $ moveTo Next nonNSPHiddenWs                       )
--        , ("M-<Tab>"     , toggleWS' ["NSP"]                                           )
--        , ("M-p"         , cleanWss $ selectWorkspace myPromptConfig                   )
--        , ("M-S-p"       , cleanWss $ withWorkspace myPromptConfig (windows . W.shift) )
--        , ("M-C-p"       , cleanWss $ renameWorkspace myPromptConfig                   )
--    
--        -- I should learn Haskell in order to make this fit in 2-3 lines
--        , ("M-1"         , windows $ W.greedyView "main"      )
--        , ("M-S-1"       , windows $ W.shift "main"           )
--        , ("M-2"         , windows $ W.greedyView "www"       )
--        , ("M-S-2"       , windows $ W.shift "www"            )
--        , ("M-3"         , windows $ W.greedyView "chat"      )
--        , ("M-S-3"       , windows $ W.shift "chat"           )
--        , ("M-4"         , windows $ W.greedyView "mail"      )
--        , ("M-S-4"       , windows $ W.shift "mail"           )
--        ] ++
--        -- Focus/Moving
--        [ ("M-j"          , windows W.focusDown                                     ) -- Move focus to the previous window
--        , ("M-k"         , windows W.focusUp                                       ) -- Move focus to the next window
--        , ("M-S-j"       , windows W.swapDown                                      ) -- Swap the current window with the previous window
--        , ("M-S-k"       , windows W.swapUp                                        ) -- Swap the current window with the next window
--        , ("M-a"         , windows W.focusMaster                                   ) -- Focus the master window
--        , ("M-s"         , windows W.swapMaster                                    ) -- Swap the focused window and the master window
--        , ("M-S-r"       , bringMenu                          )
--        , ("M-r"         , gotoMenu                           )
--        ] ++
--        -- Resizing
--        [ ("M-h"         , sendMessage Shrink                 ) -- Horizontally shrink the master pane
--        , ("M-l"         , sendMessage Expand                 ) -- Horizontally expand the master pane
--        , ("M-<Down>"    , sendMessage MirrorShrink           ) -- Vertically expand the focused window
--        , ("M-<Up>"      , sendMessage MirrorExpand           ) -- Vertically shrink the focused window
--        ] ++
--        -- Floating
--        [ ("M-g"         , withFocused $ float                ) -- Switch the focused window to floating
--        , ("M-y"         , withFocused $ windows . W.sink     ) -- Put back the focused window in tiling
--        ] ++
--        -- Function keys
--        [ ("<XF86Display>" , arandr                           ) -- Launch arandr
--        , ("<XF86Tools>"   , setKeyboard                      ) -- (Re)configure the kayboard's layout
--        ]
--    
--    legacyKeybindings =
--      -- Scratchpad(s)
--      [((mod4Mask, xK_section), namedScratchpadAction myScratchpads "tmux-scratchpad")]
--    
--    ---- Mouse bindings ----
--    
--    myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $
--        -- mod-button1, Set the window to floating mode and move by dragging
--        [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
--                                           >> windows W.shiftMaster))
--        -- mod-button2, Raise the window to the top of the stack
--        , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))
--        -- mod-button3, Set the window to floating mode and resize by dragging
--        , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
--                                           >> windows W.shiftMaster))
--        -- you may also bind events to the mouse scroll wheel (button4 and button5)
--        ]
--    
--    ---- Layouts ----
--    
--    myLayout = avoidStruts $ mkToggle (single NBFULL) (tiled |||  Mirror tiled ||| reflectHoriz tiled ||| simpleTabbed)
--      where
--        -- default tiling algorithm partitions the screen into two panes
--        tiled   = spacing 5 $ ResizableTall nmaster delta ratio []
--    
--        -- Tabbed layout
--        -- tabbedLayout = tabbed shrinkText def { inactiveBorderColor = "#FF0000", activeTextColor = "#00FF00"}
--    
--        -- The default number of windows in the master pane
--        nmaster = 1
--    
--        -- Default proportion of screen occupied by master pane
--        ratio   = 1/2
--    
--        -- Percent of screen to increment by when resizing panes
--        delta   = 3/100
--    
--        -- Gaps
--        outer_gaps = gaps [(U,5), (R,5), (D,5), (L,5)]
--    
--    ---- Scratchpads ----
--    
--    myScratchpads = [
--        NS "tmux-scratchpad" "urxvt -e tmux-scratchpad" (title =? "tmux-scratchpad") (customFloating $ W.RationalRect (1/6) (1/6) (2/3) (2/3))
--      ] where role = stringProperty "WM_WINDOW_ROLE"
--    
--    ---- ManageHook ----
--    
--    myManageHook = composeAll
--       [ title =? "pinentry-gtk-2"      --> doFloat
--       , title =? "Colour picker"       --> doFloat
--       , title =? "Dwarf Fortress"      --> doFloat
--       , appName =? "Game"              --> doFloat -- CS211 Project
--       , className =? "File-roller"     --> doFloat
--       , className =? "Thunderbird"     --> doShift "mail"
--       , className =? "Riot"            --> doShift "chat"
--       , className =? "TelegramDesktop" --> doShift "chat"
--       , namedScratchpadManageHook myScratchpads
--       , manageDocks
--       ]
--    
--    ---- PrettyPrinter for xmobar ----
--    
--    myPP bar = xmobarPP { ppHidden = wrap "[" "]"
--                        , ppHiddenNoWindows = pad
--                        , ppCurrent = xmobarColor "yellow" "" . wrap "[" "]"
--                        , ppOutput = hPutStrLn bar
--                        }
--    
--    -- Prompt
--    
--    myPromptConfig = def { font        = "xft:DejaVu Sans Mono:pixelsize=13"
--                         , position    = Top
--                         , fgColor     = "grey"
--                         , bgColor     = "black"
--                         , fgHLight    = "yellow"
--                         , bgHLight    = "black"
--                         , borderColor = "#6e6b5e"
--                         , autoComplete = Nothing
--                         }
--    
--    -- Workspace-related
--    
--    myWorkspaces     = ["main", "www", "chat", "mail"]
--    cleanWss         = removeEmptyWorkspaceAfterExcept myWorkspaces
--    isHidden         = do hs <- gets (map W.tag . W.hidden . windowset)
--                          return (\w -> W.tag w `elem` hs)
--    
--    nonNSPHiddenWs = WSIs $ do
--                            hi <- isHidden
--                            return (\w -> nnsp w && hi w)
--                              where nnsp (W.Workspace tag _ _) = tag /= "NSP"
