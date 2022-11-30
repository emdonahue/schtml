#lang racket
(provide html css)

(define html
  (lambda hs
    (apply string-append
	   (map render-html hs))))

(define (render-html h)
  (if (list? h) (open-close-tag (car h) (cdr h))
      (->string h)))

(define (open-close-tag tag body)
  (let* ([name-class (string-split (head tag) #rx"[.]")]
	 [name (car name-class)])
    (string-append "<" name (classnames (cdr name-class)) (tail tag) ">" (html-body body) "</" name ">")))

(define (head list-or-atom)
  (->string (if (list? list-or-atom) (car list-or-atom) list-or-atom)))

(define (tail list-or-atom)
  (attributes (if (list? list-or-atom) (cdr list-or-atom) '())))

(define (classnames classes)
  (if (null? classes) "" (attributes (list "class" classes))))

(define (attributes a)			; Plist -> html attributes
  (if (null? a) ""      
      (string-append
       " "		     
       (->string (car a)) "=\""
       (if (and (eq? 'style (car a)) (list? (cadr a)))
	   (css-properties (cadr a))
	   (->string (cadr a)))
       "\"" (attributes (cddr a)))))

(define (html-body h)
  (if (null? h) ""
      (string-append (html (car h)) (html-body (cdr h)))))

(define (css c)
  (apply string-append (map css-rule c))
  )

(define (css-rule r)
  (string-append (->string (car r)) "{" (css-properties (cdr r)) "}"))

(define (->string s)
  (cond
   [(symbol? s) (symbol->string s)]
   [(number? s) (number->string s)]
   [(list? s) (string-join (map ->string s))]
   [else s]))

#;(define (string-join delim strs)
(if (null? strs) ""
(fold-left (lambda (str s) (string-append str delim s)) (car strs) (cdr strs))))

(define (css-properties p) ; P-list of name: value
  (if (null? p) ""
      (string-append (->string (car p)) ":" (->string (cadr p)) ";" (css-properties (cddr p)))))

					;)
