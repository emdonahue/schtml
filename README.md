# SCHTML
A Scheme library for generating raw HTML and CSS

SCHTML provides a collection of scheme funcitons that simplify the generation of raw HTML and CSS strings. It was written and debugged in Guile scheme.

## API

### HTML

The `html` function accepts a list representing a tree of HTML nodes. The first element is either a string representing a text node or a list headed by a symbol/string/list corresponding to a tag, and subsequent elements corresponding to child nodes defined recursively. If the tag is a symbol/string, it is treated as a tag name. If it is a list, the first element is the tag name and subsequent elements are treated as a property list of attribute name/value pairs. If an attribute value is a list, it is joined into a space-separated string. 

```scheme
(html "lorem ipsum") ; "lorem ipsum"
(html '(p "lorem ipsum")) ; <p>lorem ipsum</p>
(html '("p" "lorem ipsum")) ; <p>lorem ipsum</p>
(html '((p class article) "lorem ipsum")) ; <p class="article">lorem ipsum</p>
(html '((p class (bold italics)) "lorem ipsum")) ; <p class="bold italics">lorem ipsum</p>
(html '(p (span "lorem") " " (span "ipsum"))) ; <p><span>lorem</span> <span>ipsum</span></p>
```

### CSS

The `css` function accepts a list of lists, where each sublist begins with a symbol/string/list representing the css selector and ends with a property list of string/symbol keys representing properties and strings/symbols/lists representing values. Symbols are converted into strings and lists are joined together.

```scheme
(css '((.bold font-weight bold))) ; .bold{ font-weight: bold; }
(css '((.bold font-weight bold) (.italics font-style italic))) ; .bold{ font-weight: bold; } .italics { font-style: italic; }
(css '(("p > span" font-weight bold))) ; p > span{ font-weight: bold; }
(css '(((p > span) font-weight bold))) ; p > span{ font-weight: bold; }
(css '((.border border (1px solid black)))) ; .border{ border: 1px solid black }
```

### Running the Code
Tests can be run with `guile -L . test.scm`

For a simple website generator, import the library, generate the HTML/CSS string, and write it to the appropriate files with `(with-output-to-file "index.html" (lambda () (display (my-html-function))) 'replace)`