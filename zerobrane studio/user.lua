local G = ...
package {
  onRegister = function(self) G.ide.debugger.toggleview.bottomnotebook =
true end
}
activateoutput = false

path.love2d = '/home/yoann/.local/bin/love'
default.interpreter = "love2d"
acandtip.nodynwords = false
singleinstance = false
autoanalyzer = true
menuicon = false
excludelist = {["bin/"] = true ,["assets/"] = true, ["libs/"] = true, ["banks/"] = true, ["scripts/"] = true, ["tiled/"] = true, ["fonts/"] = true, ["*.html"] = true, ["*.json"] = true, ["*.md"] = true}

output.fontname = "Ubuntu Mono"
output.fontsize = 12

console.fontname = "Ubuntu Mono"
console.fontsize = 12

filetree.fontname = "Ubuntu"
filetree.fontsize = 11
filetree.iconmap = false

imagetint={0, 71, 171}

editor={
    fontname = "Ubuntu Mono",
    fontsize = 14,
    tabwidth = 4,
    linenumber = true,
    showfncall = true,
    calltipdelay = 100,
    saveallonrun = true,
    indentguide = false,
    smartindent = true,
    nomousezoom = true,
    backspaceunindent = true,
    edgemode = wxstc.wxSTC_EDGE_NONE,
    fold = false,
    foldtype = 'arrow',
    foldflags = 0
}

local function h2d(n) return 0+('0x'..n) end
local function H(c, bg) c = c:gsub('#','')
  local bg = bg and H(bg) or {255, 255, 255}
  local a = #c > 6 and h2d(c:sub(7,8))/255 or 1
  local r, g, b = h2d(c:sub(1,2)), h2d(c:sub(3,4)), h2d(c:sub(5,6))
  return {
    math.min(255, math.floor((1-a)*bg[1]+a*r)),
    math.min(255, math.floor((1-a)*bg[2]+a*g)),
    math.min(255, math.floor((1-a)*bg[3]+a*b))}
end

local colors = {
    Background  = H'252525',
    CurrentLine = H'293739',
    Selection   = H'44475A',
    Foreground  = H'F8F8F2',
    Comment     = H'75715E',
    Grey     = H'999999',
    White       = H'F8F8F8',
    Red         = H'DC5244',
    Purple      = H'AB80BB',
    Pink        = H'FF69B4',
    Orange      = H'e98743',
    Yellow       = H'c5e519',
    Aqua        = H'88bdef',
    Blue        = H'8BE9FD',
    Green      = H'55d165'
}

keymap[ID.VIEWOUTPUT] = "Ctrl-J"
keymap[ID.VIEWFILETREE] = "Ctrl-E"
keymap[ID.SHOWTOOLTIP] = "Alt-T"
keymap[ID.VIEWFULLSCREEN] = "F11"
keymap[ID.COMMENT] = "Ctrl-Shift-C"

styles.text = {bg = colors.Background, fg = colors.Aqua}
styles.auxwindow = {bg = colors.Background, fg = colors.Foreground}
styles.calltip = {bg = colors.Background, fg = colors.Foreground}
styles.indicator = {
    varglobal = {st = wxstc.wxSTC_INDIC_TEXTFORE, fg = colors.Orange, b = true},
    varlocal = {st = wxstc.wxSTC_INDIC_TEXTFORE, fg = colors.Green},
    varself= {st = wxstc.wxSTC_INDIC_TEXTFORE, fg = colors.Aqua},
    fncall = {st = wxstc.wxSTC_INDIC_TEXTFORE, fg = colors.Pink}
}

styles.lexerdef = {fg = colors.Foreground}
styles.stringtxt = {fg = colors.Yellow}
styles.preprocessor = {fg = colors.Orange}
styles.operator = {fg = colors.Orange}
styles.number = {fg = colors.White}
styles.comment = {fg = colors.Comment, fill = true}
styles.bracematch = {fg = colors.Aqua, b = true}
styles.bracemiss = {fg = colors.Orange, b = true}
styles.keywords0 = {fg = colors.Grey, b = true}
styles.keywords1 = {fg = colors.Purple, b = true, i = true}
styles.keywords2 = {fg = colors.Grey, b = true}
styles.keywords3 = {fg = colors.Grey, b = true}
styles.keywords4 = {fg = colors.Grey, b = true}
styles.keywords5 = {fg = colors.Grey, b = true}
styles.keywords6 = {fg = colors.Grey, b = true}
styles.keywords7 = {fg = colors.Grey, b = true}

stylesoutshell = styles