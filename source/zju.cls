\LoadClass{ctexart}
%宏包
\RequirePackage{xeCJK}
\RequirePackage{zhnumber}
\RequirePackage{graphicx}
\RequirePackage{geometry}
\RequirePackage{titlesec}
\RequirePackage{fancyhdr}
\RequirePackage{enumitem}
\RequirePackage{listings}
\RequirePackage{xcolor}
\RequirePackage{array}
\RequirePackage{mathtools}
\RequirePackage{float}
\RequirePackage{indentfirst}
\RequirePackage{multirow}
\RequirePackage{subfigure}
\RequirePackage{listings}
\RequirePackage{lmodern}
\RequirePackage{amssymb}


\setlength{\headheight}{15pt}

% 自定义信息参数传递
	\newcommand\articletitle[1]{\def\@articletitle{#1}}		%标题
	\newcommand\major[1]{\def\@major{#1}}					%专业
	\newcommand\college[1]{\def\@college{#1}}				%学院
	\newcommand\name[1]{\def\@name{#1}}						%姓名
	\newcommand\stuid[1]{\def\@stuid{#1}}					%学号
	\renewcommand\date[1]{\def\@date{#1}}					%日期
	\newcommand\course[1]{\def\@course{#1}}					%课程
	\newcommand\instructor[1]{\def\@instructor{#1}} 		%导师
	\newcommand\Abstract[1]{\def\@Abstract{#1}} 			%摘要
	\newcommand\Keyword[1]{\def\@Keyword{#1}} 				%关键词
%

%自定义命令
	%脚注
	\newcommand{\Footnote}[1]{\footnote{\small\kaishu #1}}
	% 定义°为\degree 不需要$, \deg 需要$
	\def\deg{^{\circ}}
	\def\degree{${}^{\circ}$}
%

%页面参数
	%页边距
	\geometry{top=0.8in,bottom=1in,left=0.5in,right=0.5in}
	%行距
	\linespread{1.2}
	%目录深度
	\setcounter{secnumdepth}{3}
%

%多级标题
	%多级标题命名格式
	\renewcommand\thesection{\zhnum{section}、}
	\renewcommand\thesubsection{\arabic{subsection}.}
	\renewcommand\thesubsubsection{\thesubsection\arabic{subsubsection}}
	%多级标题字体
	\titleformat*{\section}{\large\bfseries}
	\titleformat*{\subsection}{\normalsize\bfseries}
	\titleformat*{\subsubsection}{\normalsize}
	%多级标题间隔
	\titlespacing{\section}{0pt}{*1.5}{*1.5}
	\titlespacing{\subsection}{2em}{*1}{*1}
	\titlespacing{\subsubsection}{2em}{*1}{*1}
	%多级序号格式
	\setlist[enumerate,1]{label=(\arabic*)}
	\setlist[enumerate,2]{label=\alph*.}
%

%图片路径（实现多种文件夹都可以放图片
	\graphicspath{{figures/}{figure/}{pictures/}{picture/}{pic/}{pics/}{image/}{images/}}
%

% 页眉页码
	\pagestyle{fancy}
	\lhead{课程：\@course}
	\chead{姓名：\@name}
	\rhead{学号：\@stuid}
%

\lstset{
    basicstyle          =   \normalsize\fontspec{Hack},          % 基本代码风格
    keywordstyle        =   \color[RGB]{1, 1, 194},          % 关键字风格
    commentstyle        =   \color{gray!40!black!60},  % 注释的风格，斜体
    stringstyle         =   \rmfamily\slshape\color[RGB]{0,139,139},  % 字符串风格
    framerule           =   2.5em,
	rulecolor           =   \color{gray!10},  
	flexiblecolumns     =   flase,                % 别问为什么，加上这个
    numbers             =   left,   % 行号的位置在左边
    showspaces          =   false,  % 是否显示空格，显示了有点乱，所以不现实了
    numberstyle         =   \footnotesize\fontspec{Hack},    % 行号的样式，小五号，tt等宽字体
    showstringspaces    =   false,
    captionpos          =   t,      % 这段代码的名字所呈现的位置，t指的是top上面
    frame               =   leftline,   % 显示边框
    tabsize             =   2,
    breaklines          =   true,   % 自动换行，建议不要写太长的行
    breakatwhitespace   =   false,       	% 设置自动中断是否只发生在空格处
    escapeinside        =   ``,     	% 在``里显示中文
    columns             =   fixed,  % 如果不加这一句，字间距就不固定，很丑，必须
    basewidth           =   0.5em,
    xleftmargin         =    1em,  
    xrightmargin        =    1em,     % 设定listing左右的空白
}
% 头部
	\newcommand{\makeheader}{
		%标题
		\begin{center}
			\bfseries\huge{\@articletitle}
		\end{center}
		%间距0.4cm
		\vspace{0.4cm}
		%个人信息
		{\noindent\normalsize\kaishu{\@name；\@stuid；\@college；\@major}} \par
		%摘要
		{\noindent\normalsize\heiti{摘要：}}
		{\normalsize\kaishu{\@Abstract}} \par
		%关键词
		{\noindent\normalsize\heiti{关键词：}}
		{\normalsize\kaishu{\@Keyword}}
		\vspace{0.2cm}
	}
%