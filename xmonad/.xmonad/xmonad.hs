import Data.Monoid
import System.IO
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.FadeInactive
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Layout.BinarySpacePartition
import XMonad.Layout.EqualSpacing
import XMonad.Layout.PerWorkspace
import XMonad.Util.EZConfig(additionalKeys)

main = xmonad =<< statusBar myBar myPP toggleStrutKey myConfig

altMask = mod1Mask

myBar = "xmobar"
myPP = xmobarPP {
    ppTitle = const "",
    ppLayout = const "",
    ppCurrent = xmobarColor xmobarCurrentWorkspaceColor "",
    ppHiddenNoWindows = xmobarColor xmobarInactiveColor "",
    ppSep = "   "
}
xmobarCurrentWorkspaceColor = "#f4e7d8"
xmobarInactiveColor = "#5a5047"

toggleStrutKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

myWorkspaces =
    [ "<fn=1>\xf120</fn>"
    , "<fn=1>\xf121</fn>"
    , "<fn=1>\xf268</fn>"
    ] ++ map show [4..9]

myManageHook = composeAll
    [ isFullscreen --> doFullFloat
    , className =? "chromium-browser-chromium" --> doShift (myWorkspaces !! 2)
    , className =? "mpv" --> doFloat
    , manageDocks
    ]

myLogHook = setWMName "LG3D"

myLayout = avoidStruts $ equalSpacing 20 4 1 1 $ emptyBSP

myConfig = defaultConfig
    { workspaces = myWorkspaces
    , logHook = myLogHook
    , handleEventHook = docksEventHook <+> handleEventHook defaultConfig
    , manageHook = myManageHook <+> manageHook defaultConfig
    , layoutHook = myLayout
    , modMask = mod4Mask
    , terminal = "urxvtc"
    , focusedBorderColor = "#584c3b"
    , normalBorderColor = "#2c261e"
    , borderWidth = 4
    } `additionalKeys`
    [ ((mod4Mask, xK_l), spawn "slock")
    , ((mod4Mask, xK_r), sendMessage Rotate)
    , ((mod4Mask, xK_s), sendMessage Swap)
    , ((mod4Mask, xK_f), withFocused $ \f -> windows =<< appEndo `fmap` runQuery doFullFloat f)
    , ((mod4Mask .|. altMask, xK_l), sendMessage $ ExpandTowards R)
    , ((mod4Mask .|. altMask, xK_h), sendMessage $ ExpandTowards L)
    , ((mod4Mask .|. altMask, xK_j), sendMessage $ ExpandTowards D)
    , ((mod4Mask .|. altMask, xK_k), sendMessage $ ExpandTowards U)
    , ((0, 0x1008ff14), spawn "playerctl play-pause")
    , ((0, 0x1008ff15), spawn "playerctl stop")
    , ((0, 0x1008ff16), spawn "playerctl previous")
    , ((0, 0x1008ff17), spawn "playerctl next")
    ]
