\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{note}[2024/02/17 Custom class for weekly reports]

\LoadClass{article}
% Report-specific packages

\RequirePackage{graphicx}
\RequirePackage{hyperref}
\hypersetup{
  colorlinks=true,
  linkcolor=blue,
  filecolor=blue,
  urlcolor=blue,
  citecolor=blue
}
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{booktabs}
\RequirePackage{subcaption}
\RequirePackage{multicol}
\RequirePackage{listings}
\RequirePackage{multirow}
\RequirePackage{tikz}

\RequirePackage{geometry}
\RequirePackage{fancyhdr}
\RequirePackage{enumitem}
\RequirePackage{titling}
\RequirePackage{titlesec}

\RequirePackage{ctex}
% Prefer macOS CJK fonts when available, otherwise fall back to TeX Live fonts.
\IfFontExistsTF{Songti SC}{
  \setCJKmainfont{Songti SC}
}{
  \setCJKmainfont{Source Han Serif CN}
}
\IfFontExistsTF{Lantinghei TC}{
  \setCJKsansfont{Lantinghei TC}
}{
  \setCJKsansfont{Source Han Sans CN}
}
% \setCJKmonofont{Maple Mono NF CN} % Monospaced Chinese font (Fangsong)

%% Customize the title format
\titleformat{\section}
{\normalfont\Large\bfseries}{\thesection}{1em}{}

% Settings specific to report
\geometry{margin=1in, paperheight=11in, paperwidth=8.5in} % Standard letter size with normal margins

\renewcommand{\maketitle}{
  \begin{center}
    \LARGE\bfseries\thetitle\\[0.5em]
    \large\today
  \end{center}
}

% Setup page style with footer containing copyright information and page number
\pagestyle{fancy}
\fancyhf{} % Clear all header and footer fields
\renewcommand{\headrulewidth}{0pt} % Remove header rule
\fancyfoot[L]{\footnotesize \copyright\ \the\year\ \theauthor} % Copyright notice with author name in footer
\fancyfoot[R]{\thepage} % Page number on right side
\fancypagestyle{plain}{% Also apply to the first page
  \fancyhf{}
  \renewcommand{\headrulewidth}{0pt}
  \fancyfoot[L]{\footnotesize \copyright\ \the\year\ \theauthor}
  \fancyfoot[R]{\thepage}
}
