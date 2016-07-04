import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName
import XMonad.Hooks.FadeInactive
import XMonad.Layout.BinarySpacePartition
import XMonad.Layout.EqualSpacing
import XMonad.Layout.Gaps
import XMonad.Layout.PerWorkspace
import XMonad.Layout.NoBorders
import XMonad.Actions.NoBorders
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

main = xmonad =<< statusBar myBar myPP toggleStrutKey myConfig

myBar = "xmobar"

xmobarCurrentWorkspaceColor = "#800000"
myPP = xmobarPP {
    ppTitle = const "",
    ppLayout = const "",
    ppCurrent = xmobarColor xmobarCurrentWorkspaceColor "",
    ppSep = "   "
}

toggleStrutKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

myWorkspaces = ["1: <fn=1>\xf120</fn> ",
    "2: <fn=1>\xf268</fn> ",
    "3: <fn=1>\xf1bc</fn> ",
    "4: <fn=1>\xf03d</fn> "
    ] ++ map (\x -> show x ++ ": <fn=1>\xf128</fn> ") [5..9]

myManageHook = composeAll
    [ className =? "chromium-browser-chromium" --> doShift (myWorkspaces !! 1)
    , className =? "Spotify" --> doShift (myWorkspaces !! 2)
    , className =? "mpv" --> doShift (myWorkspaces !! 3)
    , manageDocks
    ]

myLogHook = composeAll
    [ setWMName "LG3D"
    , fadeInactiveLogHook 0.65
    ]

myLayout = onWorkspaces [(myWorkspaces !! 3)] layoutFull
         $ avoidStruts
         $ equalSpacing 36 6 1 1
         $ emptyBSP
    where
        layoutFull = avoidStruts $ noBorders Full

myConfig = defaultConfig
    { workspaces = myWorkspaces
    , logHook = myLogHook
    , handleEventHook = docksEventHook <+> handleEventHook defaultConfig
    , manageHook = myManageHook <+> manageHook defaultConfig
    , layoutHook = myLayout
    , modMask = mod4Mask
    , terminal = "st"
    } `additionalKeys`
    [ ((mod4Mask .|. shiftMask, xK_z), spawn "slock")
    , ((mod4Mask, xK_g), withFocused toggleBorder)
    , ((mod4Mask, xK_r), sendMessage Rotate)
    , ((0, 0x1008ff14), spawn "playerctl play-pause")
    , ((0, 0x1008ff16), spawn "playerctl previous")
    , ((0, 0x1008ff17), spawn "playerctl next")
    ]
