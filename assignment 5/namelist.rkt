(module nameList (lib "plt-pretty-big-text.ss" "lang")
  
  ; Define a structure for information about a baby name.
  (define-struct nameinfo (name decade rank gender) #f)     ; removed pct
  ; A nameinfo structure is (make-nameinfo n d r p g) where:
  ; * n is a string (the name)
  ; * d is a nat (the decade the stats apply to)
  ; * r is a nat in [1,1000] (the name's popularity ranking, 1 being the most popular)
  ; REMOVED* p is a num in (0, 1) (the percentage of all names for that decade)
  ; * g is one of {'Male, 'Female} (the gender of the babies named with this name)
  
  ; split-loc: (listof char) -> (listof string)
  ; Split a list of characters into a list of tokens separated by
  ; whitespace.
  ; Example:  (split-loc (string->list "one two three")) ==> 
  ;              (list "one" "two" "three")
  (define (split-loc loc)
    (cond
      [(empty? loc) empty]
      [(char-whitespace? (first loc)) (split-loc (rest loc))]
      [else (cons (list->string (get-token loc)) (split-loc (after-token loc)))]))
  
  
  ; get-token: (listof char) -> string
  ; Produce the next token from loc.
  (define (get-token loc)
    (cond
      [(empty? loc) empty]
      [(char-whitespace? (first loc)) empty]
      [else (cons (first loc) (get-token (rest loc)))]))
  
  ; after-token: (listof char) -> (listof char)
  ; Strip the first token from loc; return the rest of the list.
  (define (after-token loc)
    (cond
      [(empty? loc) empty]
      [(char-whitespace? (first loc)) loc]
      [else (after-token (rest loc))]))
  
  ; parse-line: string (listof name) -> name
  ; Consume one line of text, parse it, and produce the corresponding
  ; name structure.
  (define (parse-line line)
    (local [(define fields (split-loc (string->list line)))]
      (make-nameinfo (first fields)
                     (string->number (second fields))
                     (string->number (third fields))
                     ;(string->number (fourth fields))
                     (string->symbol (fifth fields)))
      ))
  
  ; lines: file -> (listof name)
  ; Read a file, parsing each line to build a list of name structures.
  (define (lines in)
    (local [(define (lines lst)
              (local [(define line (read-line in))]
                (cond [(eof-object? line) lst]
                      [else (lines (cons (parse-line line) lst))])))
            ]
      (lines empty)))
  
  
  (define name-list (call-with-input-file "names.txt" lines))
  (define short-name-list (filter (lambda (x) (string<? (nameinfo-name x) "B")) name-list))
  
  ; A constant to indicate that the name wasn't found -- much larger
  ; than highest expected ranking.
  (define NOT-FOUND 5000)
  
  ; insert-missing-decades: namelist -> namelist
  ; Insert nameinfo structures into nlst for each decade between
  ; first-dec and last-dec that isn't present.  It is assumed that nlst
  ; is in sorted order by decade.
  (define (insert-missing-decades first-dec last-dec nlst)
    (cond [(and (= first-dec last-dec) (empty? nlst))
           (cons (make-nameinfo "" last-dec NOT-FOUND 'Male) empty)]
          [(and (= first-dec last-dec) (cons? nlst))
           nlst]
          [(and (< first-dec last-dec)
                (empty? nlst))
           (cons (make-nameinfo "" first-dec NOT-FOUND 'Male)
                 (insert-missing-decades (+ first-dec 10) last-dec nlst))]
          [(and (< first-dec last-dec)
                (cons? nlst)
                (< first-dec (nameinfo-decade (first nlst))))
           (cons (make-nameinfo "" first-dec NOT-FOUND 'Male)
                 (insert-missing-decades (+ first-dec 10) last-dec nlst))]
          [(and (< first-dec last-dec)
                (cons? nlst)
                (= first-dec (nameinfo-decade (first nlst))))
           (cons (first nlst)
                 (insert-missing-decades (+ first-dec 10) last-dec (rest nlst)))]
          [else (error "Error inserting missing decades.")]))
  
  
  
  (provide name-list 
           short-name-list
           make-nameinfo 
           nameinfo-name nameinfo-decade nameinfo-rank ;nameinfo-pct 
           nameinfo-gender 
           nameinfo?
           display
           insert-missing-decades)
  
  )

