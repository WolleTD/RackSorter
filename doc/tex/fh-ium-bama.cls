%
% LaTeX class for `Studien- und Diplomarbeiten' at the IAT
% Version 2.1, 05-Mar-2007
% (C) 2001-2006 Michael Vogt and IAT
% (C) 2016-2017 Martin Kohlhase
\NeedsTeXFormat{LaTeX2e}
\def\s@d@name{fh-ium-bama}
\ProvidesClass{\s@d@name}[2017/01/31 v3.1 IuM BA/MA class]
%
% Process the options
%
\def\s@d@open{openany}
\newif\ifs@d@nohyopt\s@d@nohyoptfalse
\newif\ifs@d@headopt\s@d@headoptfalse
\newif\ifs@d@rtmopt\s@d@rtmoptfalse
\DeclareOption{openany}{\def\s@d@open{openany}}
\DeclareOption{openright}{\def\s@d@open{openright}}
\DeclareOption{nohyperref}{\s@d@nohyopttrue}
\DeclareOption{varheadings}{\s@d@headopttrue}
\DeclareOption{rtm}{\s@d@rtmopttrue}
\DeclareOption{rtp}{\s@d@rtmoptfalse}
\DeclareOption{pdfopt}{\ClassWarning{\s@d@name}{Option `pdfopt' is obsolete}}
\DeclareOption{leqno}{\OptionNotUsed}
\DeclareOption{twocolumn}{\OptionNotUsed}
\DeclareOption{notitlepage}{\OptionNotUsed}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions
\LoadClass[12pt,a4paper,\s@d@open]{book}
%
% Define some new switches and old commands
%
\ifx\pdfoutput\undefined
  \csname newcount\endcsname\pdfoutput
  \pdfoutput=0
\else
  \pdfcompresslevel=9
  \pdfadjustspacing=1
\fi
\newif\ifs@d@german\s@d@germanfalse    % Current language is German?
\newif\ifs@d@hyper\s@d@hyperfalse      % \s@d@hyperref has been executed?
\newcommand\sadapdfopt{%
  \ClassWarning{\s@d@name}{Command \noexpand\sadapdfopt is obsolete}}
\newcommand\sadapdfpagelabels[1]{%
  \ClassWarning{\s@d@name}{Command \noexpand\sadapdfpagelabels is obsolete}}
\newcommand\sadapdfbookmark[2]{%
  \ClassWarning{\s@d@name}{Command \noexpand\sadapdfbookmark is obsolete}}
%
% Include hyperref package *before* \begin{document}. This requires to modify
% the \document macro, because \AtBeginDocument is too late ...
%
\ifs@d@nohyopt\else
  \IfFileExists{hyperref.\@pkgextension}{%
    \let\s@d@document\document
    \def\document{%
      \@ifpackageloaded{hyperref}{%
        \ClassError{\s@d@name}{Illegal use of package hyperref}{%
          The hyperref package is included automatically by\MessageBreak
          \s@d@name. If you want to include it manually, call\MessageBreak
          the \s@d@name\space class with option `nohyperref'.}}{%
      \endgroup
      \s@d@hyperref
      \begingroup
      \@endpefalse\s@d@document}}}{%
  \ClassError{\s@d@name}{Package hyperref not found}{%
    The hyperref package is needed by \s@d@name. If it\MessageBreak
    is not available, try to call the \s@d@name\space class\MessageBreak
    with option `nohyperref'.}}
\fi
%
% Additional settings for PDF version. The macro does not check if the hyperref
% package is really available. If title, author or thesistype were set before,
% they are evaluated here. If they are set later, they are expanded immediately.
% After the macro has been executed, the switch \s@d@hyper is set.
%
\def\s@d@hyperref{%
  \gdef\title##1{%
    \gdef\@title{##1}%
    {\pdfstringdefDisableCommands{\let\\\@empty}%
    \hypersetup{pdftitle={##1}}}}
  \gdef\author##1{%
    \gdef\@author{##1}%
    {\pdfstringdefDisableCommands{\let\\\@empty \def\and{,\space}}%
    \hypersetup{pdfauthor={##1}}}}
  \gdef\thesistype##1{%
    \gdef\s@d@thesistype{##1}%
    \s@d@checklanguage
    \hypersetup{pdfsubject={\ifx##1\@empty\else##1\space
        \ifs@d@german am\else at the\fi\space
      \fi
      \ifs@d@german
        Fachhochschule Bielefeldt%
      \else
        FH Bielefeld\\
        University of Applied Science%
      \fi}}}
  \RequirePackage[\ifcase\pdfoutput dvips\or pdftex\fi,
    pdfcreator={LaTeX with IuM BA/MA Class v3.1},
    plainpages=false,
    pdfpagelabels,
    linktocpage,
    breaklinks=true,
    bookmarks,
    bookmarksnumbered,
    bookmarksopen,
    bookmarksopenlevel=0,
    pdfpagemode=UseOutlines,
    colorlinks=false,
    pdfborder={0 0 0},
    citebordercolor={.6 .6 1},
    filebordercolor={.6 .6 1},
    linkbordercolor={.6 .6 1},
    menubordercolor={.6 .6 1},
%    pagebordercolor={.6 .6 1},
    urlbordercolor ={.6 .6 1},
    runbordercolor ={.6 .6 1}]{hyperref}
  \ifx\s@d@temptitle\@empty\else    % This ensures that the pdftitle is set
    \title{\s@d@temptitle}          % if \title is used before \s@d@hyperref
  \fi
  \ifx\s@d@tempauthor\@empty\else
    \author{\s@d@tempauthor}
  \fi
  \ifx\s@d@tempthesis\@empty\else
    \thesistype{\s@d@tempthesis}
  \fi
  \s@d@hypertrue
}
%
% User command to include hyperref features
%
\newcommand\sadahyperref{%
  \ifs@d@nohyopt
    \s@d@hyperref
  \else
    \ClassError{\s@d@name}{Illegal use of command \noexpand\sadahyperref}{%
      The command \noexpand\sadahyperref can only be used if the
      \MessageBreak class \s@d@name\space is called with option `nohyperref'.}
  \fi
}
\@onlypreamble\sadahyperref
%
% Use nohyperref package if hyperref is not loaded. Hypertext commands are then
% available in the document but do not have any effect.
%
\AtBeginDocument{%
  \@ifpackageloaded{hyperref}{}{%
    \IfFileExists{nohyperref.\@pkgextension}{%
      \RequirePackage{nohyperref}}{%
    \ClassWarning{\s@d@name}{Package nohyperref not found;
      some\MessageBreak commands will not be available}}}}
%
% Identify the language and set \s@d@german
%
\def\s@d@gdialect#1{%
  \ifcase#1@@@\or austrian\or naustrian\or german\or germanb\or ngerman\fi}
\def\s@d@edialect#1{%
  \ifcase#1canadian\or british\or UKenglish\or american\or USenglish\or english\fi}
\def\s@d@checklanguage{%
  \s@d@germanfalse
  \@tempcnta=4
  \loop
    \expandafter\ifx\csname l@\s@d@gdialect{\@tempcnta}\endcsname\relax\else
      \expandafter\ifnum\csname l@\s@d@gdialect{\@tempcnta}\endcsname=\language
        \s@d@germantrue
        \@tempcnta=0
      \fi
    \fi
  \ifnum\@tempcnta>0
    \advance\@tempcnta by -1
  \repeat}
%
% Adjust margins and skips
%
\setlength\topmargin{\ifs@d@headopt 20mm\else 23mm\fi}
\addtolength\topmargin{-1in}
\setlength\oddsidemargin{30mm}
\addtolength\oddsidemargin{-1in}
\setlength\evensidemargin{30mm}
\addtolength\evensidemargin{-1in}
\setlength\textwidth{150mm}
\setlength\textheight{232mm}
\setlength\headsep{25pt}
\setlength\footskip{35pt}
\setlength\parindent{0em}
\setlength\parskip{1.75ex \@plus.25ex \@minus.25ex}
\setlength\marginparsep{4mm}
\setlength\marginparwidth{22mm}
%
% Change everything necessary for a larger baseline skip
%
\linespread{1.25}
\def\verbatim@font{\linespread{1}\normalfont\ttfamily}
\def\footnoterule{\kern4\p@ \hrule \@width .4\textwidth \kern 4.6\p@}
\setlength\footnotesep{10.4\p@}
\setlength\jot{10\p@}
\setlength\textfloatsep{24\p@ \@plus 2\p@ \@minus 4\p@}
\setlength\intextsep{16\p@ \@plus 2\p@ \@minus 4\p@}
\setlength\floatsep{14\p@ \@plus 2\p@ \@minus 2\p@}
%
% Adjust lists to the new baseline and paragraph skips
%
\setlength\topsep{\z@ \@plus.25ex}
\setlength\partopsep{1ex \@plus.5ex \@minus.5ex}
\def\@listi{\leftmargin\leftmargini
            \parsep 4\p@  \@plus2\p@ \@minus\p@
            \itemsep \parsep}
\let\@listI\@listi
\@listi
\renewenvironment{quote}
  {\list{}{\rightmargin\leftmargin
           \parsep\parskip}%
   \item\relax}
  {\endlist}
%
% Adjust sizes that are dependent on the font size
%
\renewcommand\normalsize{%
  \@setfontsize\normalsize\@xiipt{14.5}%
  \abovedisplayskip 15\p@ \@plus3\p@ \@minus6\p@
  \belowdisplayskip \abovedisplayskip
  \abovedisplayshortskip 1\p@ \@plus3\p@
  \belowdisplayshortskip 7\p@ \@plus3\p@ \@minus2\p@
  \let\@listi\@listI}
\normalsize
\renewcommand\small{%
  \@setfontsize\small\@xipt{13.6}%
  \abovedisplayskip 14\p@ \@plus3\p@ \@minus5\p@
  \belowdisplayskip \abovedisplayskip
  \abovedisplayshortskip 1\p@ \@plus3\p@
  \belowdisplayshortskip 7\p@ \@plus3\p@ \@minus2\p@
  \def\@listi{\leftmargin\leftmargini
              \parsep 3.5\p@ \@plus1.5\p@ \@minus\p@
              \itemsep \parsep}%
}
\renewcommand\footnotesize{%
  \@setfontsize\footnotesize\@xpt\@xiipt
  \abovedisplayskip 13\p@ \@plus2\p@ \@minus4\p@
  \belowdisplayskip \abovedisplayskip
  \abovedisplayshortskip 1\p@ \@plus3\p@
  \belowdisplayshortskip 6.5\p@ \@plus2.5\p@ \@minus2\p@
  \def\@listi{\leftmargin\leftmargini
              \parsep 3\p@ \@plus1.5\p@ \@minus\p@
              \itemsep \parsep}%
}
%
% Fonts for various layout elements (see extras.tex)
%
\def\s@f@sectioning{\bfseries\boldmath}
\def\s@f@part{\Huge}
\def\s@f@partnumber{\huge}
\def\s@f@chapter{\Huge}
\def\s@f@section{\Large}
\def\s@f@subsection{\large}
\let\s@f@subsubsection\@empty
\let\s@f@paragraph\@empty
\let\s@f@subparagraph\@empty
\ifs@d@headopt
  \let\s@f@pagenumber\@empty
\else
  \def\s@f@pagenumber{\bfseries}
\fi
\def\s@f@pagehead{\itshape}
\def\s@f@caption{\small}
\def\s@f@captionlabel{\bfseries\small}
\def\s@f@descriptionlabel{\bfseries}
\def\s@f@footnote{\footnotesize}
\def\s@f@footnotelabel{\footnotesize}
\def\s@f@footnotereference{\footnotesize}
\let\s@f@title\@empty
\let\s@f@titlepage\@empty
\newcommand\setsadafont[2]{%
  \expandafter\ifx\csname s@f@#1\endcsname\relax
    \ClassError{\s@d@name}{Unable to set font of element `#1'}{}
  \else
    \expandafter\def\csname s@f@#1\endcsname{#2}%
  \fi}
\newcommand\addtosadafont[2]{%
  \expandafter\ifx\csname s@f@#1\endcsname\relax
    \ClassError{\s@d@name}{Unable to extent font of element `#1'}{}
  \else
    {\toks@\expandafter\expandafter\expandafter{\csname s@f@#1\endcsname#2}%
     \expandafter\xdef\csname s@f@#1\endcsname{\the\toks@}}%
  \fi}
\newcommand\usesadafont[1]{%
  \expandafter\ifx\csname s@f@#1\endcsname\relax
    \ClassError{\s@d@name}{Unable to use font of element `#1'}{}
  \else
    \@nameuse{s@f@#1}%
  \fi}
%
% The following macros are *solely* redefined to use custom fonts
%
\renewcommand*\descriptionlabel[1]{%
  \hspace\labelsep\normalfont\s@f@descriptionlabel #1}
\def\@makefnmark{\hbox{\@textsuperscript{%
  \normalfont\normalsize\s@f@footnotereference\@thefnmark}}}
\renewcommand\@makefntext[1]{%
  \normalfont\normalsize\s@f@footnote
  \parindent 1em\noindent
  \hb@xt@1.8em{\hss\hbox{\@textsuperscript{%
    \normalfont\normalsize\s@f@footnotelabel\@thefnmark}}}#1}
\def\@part[#1]#2{%
  \ifnum \c@secnumdepth >-2\relax
    \refstepcounter{part}%
    \addcontentsline{toc}{part}{\thepart\hspace{1em}#1}%
  \else
    \addcontentsline{toc}{part}{#1}%
  \fi
  \markboth{}{}%
  {\centering \interlinepenalty\@M \normalfont\normalsize\s@f@sectioning
   \ifnum \c@secnumdepth >-2\relax
     {\s@f@partnumber\partname\nobreakspace\thepart\par\vskip 20\p@}%
   \fi
   \s@f@part #2\par}%
  \@endpart}
\def\@spart#1{%
  {\centering \interlinepenalty\@M \normalfont\normalsize\s@f@sectioning
   \s@f@part #1\par}%
  \@endpart}
\renewcommand*\l@part[2]{%
  \ifnum \c@tocdepth >-2\relax
    \addpenalty{-\@highpenalty}%
    \addvspace{2.25em \@plus\p@}%
    \setlength\@tempdima{3em}%
    \begingroup
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      {\leavevmode \s@f@sectioning
       \large #1\hfil \hb@xt@\@pnumwidth{\hss #2}}\par
       \nobreak
         \global\@nobreaktrue
         \everypar{\global\@nobreakfalse\everypar{}}%
    \endgroup
  \fi}
\renewcommand*\l@chapter[2]{%
  \ifnum \c@tocdepth >\m@ne
    \addpenalty{-\@highpenalty}%
    \vskip 1.0em \@plus\p@
    \setlength\@tempdima{1.5em}%
    \begingroup
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      \leavevmode \s@f@sectioning
      \advance\leftskip\@tempdima
      \hskip -\leftskip
      \normalsize #1\nobreak\hfil\nobreak\hb@xt@\@pnumwidth{\hss #2}\par
      \penalty\@highpenalty
    \endgroup
  \fi}
%
% Plain page layout without headings
%
\def\ps@plain{\let\@mkboth\@gobbletwo
  \ifs@d@headopt
    \let\@oddhead\@empty
    \def\@oddfoot{\hfil\s@f@pagenumber\thepage}
    \let\@evenhead\@empty
    \def\@evenfoot{\s@f@pagenumber\thepage\hfil}
  \else
    \def\@oddhead{\hfil\s@f@pagenumber\thepage}
    \let\@oddfoot\@empty
    \def\@evenhead{\s@f@pagenumber\thepage\hfil}
    \let\@evenfoot\@empty
  \fi}
%
% Page layout with headings
%
\if@twoside
  \def\ps@headings{%
    \ifs@d@headopt
      \def\@oddhead{\hfil\s@f@pagehead\rightmark}
      \def\@oddfoot{\hfil\s@f@pagenumber\thepage}
      \def\@evenhead{\s@f@pagehead\leftmark\hfil}
      \def\@evenfoot{\s@f@pagenumber\thepage\hfil}
    \else
      \def\@oddhead{\underline{\rule[-3\p@]{\z@}{\z@}\parbox{\textwidth}{%
        {\s@f@pagehead\rightmark}\hfill\s@f@pagenumber\thepage}}}
      \let\@oddfoot\@empty
      \def\@evenhead{\underline{\rule[-3\p@]{\z@}{\z@}\parbox{\textwidth}{%
        {\s@f@pagenumber\thepage}\hfill\s@f@pagehead\leftmark}}}
      \let\@evenfoot\@empty
    \fi
    \let\@mkboth\markboth
    \def\chaptermark##1{\markboth%
      {\ifnum\c@secnumdepth>\m@ne \if@mainmatter\thechapter\ \ \fi\fi ##1}%
      {\ifnum\c@secnumdepth>\m@ne \if@mainmatter\thechapter\ \ \fi\fi ##1}}%
    \def\sectionmark##1{\markright{\ifnum\c@secnumdepth>\z@
      \thesection\ \ \fi ##1}}}
\else
  \def\ps@headings{%
    \ifs@d@headopt
      \def\@oddhead{\hfil\s@f@pagehead\rightmark}
      \def\@oddfoot{\hfil\s@f@pagenumber\thepage}
    \else
      \def\@oddhead{\underline{\rule[-3\p@]{\z@}{\z@}\parbox{\textwidth}{%
        {\s@f@pagehead\rightmark}\hfill\s@f@pagenumber\thepage}}}
      \let\@oddfoot\@empty
    \fi
    \let\@mkboth\markboth
    \def\chaptermark##1{\markright{\ifnum\c@secnumdepth>\m@ne%
      \if@mainmatter\thechapter\ \ \fi\fi ##1}}}
\fi
\pagestyle{headings}
%
% Layout of the titlepage
%
\def\ps@title{%
  \setlength\topmargin{20mm}
  \addtolength\topmargin{-1in}
  \setlength\headheight{18mm}
  \setlength\headsep{2mm}
  \def\@oddhead{%
    \noindent\linespread{1}\normalfont\normalsize\s@f@titlepage
    \s@d@checklanguage
    \ifs@d@hyper
      \parbox[b][\z@]{\z@}{\raisebox{38mm}{%
        \ifs@d@german
          \pdfbookmark[0]{Titelseite}{bamatitle}%
        \else
          \pdfbookmark[0]{Titlepage}{bamatitle}%
        \fi}}%
    \fi
    \makebox[\z@][l]{\parbox[t][217mm][b]{\textwidth}{%
      \ifcase\pdfoutput
        \leavevmode
	\ifs@d@rtmopt
        	\hbox to 38.1mm {\vbox to 18mm {\vfill\special{psfile=rtmlogo.eps
          	hoffset=-10.2 voffset=-10.2}}\hfill}%
	\else
        	\hbox to 38.1mm {\vbox to 18mm {\vfill\special{psfile=rtplogo.eps
          	hoffset=-10.2 voffset=-10.2 hscale=51 vscale=51}}\hfill}%
	\fi
      \or
        %\pdfximage height 18mm {iatlogo.pdf}%
        %\pdfrefximage \pdflastximage
          \textbf{Fachhochschule Bielefeld}\\
          Fachbereich Ingenieurwissenschaften\\
          und Mathematik
      \fi
      \hfill
      \setlength\@tempdima{\textwidth}%
      \addtolength\@tempdima{-40mm}%
      \begin{minipage}[b][\z@][b]{\@tempdima}
        \raggedleft
        \ifs@d@german
          \textbf{Labor f\"ur Automatisierungstechnik}\\
          \ifs@d@rtmopt
            \textbf{Regelungstechnik}\\
            Prof.~Dr.-Ing.~Martin Kohlhase
          \else
            \textbf{und Regelungstechnik}\\
            Prof.~Dr.-Ing.~Martin Kohlhase \\
	 Prof.~Dr.-Ing.~Dirk Weidemann
          \fi
        \else
          \textbf{Laboratory for Automation and Control}\\
          \ifs@d@rtmopt
            Prof.~Dr.-Ing.~Martin Kohlhase
          \else
            Prof.~Dr.-Ing.~Martin Kohlhase
          \fi
        \fi
      \end{minipage}}}%
    \raisebox{18mm}{%
      \setlength\@tempdima{\textwidth}%
      \addtolength\@tempdima{-50mm}%
      \begin{minipage}[b][\z@][t]{\@tempdima}
        \raggedright
        \ifs@d@german
%          \textbf{Fachhochschule Bielefeld}\\
%          Fachbereich Ingenieurwissenschaften\\
%          und Mathematik
        \else
%          \textbf{Bielefeld University of Applied Sciences}\\
%          Faculty of Engineering Sciences\\
%          and Mathematics
        \fi
      \end{minipage}}
    \hfill
    \ifcase\pdfoutput
      \leavevmode
      \hbox to 46.5mm {\vbox to 18mm {\vfill\special{psfile=fhlogo.eps
        hoffset=-10.2 voffset=-10.2 hscale=51 vscale=51}}\hfill}%
    \or
      \pdfximage height 35mm {fhlogo.pdf}%
      \pdfrefximage \pdflastximage
    \fi}
  \let\@oddfoot\@empty
}
%
% Titlepage environment
%
\renewenvironment{titlepage}
  {\cleardoublepage\setcounter{page}\@ne
   \thispagestyle{title}\enlargethispage{-20mm}
   \normalfont\normalsize\s@f@title}
  {\pagestyle{plain}\cleardoublepage}
%
% Automatic generation of the titlepage
%
\renewcommand\title[1]{\gdef\@title{#1}\gdef\s@d@temptitle{#1}}
\renewcommand\author[1]{\gdef\@author{#1}\gdef\s@d@tempauthor{#1}}
\renewcommand\date[1]{\gdef\@date{#1}}
\newcommand\thesistype[1]{\gdef\s@d@thesistype{#1}\gdef\s@d@tempthesis{#1}}
\newcommand\supervisor[1]{\gdef\s@d@supervisor{#1}}
\newcommand\supervisortwo[1]{\gdef\s@d@supervisortwo{#1}}
\newcommand{\matrnr}{1023624}
\let\and\space
\def\@title{\ClassError{\s@d@name}{No \noexpand\title given}{}}
\def\@author{\ClassError{\s@d@name}{No \noexpand\author given}{}}
\gdef\@date{\ClassError{\s@d@name}{No \noexpand\date given}{}}
\def\s@d@thesistype{\ClassError{\s@d@name}{No \noexpand\thesistype given}{}}
\def\s@d@supervisor{\ClassError{\s@d@name}{No \noexpand\supervisor given}{}}
\def\s@d@temptitle{}
\def\s@d@tempauthor{}
\def\s@d@tempthesis{}
\def\maketitle{%
  \s@d@countauthors
  \s@d@countsupervisors
  \begin{titlepage}
    \s@d@checklanguage
    \vspace*{\z@ \@plus 1fil}\large
    \begin{center}
      {\s@d@thesistype}\hspace*{\z@}\\[10mm]
      {\bfseries\LARGE\@title\hspace*{\z@}\\[10mm]}
      \ifs@d@german von\else by\fi\\[1ex]
      {\let\and\\ \@author}\hspace*{\z@}\\ [1ex]
      \ifs@d@german Matrikelnummer:\else Matrikelnummer :\fi
      {\let\and\\ \matrnr}\hspace*{\z@}\\[20mm \@plus 1.5fil]
      \def\and{\egroup\tabularnewline & \bgroup}
      \begin{tabular}{ll}
        \ifs@d@german 1. Pr\"ufer\else
          \ifnum\s@d@numsupervisors=1 Supervisor\else Supervisors\fi\fi:
          & \bgroup\s@d@supervisor\egroup\hspace*{\z@}\tabularnewline[1ex]
      % \ifs@d@german 2. Pr\"ufer:
       %  & \bgroup\s@d@supervisortwo\egroup\hspace*{\z@}\tabularnewline[1ex]
        \ifs@d@german Abgabedatum\else Submission Date\fi:
          & {\@date}\hspace*{\z@}
      \end{tabular}
    \end{center}
    \vspace{5mm \@plus 1fil}
  \end{titlepage}}
%
% Check number of authors
%
\newcount\s@d@numauthors
\def\s@d@countauthors{%
  \s@d@numauthors=1
  \begingroup
  \def\and{\global\advance\s@d@numauthors by 1}
  \sbox\@tempboxa{\@author}
  \endgroup
  \ifnum\s@d@numauthors>5
    \ClassError{\s@d@name}{Not more than five authors allowed}{%
      For \noexpand\maketitle and \noexpand\makedeclaration the number of
      authors is\MessageBreak limited to five. You may consider the
      `titlepage' environment\MessageBreak or design the pages manually.}
  \fi}
%
% Check number of supervisors
%
\newcount\s@d@numsupervisors
\def\s@d@countsupervisors{%
  \s@d@numsupervisors=1
  \begingroup
  \def\and{\global\advance\s@d@numsupervisors by 1}
  \sbox\@tempboxa{\s@d@supervisor}
  \endgroup
  \ifnum\s@d@numsupervisors>5
    \ClassError{\s@d@name}{Not more than five supervisors allowed}{%
      For \noexpand\maketitle and the `tasks' environment the
      number\MessageBreak of supervisors is limited to five. You may consider
      the\MessageBreak `titlepage' environment or design the pages manually.}
  \fi}
%
% Figures and tables
%
\newlength\s@d@textwidth
\AtBeginDocument{\setlength\s@d@textwidth{\textwidth}}
\long\def\@makecaption#1#2{%
  \vskip\abovecaptionskip
  \reset@font\normalsize
  \ifdim\hsize<.65\s@d@textwidth  % reduce linespread for narrow captions
    \linespread{1.1}\selectfont
  \else
    \linespread{1.2}\selectfont
  \fi
  \sbox\@tempboxa{{\s@f@captionlabel #1: }\s@f@caption #2}%
  \@tempdima \hsize
  \ifdim\hsize=\s@d@textwidth     % additional margins only on full textwidth
    \advance \@tempdima -2\leftmargini
    \leftskip \leftmargini
    \rightskip \leftmargini
  \fi
  \ifdim \wd\@tempboxa >\@tempdima
    {{\s@f@captionlabel #1: }\s@f@caption #2}\par
  \else
    \global \@minipagefalse
    \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
  \fi
  \vskip\belowcaptionskip}
\renewenvironment{figure}
  {\abovecaptionskip=10\p@ \belowcaptionskip=\z@ \@float{figure}}
  {\end@float}
\renewenvironment{table}
  {\abovecaptionskip=\z@ \belowcaptionskip=10\p@ \@float{table}}
  {\end@float}
\def\@floatboxreset{\centering
  \reset@font\normalsize\@setminipage}
\setlength\@fptop{\z@}
\setlength\@fpsep{14\p@}
\setlength\@fpbot{\z@ \@plus 1fil}
\AtBeginDocument{%
  \def\s@d@germannames{%
    \renewcommand\figurename{\bf Abbildung}%
    \renewcommand\tablename{\bf Tabelle}%
    \renewcommand\listfigurename{Bildverzeichnis}%
    \renewcommand\abstractname{Kurzfassung}%
    \renewcommand\keywordsname{Schl\"usselw\"orter}}
  \def\s@d@englishnames{%
    \renewcommand\keywordsname{Keywords}}
  \@ifpackageloaded{babel}{%  patch names in all German and English dialects
    \@tempcnta=5
    \loop
      \@ifundefined{captions\s@d@gdialect{\@tempcnta}}{}{\expandafter\addto
        \csname captions\s@d@gdialect{\@tempcnta}\endcsname\s@d@germannames}
      \@ifundefined{captions\s@d@edialect{\@tempcnta}}{}{\expandafter\addto
        \csname captions\s@d@edialect{\@tempcnta}\endcsname\s@d@englishnames}
    \ifnum\@tempcnta>0
      \advance\@tempcnta by -1
    \repeat}{}
  \s@d@checklanguage
  \ifs@d@german
    \s@d@germannames
  \fi}
%
% Ragged right with only explicit hyphenation
%
\def\hyphenright{%
  \lefthyphenmin=64      % prevent implicit hyphenation
  \righthyphenmin=64
  \hyphenpenalty\z@      % allow explicit hyphenation
  \exhyphenpenalty\z@
  \adjdemerits\z@
  \finalhyphendemerits\z@
  \doublehyphendemerits\z@
  \raggedright}
%
% Layout of chapter and section heads
%
\renewcommand\chapter{\if@openright\cleardoublepage\else\clearpage\fi
  \thispagestyle{plain}
  \if@twoside\ifs@d@headopt\else\thispagestyle{empty}\fi\fi
  \global\@topnum\z@
  \@afterindentfalse
  \secdef\@chapter\@schapter}
\def\@makechapterhead#1{{\parindent\z@\parskip\z@\linespread{1}%
  \interlinepenalty\@M\s@f@sectioning\s@f@chapter\hyphenright%
  \@hangfrom{\if@mainmatter\thechapter\hspace{1em}\fi}{#1\par\nobreak}
  \vskip35\p@}}
\def\@makeschapterhead#1{{\parindent\z@\parskip\z@\linespread{1}%
  \interlinepenalty\@M\s@f@sectioning\s@f@chapter\hyphenright%
  #1\par\nobreak
  \vskip35\p@}}
\renewcommand\section{\@startsection {section}{1}{\z@}%
  {-2.75ex \@plus -1ex \@minus -.2ex}%
  {1.25ex \@plus.2ex}%
  {\s@f@sectioning\s@f@section\hyphenright}}
\renewcommand\subsection{\@startsection{subsection}{2}{\z@}%
  {-2.5ex\@plus -1ex \@minus -.2ex}%
  {.75ex \@plus .2ex}%
  {\s@f@sectioning\s@f@subsection\hyphenright}}
\renewcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
  {-2.25ex\@plus -1ex \@minus -.2ex}%
  {.75ex \@plus .2ex}%
  {\s@f@sectioning\s@f@subsubsection\hyphenright}}
\renewcommand\paragraph{\@startsection{paragraph}{4}{\z@}%
  {2.5ex \@plus 1ex \@minus .2ex}%
  {-1.25em}%
  {\s@f@sectioning\s@f@paragraph}}
\renewcommand\subparagraph{\@startsection{subparagraph}{5}{\parindent}%
  {2.5ex \@plus 1ex \@minus .2ex}%
  {-1.25em}%
  {\s@f@sectioning\s@f@subparagraph}}
%
% Remove parskip from table of contents and lists
%
\def\tableofcontents{\chapter*{\contentsname
  \@mkboth{\contentsname}{\contentsname}}{\parskip\z@\@starttoc{toc}}}
\def\listoffigures{\chapter*{\listfigurename
  \@mkboth{\listfigurename}{\listfigurename}}{\parskip\z@\@starttoc{lof}}}
\def\listoftables{\chapter*{\listtablename
  \@mkboth{\listtablename}{\listtablename}}{\parskip\z@\@starttoc{lot}}}
%
% References: headings and ragged right
%
\renewenvironment{thebibliography}[1]{%
  \chapter*{\bibname\@mkboth{\bibname}{\bibname}}%
  \list{\@biblabel{\@arabic\c@enumiv}}{%
    \settowidth\labelwidth{\@biblabel{#1}}%
    \leftmargin\labelwidth
    \advance\leftmargin\labelsep
    \@openbib@code
    \usecounter{enumiv}%
    \let\p@enumiv\@empty
    \renewcommand\theenumiv{\@arabic\c@enumiv}}%
  \hyphenright
  \clubpenalty4000
  \@clubpenalty \clubpenalty
  \widowpenalty4000%
  \sfcode`\.\@m}
  {\def\@noitemerr
    {\@latex@warning{Empty `thebibliography' environment}}%
  \endlist}
%
% Abstract macro is missing in book.cls
%
\newcommand{\keywords}[1]{}
\let\s@d@keywords\@empty
\newenvironment{abstract}{%
  \renewcommand{\keywords}[1]{\gdef\s@d@keywords{##1}}%
  \thispagestyle{plain}%
  \reset@font\normalsize
  \setlength\@tempdima{\topskip}%
  \addtolength\@tempdima{\baselinestretch\baselineskip}%
  \vspace{\@tempdima \@plus -3fil}%
  \vspace*{-\@tempdima \@plus 2fil}%
  {\centering\s@f@sectioning\s@f@section\abstractname
   \parskip\z@ \par\vspace{2.5ex}\noindent}%
  \ignorespaces
  }{%
  \ifx\s@d@keywords\@empty\else
    \par{\s@f@descriptionlabel\keywordsname:\space}\s@d@keywords
    \global\let\s@d@keywords\@empty
  \fi
  \par\vspace{\z@ \@plus 3fil}}
\newcommand\abstractname{Abstract}
\newcommand\keywordsname{Keywords}
%
% Declaration of autonomy (always in German)
%
\newcommand{\makedeclaration}{%
  \s@d@checklanguage
  \s@d@countauthors
  \clearpage
  \thispagestyle{plain}%
  \reset@font\normalsize
  \setlength\@tempdima{\topskip}%
  \addtolength\@tempdima{\baselinestretch\baselineskip}%
  \vspace*{-\@tempdima \@plus 2fil}%
  {\centering\s@f@sectioning\s@f@section Erkl\"arung
   \parskip\z@ \par\vspace{3.5ex}\noindent}%
  \ignorespaces
  \ifnum\s@d@numauthors=1
    Hiermit versichere ich, dass ich die vorliegende Arbeit ohne Hilfe Dritter
    und nur mit den angegebenen Quellen und Hilfsmitteln angefertigt habe.
  \else
    Hiermit versichern wir, dass wir die vorliegende Arbeit ohne Hilfe Dritter
    und nur mit den angegebenen Quellen und Hilfsmitteln angefertigt haben.
  \fi
  Alle Stellen, die aus den Quellen entnommen wurden, sind als solche kenntlich
  gemacht. Diese Arbeit hat in gleicher oder \"ahnlicher Form noch keiner
  Pr\"ufungsbeh\"orde vorgelegen.
  \par\vspace{20mm}
  \begingroup
  Bielefeld, \@date \hfill
  \def\and{\\[15mm]\hrulefill\\}
  \parbox[t]{70mm}{\vspace{.5ex}\centering\hrulefill\\ \@author}
  \endgroup
  \vspace{\z@ \@plus 3fil}%
  \clearpage}
%
% Description of tasks
%
\newcommand\begindate[1]{\gdef\s@d@begindate{#1}}
\newcommand\seminardate[1]{\gdef\s@d@seminardate{#1}}
\def\s@d@begindate{\ClassError{\s@d@name}{No \noexpand\begindate given}{}}
\def\s@d@seminardate{\ClassError{\s@d@name}{No \noexpand\seminardate given}{}}
\newenvironment{tasks}{%
  \clearpage
  \s@d@checklanguage
  \thispagestyle{plain}%
  \reset@font\normalsize
  \setlength\@tempdima{\topskip}%
  \addtolength\@tempdima{\baselinestretch\baselineskip}%
  \vspace*{-\@tempdima \@plus 2fil}%
  {\centering\s@f@sectioning\s@f@section
   \ifs@d@german Aufgabenstellung\else Project Description\fi
   \parskip\z@ \par\vspace{3.5ex}\noindent}%
  \ignorespaces
  }{%
  \par
  \s@d@checklanguage
  \ifs@d@german
    Die aktuelle Fassung der Richtlinien zur Anfertigung von Studien- und
    Diplomarbeiten ist zu beachten.
    \par\vspace{2ex}
    \begin{tabular}{@{}ll@{}}
      Beginn:  & \s@d@begindate\\
      Ende:    & \@date\\
      Seminar: & \s@d@seminardate
    \end{tabular}
  \else
    The current version of the thesis guidelines has to be followed.
    \par\vspace{2ex}
    \begin{tabular}{@{}ll@{}}
      Beginning:  & \s@d@begindate\\
      Submission: & \@date\\
      Seminar:    & \s@d@seminardate
    \end{tabular}
  \fi
  \par\vspace{20mm}
  \begingroup
  \parbox[t]{70mm}{\centering\hrulefill\\
    \ifs@d@rtmopt
      Prof.~Dr.-Ing.~Martin Kohlhase
    \else
      Prof.~Dr.-Ing.~Martin Kohlhase
    \fi}
  \hfill
  \def\and{\\[15mm]\hrulefill\\}
  \parbox[t]{70mm}{\centering\hrulefill\\ \s@d@supervisor}
  \endgroup
  \vspace{\z@ \@plus 3fil}%
  \clearpage}
%
% The end ...
%
\endinput
