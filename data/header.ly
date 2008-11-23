\version "2.11.33"
\paper{
  indent=0\mm
  ragged-last=##f
  line-width=120\mm
  oddFooterMarkup=##f
  oddHeaderMarkup=##f
  bookTitleMarkup = ##f
  scoreTitleMarkup = ##f
}

\layout {
  \context { \Score
    proportionalNotationDuration = #(ly:make-moment 1 8)
    \override SpacingSpanner #'strict-note-spacing = ##t
    \override TimeSignature #'style = #'()
  }
}

