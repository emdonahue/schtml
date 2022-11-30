#lang racket

(require rackunit "schtml.rkt")

(check-equal? (html "lorem ipsum") "lorem ipsum")
(check-equal? (html '(p "lorem ipsum")) "<p>lorem ipsum</p>")
(check-equal? (html '("p" "lorem ipsum")) "<p>lorem ipsum</p>")
(check-equal? (html '((p class article) "lorem ipsum")) "<p class=\"article\">lorem ipsum</p>")
(check-equal? (html '((p style (font-weight bold)) "lorem ipsum")) "<p style=\"font-weight:bold;\">lorem ipsum</p>")
(check-equal? (html '(p.article "lorem ipsum")) "<p class=\"article\">lorem ipsum</p>")
(check-equal? (html '(p.article.main "lorem ipsum")) "<p class=\"article main\">lorem ipsum</p>")
(check-equal? (html '((p class (bold italics)) "lorem ipsum")) "<p class=\"bold italics\">lorem ipsum</p>")
(check-equal? (html '(p (span "lorem") " " (span "ipsum"))) "<p><span>lorem</span> <span>ipsum</span></p>")
(check-equal? (html '(html (body "lorem ipsum")) #t) "<!DOCTYPE html><html><body>lorem ipsum</body></html>")

(check-equal? (css '((.bold font-weight bold))) ".bold{font-weight:bold;}")
(check-equal? (css '((.bold font-weight bold) (.italics font-style italic))) ".bold{font-weight:bold;}.italics{font-style:italic;}")
(check-equal? (css '(("p > span" font-weight bold))) "p > span{font-weight:bold;}")
(check-equal? (css '(((p > span) font-weight bold))) "p > span{font-weight:bold;}")
(check-equal? (css '((.border border (1px solid black)))) ".border{border:1px solid black;}")
