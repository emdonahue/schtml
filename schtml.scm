#;(library (schtml)
  (export html css)
  (import (ice-9 regex)))
(define-module (schtml)
  #:use-module (ice-9 regex)
#:export (html css))


  
  (define (html h)
    (if (list? h) (open-close-tag (car h) (cdr h))
	(->string h)))

(define (open-close-tag tag body)
  (string-append (open-tag (car h)) (html-body (cdr h)) (close-tag (car h)))
  )

  (define (open-tag tag)
    (if (or (symbol? tag) (string? tag)) (string-append "<" (tagname tag) ">")	
	(string-append "<" (tagname (car tag)) (attributes (cdr tag)) ">"))) ; (tag . attribute-plist)

  (define (tagname tag)
    (let ((tag-classes (map match:substring (list-matches "[^.]+" (->string tag)))))
      (string-append (car tag-classes) (classnames (cdr tag-classes)))))

  (define (classnames classes)
    (if (null? classes) ""
	(string-append " class=\"" (string-join classes) "\"")))
  
  (define (attributes a) ; Plist -> html attributes
    (if (null? a) ""      
	(string-append
	 " "		     
	 (->string (car a)) "=\""
	 (if (and (eq? 'style (car a)) (list? (cadr a)))
	     (css-properties (cadr a))
	     (->string (cadr a)))
	 "\"" (attributes (cddr a)))))

  (define (close-tag tag)
    (if (or (symbol? tag) (string? tag)) (string-append "</" (->string tag) ">")
	(close-tag (car tag))))

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
