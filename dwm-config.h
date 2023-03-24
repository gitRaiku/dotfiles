#include <X11/XF86keysym.h>
#include "fibonacci.c"
#include "grid.c"

static const unsigned int borderpx  = 1;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const unsigned int vertpad   = 0;
static const unsigned int sidepad   = 0;
static const int user_bh            = 0; //bar height. 0 means dwm will automaticaly adjust it.
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const int swallowfloating    = 0;
static const char *fonts[]          = { "JetBrainsMono:size=12" };
static const char dmenufont[]       = "JetBrainsMono:size=15";
static const unsigned int gappx     = 10;
static const unsigned int smartgaps = 10; //number of px in the gaps when there is one window
static const unsigned int baralpha  = 135;
static const unsigned int borderalpha = OPAQUE;
static const char col_gray[]        = "#111111";
static const char col_gray1[]       = "#222222";
static const char col_gray2[]       = "#444444";
static const char col_gray3[]       = "#bbbbbb";
static const char col_gray4[]       = "#eeeeee";
static const char col_gray5[]       = "#555753";
static const char col_black[]       = "#000000";
static const char col_cyan[]        = "#005577";
static const char col_red[]         = "#fe3f09";
static const char col_blue[]        = "#0000ff";
static const char col_blue1[]       = "#3366ff";
static const char col_blue2[]        = "#222233";
static const char col_white[]       = "#ffffff";
static const char *colors[][3]      = {
	/*     fg         bg         border   */
	[SchemeNorm] = { col_gray3, col_gray, col_gray2 }, //minty schemenorm
	[SchemeSel] = { col_black, col_red, col_red, }, //minty schemesel
};	
static const unsigned int alphas[][3]      = {
      /*               fg      bg        border     */
      [SchemeNorm] = { OPAQUE, baralpha, borderalpha },
      [SchemeSel]  = { OPAQUE, baralpha, borderalpha },
};


/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };
//static const char *alttags[] = { "@read", "@write", "@execute", "@4", "@5", "@6", "@7", "@8", "@9" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      instance    title       tags mask     isfloating   monitor */
 { "Gimp",     NULL,       NULL,       0,            0,           -1 },
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 0;    /* 1 means respect size hints in tiled resizals */


static const Layout layouts[] = {

	/* symbol     arrange function */
	{ "[M]",      centeredmaster }, //1
	{ "[=]",      tile },    /* first entry is default */
	{ "[~]",      NULL },    /* no layout function means floating behavior */
	{ "[*]",      monocle }, //2
	{ "[@]",      spiral }, //3
	{ "[\\]",     dwindle }, //4
	{ "[#]",      grid }, //5
	{ "[F]",      centeredfloatingmaster }, //6
	{ "[T]",      bstack }, //7
	{ "[|]",      col }, //8
	//{ "[=]",      bstackhoriz }, //9
	{ NULL,       NULL },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },
#define HOLDKEY 0

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, NULL };
//static const char *dmenucmd[] = { "dmenu_run", "-c", "-l", "9", "-g", "3",  "-m", dmenumon, "-fn", dmenufont, "-nb", col_blue2, "-nf", col_gray4, "-sb", col_white, "-sf", col_black, "-p", "Run:", NULL };
static const char *termcmd[] = { "st", NULL };

static const char *spotifycmd[] = { "spotif", NULL };
static const char *discordcmd[] = { "discord", NULL };
static const char *qutecmd[]    = { "qutebrowser", NULL };
static const char *gimpcmd[]    = { "gimp", NULL };
static const char *scrotcmd[]   = { "scrot", "-e", "ctc $f && mv $f ~/Misc/Screenshots/", NULL };
static const char *scrtcmd[]    = { "scrot", "-e", "ctc $f && rm $f", NULL };
static const char *scrtgcmd[]    = { "scrot", "-e", "gimp $f && rm $f", NULL };

static const char *volUP[]      = { "chvol", "+", NULL };
static const char *volDOWN[]    = { "chvol", "-", NULL };

static const char *brtUP[]      = { "brightnessctl", "s", "+30%", NULL };
static const char *brtDOWN[]    = { "brightnessctl", "s", "30%-", NULL };
static const char *brtsUP[]     = { "brightnessctl", "s", "+1%", NULL };
static const char *brtsDOWN[]   = { "brightnessctl", "s", "1%-", NULL };

static const char *qwertycmd[]  = { "setxkbmap", "us", NULL };
static const char *colemakcmd[] = { "xmodmap", "/home/raiku/Git/mod-dh/xmodmap/colemak_dh_ansi_us.xmodmap", NULL };

static const char *chadcmd[]  = { "mpv", "/home/raiku/Misc/Downloads/chad-1.mp4", "--mute=yes", "--loop", NULL };
static const char *reliefcmd[]  = { "mpv", "/home/raiku/Misc/Downloads/Huge_Ship_Shaft_Forging_and_Machining_Process.webm", "--loop", NULL };

static const char *r2kcmd[]     = { "r2k", NULL };

static Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY|ShiftMask,             XK_Return, spawn,          {.v = termcmd } },
  { MODKEY|ShiftMask,             XK_s,      spawn,          {.v = spotifycmd } },
 	{ MODKEY|ShiftMask,             XK_d,      spawn,          {.v = discordcmd } },
	{ MODKEY|ShiftMask,             XK_p,      spawn,          {.v = qutecmd } },
	{ MODKEY|ShiftMask,             XK_o,      spawn,          {.v = qutecmd } },
	{ MODKEY|ShiftMask,             XK_g,      spawn,          {.v = gimpcmd } },
	{ MODKEY|ShiftMask,             XK_j,      spawn,          {.v = chadcmd } },
	{ MODKEY|ShiftMask,             XK_k,      spawn,          {.v = reliefcmd } },
	{ MODKEY|ShiftMask,             XK_h,      setcfact,       {.f = -0.05} },
	{ MODKEY|ShiftMask,             XK_l,      setcfact,       {.f = +0.05} },	
	{ MODKEY|ShiftMask,             XK_c,      killclient,     {0} },
	{ MODKEY|ShiftMask,             XK_f,      togglefullscr,  {0} },
	{ MODKEY|ControlMask,           XK_x,      spawn,          {.v = brtDOWN } },
	{ MODKEY|ControlMask,           XK_c,      spawn,          {.v = brtUP } },
	{ MODKEY|ControlMask|ShiftMask, XK_x,      spawn,          {.v = brtsDOWN } },
	{ MODKEY|ControlMask|ShiftMask, XK_c,      spawn,          {.v = brtsUP } },
	{ MODKEY|ControlMask,           XK_s,      spawn,          {.v = volDOWN } },
	{ MODKEY|ControlMask,           XK_d,      spawn,          {.v = volUP } },
	{ MODKEY,                       XK_p,      spawn,          {.v = dmenucmd } },
	{ MODKEY,                       XK_i,      spawn,          {.v = r2kcmd } },
	{ MODKEY,                       XK_grave,  togglebar,      {0} },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_equal,  incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_minus,  incnmaster,     {.i = -1 } }, 
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
	{ MODKEY,                       XK_Return, zoom,           {0} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	/*{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_o,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_r,      setlayout,      {.v = &layouts[3]} },
	{ MODKEY|ShiftMask,             XK_r,      setlayout,      {.v = &layouts[4]} },
	{ MODKEY,                       XK_g,      setlayout,      {.v = &layouts[5]} }, 
	{ MODKEY,                       XK_u,      setlayout,      {.v = &layouts[6]} },
	{ MODKEY|ShiftMask,             XK_u,      setlayout,      {.v = &layouts[7]} },
	{ MODKEY,                       XK_y,      setlayout,      {.v = &layouts[8]} },
	{ MODKEY,                       XK_i,      setlayout,      {.v = &layouts[9]} },*/
	{ MODKEY,                       XK_comma,  cyclelayout,    {.i = -1 } },
	{ MODKEY,                       XK_period, cyclelayout,    {.i = +1 } },
  { MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_bracketleft,  focusmon, {.i = -1 } },
	{ MODKEY,                       XK_bracketright, focusmon, {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_bracketleft,  tagmon,   {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_bracketright, tagmon,   {.i = +1 } },
  { 0,                            XK_Print,        spawn,    {.v = scrotcmd } },
  { MODKEY,                       XK_Print,        spawn,    {.v = scrtcmd } },
  { MODKEY|ShiftMask,             XK_Print,        spawn,    {.v = scrtgcmd } },
  { MODKEY,                       XK_z,            spawn,    {.v = qwertycmd } },
  { MODKEY,                       XK_x,            spawn,    {.v = colemakcmd } },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	{ MODKEY|ControlMask|ShiftMask, XK_q,      quit,           {1} },
	{ 0,                            HOLDKEY,    holdbar,        {0} },

};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

