(import (schtml))

(define (test actual expected)
  (if (not (equal? actual expected))
	(display (string-append "expected: " expected "\nreceived: " actual "\n\n"))))

(test (html "lorem ipsum") "lorem ipsum")
(test (html '(p "lorem ipsum")) "<p>lorem ipsum</p>")
(test (html '("p" "lorem ipsum")) "<p>lorem ipsum</p>")
(test (html '((p class article) "lorem ipsum")) "<p class=\"article\">lorem ipsum</p>")
(test (html '((p class (bold italics)) "lorem ipsum")) "<p class=\"bold italics\">lorem ipsum</p>")
(test (html '(p (span "lorem") " " (span "ipsum"))) "<p><span>lorem</span> <span>ipsum</span></p>")

(test (css '((.bold font-weight bold))) ".bold{font-weight:bold;}")
(test (css '((.bold font-weight bold) (.italics font-style italic))) ".bold{font-weight:bold;}.italics{font-style:italic;}")
(test (css '(("p > span" font-weight bold))) "p > span{font-weight:bold;}")
(test (css '(((p > span) font-weight bold))) "p > span{font-weight:bold;}")
(test (css '((.border border (1px solid black)))) ".border{border:1px solid black;}")


