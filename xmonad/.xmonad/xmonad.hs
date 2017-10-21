-------------------------
-- Fnux's Xmonad setup --
-------------------------

---- Imports ----

-- XMonad
import XMonad
import XMonad.ManageHook
import XMonad.Hooks.DynamicLog -- WS info for xmobar.
import XMonad.Hooks.ManageDocks
-- Layouts
import XMonad.Layout.Spacing
import XMonad.Layout.Gaps
import XMonad.Layout.Tabbed
import XMonad.Layout.ResizableTile
import XMonad.Layout.Reflect -- Turn layout by 180°.
import XMonad.Layout.MultiToggle -- Toggle layout transformers.
import XMonad.Layout.MultiToggle.Instances -- Layout transformers.

-- Misc
import XMonad.Actions.CycleWS -- Goto nex/previous WS.
import XMonad.Util.NamedScratchpad
import XMonad.Actions.WindowBringer
import XMonad.Util.Run(spawnPipe)
import System.Exit -- Quit Xmonad
import qualified XMonad.StackSet as W -- Xmonad commands.
import qualified Data.Map as M -- For keybindings.

---- Variables ----

myModMask             = mod4Mask
myTerminal            = "urxvt256c"
myLock                = "lock"
myMenu                = "exe=`dmenu_path | dmenu` && eval \"exec $exe\""
myPassMenu            = "pass-menu"
myWorkspaces          = ["1","2","3","4","5","6","7","8","9","0"]
myNormalBorderColor   = "#6e6b5e"
myFocusedBorderColor  = "#8e2803"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse   :: Bool
myFocusFollowsMouse   = True

-- Width of the window border in pixels.
myBorderWidth         = 1

---- Keybindings ----

-- Keycodes for weird keys.
xK_XF86Display = 0x1008ff59
xK_XF86Tools = 0x1008ff81

myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
  [
  -- Basics
    ((modm,                       xK_Return   ), spawn $ XMonad.terminal conf)  -- Launch term
  , ((modm,                       xK_d        ), spawn myMenu)                  -- Launch menu
  , ((modm,                       xK_e        ), spawn myPassMenu)              -- Launch passwords menu
  , ((modm,                       xK_a        ), spawn myLock)                  -- Lock screen
  , ((modm,                       xK_c        ), kill)                          -- Close focused window
  , ((modm .|. shiftMask,         xK_Delete   ), io (exitWith ExitSuccess))     -- Quit xmonad
  , ((mod1Mask .|. shiftMask,     xK_r        ), spawn "xmonad --recompile; xmonad --restart") -- Restart xmonad

  -- Misc
  , ((modm,                       xK_section  ), namedScratchpadAction myScratchpads "main") -- Scratchpad
  , ((modm,                       xK_r        ), gotoMenu) -- Window switcher (goto)
  , ((modm .|. shiftMask,         xK_r        ), bringMenu) -- Window switcher (bring)

  -- Layout(s)
  , ((modm,                       xK_comma    ), sendMessage (IncMasterN 1)) -- Increment the number of windows in the master area
  , ((modm,                       xK_period   ), sendMessage (IncMasterN (-1))) -- Deincrement the number of windows in the master area
  , ((modm,                       xK_f        ), sequence_ [sendMessage $ Toggle NBFULL, sendMessage $ ToggleGaps]) -- Fullscreen
  , ((modm,                       xK_z        ), sendMessage ToggleStruts) -- Toggle top margin
  , ((modm,                       xK_space    ), sendMessage NextLayout) -- Rotate through the available layout algorithms
  , ((modm .|. shiftMask,         xK_space    ), setLayout $ XMonad.layoutHook conf) --  Reset the layouts on the current workspace to default
  -- Floating stuff
  , ((modm,                       xK_y        ), withFocused $ windows . W.sink)
  , ((modm,                       xK_g        ), withFocused $ float)
  -- Workspaces
  , ((modm,                       xK_Tab      ), toggleWS' ["NSP"]) --Toggle to the workspace displayed previously
  , ((modm,                       xK_w        ), nextWS) -- Next workspace
  , ((modm,                       xK_q        ), prevWS) -- Previous workspace
  -- Focus/Moving
  , ((modm,                       xK_j        ), windows W.focusDown) -- Move focus to the previous window
  , ((modm,                       xK_Down     ), windows W.focusDown)
  , ((modm,                       xK_k        ), windows W.focusUp) -- Move focus to the next window
  , ((modm,                       xK_Up       ), windows W.focusUp)
  , ((modm .|. shiftMask,         xK_j        ), windows W.swapDown) -- Swap the focused window with the previous window
  , ((modm .|. shiftMask,         xK_k        ), windows W.swapUp) -- Swap the focused window with the next window
  , ((modm,                       xK_s        ), windows W.swapMaster) -- Swap the focused window and the master window
  -- resizing
  , ((modm,                       xK_h        ), sendMessage Shrink)
  , ((modm,                       xK_l        ), sendMessage Expand)
  , ((mod1Mask,                   xK_j        ), sendMessage MirrorShrink)
  , ((mod1Mask,                   xK_k        ), sendMessage MirrorExpand)
  , ((modm,                       xK_n        ), refresh) -- Resize viewed windows to the correct size
    ]
    ++
    -- Function keys
    [
      ((0, xK_XF86Display), spawn "arandr")
    , ((0, xK_XF86Tools), spawn "setxkbmap -layout ch -variant fr -option caps:swapescape")
    ]
    ++
    -- mod-[1..9] %! Switch to workspace N
    -- mod-shift-[1..9] %! Move client to workspace N
    [((m .|. modm, k), windows $ f i)
      | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
     ++ [
        ((modm, xK_0), (windows $ W.greedyView "0"))
        , ((modm .|. shiftMask, xK_0), (windows $ W.shift "0"))
      ]
    -- ++
    -- mod-{w,e,r} %! Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r} %! Move client to screen 1, 2, or 3
    --[((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
    --    | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
    --    , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

---- Mouse bindings ----
myMouseBindings :: XConfig t -> M.Map (KeyMask, Button) (Window -> X ())
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

myLayout = outer_gaps $ avoidStruts $ mkToggle (single NBFULL) (tiled |||  Mirror tiled ||| reflectHoriz tiled ||| tabbedLayout)
  where
    -- default tiling algorithm partitions the screen into two panes
    tiled   = spacing 5 $ ResizableTall nmaster delta ratio []

    -- Tabbed layout
    tabbedLayout = tabbed shrinkText def { inactiveBorderColor = "#FF0000", activeTextColor = "#00FF00"}

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
    NS "main" "urxvt -e tmux -2" (title =? "tmux") (customFloating $ W.RationalRect (1/6) (1/6) (2/3) (2/3))
  ] where role = stringProperty "WM_WINDOW_ROLE"

---- ManageHook ----

myManageHook = composeAll
   [ title =? "pinentry-gtk-2" --> doFloat
   , namedScratchpadManageHook myScratchpads
   , manageDocks
   ]

---- Configure! -----

defaults = defaultConfig {
    -- simple stuff
    terminal           = myTerminal,
    focusFollowsMouse  = myFocusFollowsMouse,
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
    manageHook         = myManageHook
    --handleEventHook    = myEventHook,
    --logHook            = myLogHook,
    --startupHook        = myStartupHook
}

---- Run! ----

main = xmonad =<< xmobar defaults
