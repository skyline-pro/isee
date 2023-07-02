\LoadClass{ctexart}
\RequirePackage{ctex}
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
\RequirePackage{zhnumber}
\RequirePackage{multirow}
\RequirePackage{subfigure}
\RequirePackage{amssymb}
\RequirePackage{fontspec}
\RequirePackage{booktabs}
\RequirePackage{caption}
\RequirePackage{underscore}
\RequirePackage{zhnumber}
\RequirePackage[framed,numbered,autolinebreaks,useliterate]{mcode}

\linespread{1.2}
\geometry{top=1in,bottom=1in,left=1in,right=1in}
\setcounter{secnumdepth}{3}
\renewcommand\thesection{\zhnum{section}}
\renewcommand\thesubsection{\arabic{subsection}.}
\renewcommand\thesubsubsection{\thesubsection\arabic{subsubsection}}
\setlist[enumerate,1]{label=(\arabic*)}
\setlist[enumerate,2]{label=\alph*.}

\setCJKmainfont[ItalicFont={宋体},BoldFont={SimHei}]{SimSun}

\titleformat*{\section}{\large\bfseries}
\titleformat*{\subsection}{\normalsize\bfseries}
\titleformat*{\subsubsection}{\normalsize}
\graphicspath{{figures/}{figure/}{pictures/}%
{picture/}{pic/}{pics/}{image/}{images/}}

\titlespacing{\subsection}{1em}{*4}{*1.5}
\titlespacing{\subsubsection}{1em}{*4}{*1.5}


%代码块设置
\lstloadlanguages{
    C,
    C++,
    Python,
    Java,
    Matlab,
    Verilog
}

\lstset{
    %Line number
    language = C,
    numbers=left,
    numberstyle=\small\color{gray}, %代码编号风格
    stepnumber = 2,                 %间隔一行进行编号
    numbersep = 10pt,               %行号与代码的距离
    %Code design
    keywordstyle=\color{blue},
    commentstyle=\color{gray},
    stringstyle=\color{green!60!black},
    breaklines=true,
    % Code
    tabsize=4,
    showspaces=false,
    showstringspaces=false,
    showtabs=false,
    breaklines=true,
    %Basic
    backgroundcolor=\color{gray!3}, %定义背景颜色
    basicstyle=\ttfamily\fontspec{Consolas},
    frame=lines,                    %设置边框样式
    abovecaptionskip=1pt,           %代码距上边框距离
    belowcaptionskip=5pt,           %代码距下边框距离
}


% 信息
\newcommand\major[1]{\def\@major{#1}}
\newcommand\name[1]{\def\@name{#1}}
\newcommand\stuid[1]{\def\@stuid{#1}}
\newcommand\college[1]{\def\@college{#1}}
\renewcommand\date[1]{\def\@date{#1}}
\newcommand\lab[1]{\def\@lab{#1}}
\newcommand\course[1]{\def\@course{#1}}
\newcommand\instructor[1]{\def\@instructor{#1}}
\newcommand\grades[1]{\def\@grades{#1}}
\newcommand\expname[1]{\def\@expname{#1}}
\newcommand\exptype[1]{\def\@exptype{#1}}
\newcommand\partner[1]{\def\@partner{#1}}

% 页眉
\pagestyle{fancy}
\lhead{实验名称:\@expname}
\chead{姓名:\@name}
\rhead{学号:\@stuid}

% 下划线定义
\def\zjuu[#1]#2{
  \underline{\hbox to #1{\hfil#2\hfil}}}

% 首页头部
\newcommand{\makeheader}{
\begin{figure}[h]
  \begin{minipage}{0.7\linewidth}
    \centerline{\includegraphics[width=\linewidth]{../logo/head.jpg}}
  \end{minipage}
  \hfill
  \begin{minipage}{.3\linewidth}
    \raggedleft
    \begin{tabular*}{.8\linewidth}{lc}
      专业： & \zjuu[70pt]\@major   \\
      姓名： & \zjuu[70pt]\@name    \\
      学号： & \zjuu[70pt]\@stuid   \\
      日期： & \zjuu[70pt]\@date \\
      地点： & \zjuu[70pt]\@lab
    \end{tabular*}
  \end{minipage}
\end{figure}

\begin{table}[!htbp]
  \centering
  \begin{tabular*}{\linewidth}{llllll}
    课程名称： & \zjuu[150pt]\@course   & 指导老师： & \zjuu[100pt]\@instructor   & 成绩：        \zjuu[50pt]\@grades \\
    实验名称： & \zjuu[150pt]\@expname & 实验类型： &\zjuu[100pt]\@exptype & 同组学生姓名： \zjuu[50pt]\@partner
  \end{tabular*}
\end{table}
\thispagestyle{empty}

}

% 封面
\newcommand{\makecover}{
  \begin{center}
    \begin{center}
      \includegraphics[width=0.8\linewidth]{../logo/cover.png}
    \end{center}
    \vspace{1cm}
    \bfseries\huge{本科实验报告}\\
    \vspace{0.5cm}
    \bfseries\Large{\@expname}
    \vspace{2.95cm}
    \begin{center}
      \Large
      \linespread{2}
      \centering
      \renewcommand\arraystretch{1.6}
      \begin{tabular}{p{3cm}p{6cm}}
        \bfseries{课程名称：} & \@course \\ \cline{2-2}
        \bfseries{姓\hphantom{两格}名：}     & \@name   \\ \cline{2-2}
        \bfseries{学\hphantom{两格}院：}     & \@college \\ \cline{2-2}
        \bfseries{\hphantom{三格的}系：}     &   \\ \cline{2-2}
        \bfseries{专\hphantom{两格}业：}     & \@major  \\ \cline{2-2}
        \bfseries{学\hphantom{两格}号：}     & \@stuid  \\ \cline{2-2}
        \bfseries{指导老师：} & \@instructor  \\ \cline{2-2}
      \end{tabular}
    \end{center}
    \vspace{2cm}
    \Large{\@date}
  \end{center}
  \thispagestyle{empty}
  \newpage
}
