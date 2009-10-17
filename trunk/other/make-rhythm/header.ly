\version "2.12.0"
\paper{
  indent=0\mm
  ragged-last=##f
  ragged-right=##f
  line-width=75\mm  % produces 267 pixels
  oddFooterMarkup=##f
  oddHeaderMarkup=##f
  bookTitleMarkup = ##f
  scoreTitleMarkup = ##f
}

\layout {
  \context { \Score
    proportionalNotationDuration = #(ly:make-moment 1 16)
    \override SpacingSpanner #'strict-note-spacing = ##t
    \override TimeSignature #'style = #'()
  }
}

