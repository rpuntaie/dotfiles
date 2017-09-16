-- Xmonad config file.
-- Written by Fnux.
--
-- Xmonad
import XMonad
import XMonad.Actions.CycleWS -- Goto nex/previous WS.
import XMonad.Hooks.DynamicLog -- WS info for xmobar.
import XMonad.Hooks.ManageDocks -- Dock Management.
import XMonad.Hooks.UrgencyHook -- Urgent windows.
import XMonad.Layout.Reflect -- Turn layout by 180°.
import XMonad.Layout.MultiToggle -- Toggle layout transformers.
import XMonad.Layout.MultiToggle.Instances -- Layout transformers.
import XMonad.Actions.WindowBringer
import XMonad.StackSet as W
import XMonad.ManageHook
import XMonad.Util.NamedScratchpad
import XMonad.Util.Run(spawnPipe)

-- Haskell
import Data.Monoid -- Add hooks together. (?)
import System.Exit -- Quit Xmonad

-- Qualified
import qualified XMonad.StackSet as W -- Xmonad commands.
import qualified Data.Map as M -- For keybindings.

-------------------------------------------------------------------------------
-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal      = "urxvt"
 
-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True
 
-- Width of the window border in pixels.
--
myBorderWidth   = 1
 
-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask       = mod1Mask

-------------------------------------------------------------------------------
-- Workspaces & Windows.
--

-- The default number of workspaces (virtual screens) and their names.
--
myWorkspaces    = ["1","2","3","4","5","6","7","8","9","0"]
 
-- Border colors for unfocused and focused windows, respectively.
--
myNormalBorderColor  = "#dddddd"
myFocusedBorderColor = "#ff0000"

-------------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
-- 

-- Keycodes for various weird keys.
--
xK_XF86Display = 0x1008ff59

myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
 
    -- Launch a terminal
    [ ((modm,               xK_Return), spawn $ XMonad.terminal conf)
 
    -- Launch dmenu
    , ((modm,               xK_p     ), spawn "exe=`dmenu_path | dmenu` && eval \"exec $exe\"")
    , ((modm,               xK_d     ), spawn "exe=`dmenu_path | dmenu` && eval \"exec $exe\"")

    -- Password selector
    , ((modm,               xK_e     ), spawn "~/.local/opt/utils/bin/pass-menu")

    -- Window switcher (goto)
    , ((modm,               xK_o     ), gotoMenu)
    
    -- Window switcher (bring)
    , ((modm .|. shiftMask, xK_o     ), bringMenu)

    -- close focused window
    , ((modm,               xK_c     ), kill)
 
     -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)
 
    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)
 
    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)

    -- Toggle Fullscreen
    , ((modm,               xK_f     ), sendMessage $ Toggle NBFULL)
 
    -- Move focus to the next window
    , ((modm,               xK_Tab   ), windows W.focusDown)
 
    -- Move focus to the next window
    , ((modm,               xK_j     ), windows W.focusDown)
 
    -- Move focus to the previous window
    , ((modm,               xK_k     ), windows W.focusUp  )
 
    -- Move focus to the master window
    , ((modm,               xK_z     ), windows W.focusMaster  )
 
    -- Swap the focused window and the master window
    , ((modm,               xK_m), windows W.swapMaster)
 
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

    -- Move to the next workspace
    , ((modm,               xK_dollar), nextWS)
    , ((modm,               xK_w), nextWS)

    -- Move to the previous workspace
    , ((modm,               xK_adiaeresis), prevWS)
    , ((modm,               xK_q), prevWS)
 
    -- Lock
    , ((modm,               xK_a), spawn "i3lock -i ~/Pictures/wallpaper.png -t")

    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --
    , ((modm              , xK_b     ), sendMessage ToggleStruts)
 
    -- Quit xmonad
    , ((modm .|. shiftMask, xK_r     ), io (exitWith ExitSuccess))
 
    -- Restart xmonad
    , ((modm              , xK_r     ), spawn "xmonad --recompile; xmonad --restart")
    ]
    ++
 
    -- Function keys
    --
    [ ((0, xK_XF86Display), spawn "arandr")]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) ([xK_1 .. xK_9] ++ [xK_0])
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    -- ++
 
    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    --[((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
    --    | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
    --    , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

------------------------------------------------------------------------
-- Layouts:
 
-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
myLayout = mkToggle (single NBFULL) (tiled ||| Mirror tiled ||| reflectHoriz tiled)
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
-- manageDocks Makes sure xmonad doesn't try to manage windows that are
-- docks. See XMonad.Hooks.ManageDocks.
--
myManageHook = manageDocks
                -- <+> namedScratchpadManageHook myScratchpads
                <+> manageHook def

------------------------------------------------------------------------
-- Event handling
 
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
-- * NOTE: EwmhDesktops users should use the 'ewmh' function from
-- XMonad.Hooks.EwmhDesktops to modify their defaultConfig as a whole.
-- It will add EWMH event handling to your custom event hooks by
-- combining them with ewmhDesktopsEventHook.
--
myEventHook = docksEventHook
 
------------------------------------------------------------------------
-- Status bars and logging
 
-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
--
-- * NOTE: EwmhDesktops users should use the 'ewmh' function from
-- XMonad.Hooks.EwmhDesktops to modify their defaultConfig as a whole.
-- It will add EWMH logHook actions to your custom log hook by
-- combining it with ewmhDesktopsLogHook.
--
myLogHook = return ()
 
------------------------------------------------------------------------
-- Startup hook
 
-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
--
-- * NOTE: EwmhDesktops users should use the 'ewmh' function from
-- XMonad.Hooks.EwmhDesktops to modify their defaultConfig as a whole.
-- It will add initialization of EWMH support to your custom startup
-- hook by combining it with ewmhDesktopsStartup.
--
myStartupHook = return ()

-------------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.
 
-- Run xmonad with the settings you specify. No need to modify this.
--
main = xmonad =<< xmobar defaults
 
-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
--
-- No need to modify this.
--
defaults = defaultConfig {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        -- numlockMask deprecated in 0.9.1
        -- numlockMask        = myNumlockMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,
 
      -- key bindings
        keys               = myKeys,
--        mouseBindings      = myMouseBindings,
 
      -- hooks, layouts
        layoutHook         = myLayout,
        manageHook         = myManageHook,
        handleEventHook    = myEventHook,
        logHook            = myLogHook,
        startupHook        = myStartupHook
    }
