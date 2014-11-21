%
% File for the ntnuthesis LaTeX class.
% This class produces a subset of book suitable for doctoral
% theses written at NTNU.
%
% Original author: Federico Zenith
%
% Edit: Arne Tobias Elve (tobelve@gmail.com) 2014

% Changelog:
%   Changed class to yield a Master's thesis print
%   Changed base class to ``memoir''
%   Changed chapter title formatting
%   Changed figure and table caption formatting
%   Added common packages: amsmath, amssymb, amsfonts, 
%                          amsxtra, booktabs, siunitx, appendix
%   Changed equation, table and figure numbering to
%       Equation (chapter.section.eqnumber)

% @TODO:
% The settypeblocksize for the chapterclass 'thesis2' should give
% the given result without changing the complete margin layout of
% the document.  

\NeedsTeXFormat{LaTeX2e}

\ProvidesClass{./Build/MasterThesis}
    [
    02/09/2014 Class for Master's theses at NTNU, Trondheim. 
    (Original class: 2007/03/25 Class for PhD theses at 
    NTNU Trondheim)
    ]

%
% Set default values for the variables used by our implementation of \maketitle
%
\newcommand{\SubTitle}{}
\newcommand{\DegreeType}{titulum obliviscens}
\newcommand{\Faculty}{ }
\newcommand{\Department}{}
\newcommand{\CopyrightNotice}{}
\newcommand{\ISBNPrinted}{N/A}
\newcommand{\ISBNElectronic}{N/A}
\newcommand{\SerialNumber}{\number\year:N/A}
\newcommand{\Month}{\ifcase\month\or
    January\or February\or March\or April\or May\or June\or
    July\or August\or September\or October\or November\or December\fi}
\newcommand{\Year}{\number\year}
\renewcommand{\@author}{Author Name}
\renewcommand{\@title}{Your Title}


%
% Set the default values for margin settings
%
\newcommand{\GeometryOptions}{margin=20mm,top=15mm,bindingoffset=10mm}
\newcommand{\CropOptions}{}
\newcommand{\CropLandscapeFlag}{}

%
% Commodity command to give two different versions of code, the first for printout mode
% and the second for screen mode. Useful for large pictures and layouts in absolute units.
%
\newcommand{\printandscreen}[2]{\ifthenelse{\isundefined{\ScreenMode}}{#1}{#2}}

%
% Process options passed to the class
%
\DeclareOption{a4crop}{\renewcommand{\CropOptions}{cam,a4,center}}
\DeclareOption{draft}{\PassOptionsToClass{\CurrentOption}{memoir}}
\DeclareOption{final}{\PassOptionsToClass{\CurrentOption}{memoir}}
\DeclareOption{screen}{
    \renewcommand{\CropLandscapeFlag}{landscape}
    \renewcommand{\GeometryOptions}{margin=10mm,screen}
    \newcommand{\ScreenMode}{true}
}
\DeclareOption*{\PackageWarning{ntnuthesis}{Unknown option `\CurrentOption´.}}
\ProcessOptions\relax

\LoadClass[b5paper,11pt,twoside,openright,onecolumn]{memoir}

% Set appropriate margins
\RequirePackage[\GeometryOptions,includeheadfoot,headheight=14.5pt]{geometry}

% Set cropping marks, if a4crop has been specified.
\RequirePackage[\CropOptions,\CropLandscapeFlag]{crop}

% Necessary to set the headers; notice that right and left headers are swapped.
\let\footruleskip\undefined
\RequirePackage{fancyhdr}

% Used in some conditional statements
\RequirePackage{ifthen}

% Necessary to include the NTNU logo
\RequirePackage{graphicx}

% Regular packages included. 
% amsmath, amssymb, amsfonts, amsxtra -- math
% booktabs -- proper lines in tables
% siunitx -- proper unit handling
% appendix -- proper appendix handling
\RequirePackage{amsmath, amssymb, amsfonts, amsxtra,
                booktabs, siunitx, appendix}
\sisetup{exponent-product = {\cdot}}
\numberwithin{equation}{chapter}
\numberwithin{table}{chapter}
\numberwithin{figure}{chapter}

%
% Define the commands to set the variables used by \maketitle
%
\newcommand{\subtitle}[1]{\renewcommand{\SubTitle}{#1}}
\newcommand{\degreetype}[1]{\renewcommand{\DegreeType}{#1}}
\newcommand{\faculty}[1]{\renewcommand{\Faculty}{#1}}
\newcommand{\department}[1]{\renewcommand{\Department}{#1}}
\newcommand{\copyrightnotice}[1]{\renewcommand{\CopyrightNotice}{#1}}
\newcommand{\isbnprinted}[1]{\renewcommand{\ISBNPrinted}{#1}}
\newcommand{\isbnelectronic}[1]{\renewcommand{\ISBNElectronic}{#1}}
\newcommand{\serialnumber}[1]{\renewcommand{\SerialNumber}{#1}}
\newcommand{\setyear}[1]{\renewcommand{\Year}{#1}}
\newcommand{\setmonth}[1]{\renewcommand{\Month}{#1}}

%
% Override the \maketitle command
%
\renewcommand{\maketitle}{
    \begin{titlingpage}
    \parindent=0cm
    \addtolength{\parskip}{\baselineskip}
    {\Huge \@author}
    \printandscreen{\vspace{2cm}}{\vspace{0.5cm}}

    {\Huge \textbf{\@title}}

    {\LARGE \SubTitle}
    \vfill

    {\large Master's thesis\\for the degree of \DegreeType

    Trondheim, \Month\ \Year

    Norwegian University of Science and Technology\\
    \Faculty\ \\
    \Department}
    \printandscreen{\vspace{2cm}}{\vspace{0.75cm}}

    \includegraphics[width=0.4\textwidth]{Build/NTNUlogo}

    \newpage
    {~}
    \vfill
    {
    \scriptsize
    \textbf{NTNU}

    Norwegian University of Science and Technology

    Master's thesis\\
    for the degree of \DegreeType

    \Faculty\ \\
    \Department

    \copyright\ \Year\ \@author. \CopyrightNotice

    ISBN \ISBNPrinted\ (printed version)\\
    ISBN \ISBNElectronic\ (electronic version)\\
    ISSN 1503-8181

    Master's theses at NTNU, \SerialNumber

    Printed by NTNU-trykk
    }
    \end{titlingpage}
}

\captionstyle{\small}
\captionnamefont{\small\bfseries}
\hangcaption
\captiondelim{  --  }

\makechapterstyle{thesis}{%
    \chapterstyle{default}
    \renewcommand*{\chapnamefont}{\normalfont\Large\scshape\bfseries}
    \renewcommand*{\chapnumfont}{\normalfont\huge}
    \renewcommand*{\printchapternum}{\chapnumfont\thechapter} 
    \renewcommand*{\chaptitlefont}{\normalfont\Huge\scshape}
    \renewcommand*{\printchaptertitle}[1]{%
        \vspace{-1ex}\hrule
        \vspace{2ex}\chaptitlefont\textbf{##1}\vspace{2ex}\hrule}
    \renewcommand*{\afterchaptertitle}{\vskip\onelineskip\vskip
        \afterchapskip}
    \renewcommand*{\printchapternonum}{%
        \vphantom{\chapnumfont \textit{9}}\afterchapternum}
}

\makechapterstyle{thesis2}{
    \settypeblocksize{*}{28pc}{1.618}
    \setlength{\afterchapskip}{40pt}
    \renewcommand*{\chapterheadstart}{\vspace*{40pt}}
    \renewcommand*{\afterchapternum}{\par\nobreak\vskip 25pt}
    \renewcommand*{\chapnamefont}{\normalfont\Large\scshape\bfseries\flushright}
    \renewcommand*{\chapnumfont}{\normalfont\HUGE}
    \renewcommand*{\chaptitlefont}{\normalfont\HUGE\bfseries\scshape\flushright}
    \renewcommand*{\printchaptername}{%
        \chapnamefont\MakeUppercase{\@chapapp}}
    \renewcommand*{\chapternamenum}{}
    \setlength{\beforechapskip}{18mm}%  \numberheight
    \setlength{\midchapskip}{\paperwidth}% \barlength
    \addtolength{\midchapskip}{-\textwidth}
    \addtolength{\midchapskip}{-\spinemargin}
    \renewcommand*{\printchapternum}{%
        \makebox[0pt][l]{%
        \hspace{.8em}%
        \resizebox{!}{\beforechapskip}{\chapnumfont \thechapter}%
        \hspace{.8em}%
        \rule{\midchapskip}{\beforechapskip}%
        }%
    }%
    \renewcommand*{\printchaptertitle}[1]{%
        \flushright\vspace{-1ex}\hrule
        \vspace{2ex}\chaptitlefont\textbf{##1}\vspace{2ex}\hrule}
    \makeoddfoot{plain}{}{}{\thepage}
}

\AtBeginDocument{
    \chapterstyle{thesis}
    \pagestyle{fancy}
    \renewcommand{\headrulewidth}{0.4pt}
    \renewcommand{\sectionmark}[1]{\markright{\textbf{\thesection.\ #1}}}
    \renewcommand{\chaptermark}[1]{\markboth{\textbf{#1}}{}}
    \rhead{\nouppercase{\leftmark}}
    \lhead{\nouppercase{\rightmark}}
    \printandscreen{    
        \fancyhead[LE,RO]{\textbf{\thepage}}
    }{  
        \fancyhead[R]{\textbf{\thepage}}
    }
    \fancyfoot[C]{}
}
