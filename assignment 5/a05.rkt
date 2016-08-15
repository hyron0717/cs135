;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname a05) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;;
;; *************************************************
;;
;; CS 135 Assignment 5
;; HaoJun Luo, 20528243
;;
;; *************************************************

(require "namelist.rkt")
(define name1 (make-nameinfo "Finley" 2000 1000 'Female))
(define name2 (make-nameinfo "John" 1890 1 'Male))
(define name3 (make-nameinfo "Mary" 1890 1 'Female))
(define name4 (make-nameinfo "John" 2000 30 'Male))
(define name5 (make-nameinfo "John" 2000 2 'Female))
(define name6 (make-nameinfo "John" 2000 500 'Male))
;; 1.
;; A nameinfo = (make-nameinfo (String Int Int[1, 1000] Symbol)
;; my-nameinfo-fn: nameinfo -> Any
(define (my-nameinfo-fn info)
  (... (nameinfo-name info)...
       (nameinfo-decade info)...
       (nameinfo-rank info)...
       (nameinfo-gender info)...))

;; list-of-nameinfo is one of:
;; empty
;; (cons nameinfo (list-of-nameinfo))

;; Template: 
;; Namelist: (listof nameinfo) -> Any
(define (Namelist lon)
  (cond
    [(empty? lon) ...]
    [else (...(first lon) ...
              (Namelist (rest lon)) ...)]))

;; 2.
;; Contract: 
;; find-rank: (listof nameinfo) String Symbol Int -> Union( Int[1,1000] false)

;; Purpose: search the person in the nama list and output the rank.
;; Example:
(check-expect (find-rank empty "John" 'Male 1890) false)
(check-expect (find-rank (list name1 name3) "John" 'Male 1890) false)

;; Definition:
(define (find-rank namelist search-name search-gender search-decade)
  (cond 
    [(empty? namelist) false]
    [else 
     (cond 
       [(and (equal? (nameinfo-name (first namelist)) search-name)
             (equal? (nameinfo-gender (first namelist)) search-gender)
             (= (nameinfo-decade (first namelist)) search-decade))
        (nameinfo-rank (first namelist))]
       [else (find-rank (rest namelist) search-name search-gender search-decade)])]))

;; Test:
(check-expect (find-rank (list name1 name3 name2) "John" 'Male 1890) 1)
(check-expect (find-rank name-list "John" 'Male 1890) 1)

;; 3.
;; Contract:
;; collect-name: (listof nameinfo) String Symbol -> listof nameinfo

;; Purpose: find the information about the people with same name.
;; Example:
(check-expect (collect-name (list name2 name4) "John" 'Male) 
              (list (make-nameinfo "John" 1890 1 'Male) 
                    (make-nameinfo "John" 2000 30 'Male)))

(check-expect (collect-name empty "John" 'Male) empty)

;; Defination:
(define (collect-name namelist search-name search-gender)
  (cond
    [(empty? namelist) empty]
    [else
     (cond
       [(and (equal? (nameinfo-name (first namelist)) search-name)
             (equal? (nameinfo-gender (first namelist)) search-gender))
        (cons (first namelist) (collect-name (rest namelist) search-name search-gender))]
       [else (collect-name (rest namelist) search-name search-gender)])]))

;; Test: 
(check-expect (collect-name (list name1 name2 name3 name4) "John" 'Male) 
              (list (make-nameinfo "John" 1890 1 'Male) 
                    (make-nameinfo "John" 2000 30 'Male)))

;; 4.
;; Contract:
;; first-n: (listof Any) Nat -> (Union (listof Any) Symbol)

;; Purpose: show from first to n elements in the list.
;; Example:
(check-expect (first-n empty 2) 'NotEnoughItems)
(check-expect (first-n (list name1 name2 name3 name4) 2) 
              (list (make-nameinfo "Finley" 2000 1000 'Female)
                    (make-nameinfo "John" 1890 1 'Male)))

;; Defination: 
(define (first-n list number)
  (cond 
    [(and (empty? list) (zero? number)) empty]
    [(symbol? (first 
               (reverse 
                (helper list number)))) 
     'NotEnoughItems]
    [else (helper list number)]))

;; Test
(check-expect (first-n (list name1 name2 name3 name4) 5) 'NotEnoughItems)

(check-expect (first-n (list 1 2 3 4 5) 4)
              (list 1 2 3 4))

(check-expect (first-n (list 1 2 3 4 5) 6) 'NotEnoughItems)

;; helper function
;; Contrast:
;; helper: (listof Any) Nat -> (listof (Union (Any Symbol)))

;; Purpose: make a list from first one to n.
;; Example:
(check-expect (helper (list 1 2 3 4 5) 6) (list 1 2 3 4 5 'NotEnoughItems))
(check-expect (helper empty 1) (cons 'NotEnoughItems empty))

;; Definition:
(define (helper list number)
  (cond 
    [(empty? list) 
     (cond
       [(zero? number) empty]
       [else (cons 'NotEnoughItems empty)])]
    [else 
     (cond
       [(= number 0) empty]
       [else (cons (first list) (helper (rest list) (sub1 number)))])]))
;; Test:
(check-expect (helper (list 1 2 3 4 5) 4) (list 1 2 3 4))
(check-expect (helper empty 0) empty)



;; 5. 
;; Contrast: 
;; name-sort: (listof nameinfo) -> (listof nameinfo)

;; Purpose: produces a list sorted in increasing order.
;; Example:
(check-expect (name-sort (list name2 name1 name3 name4))
              (list
               (make-nameinfo "Finley" 2000 1000 'Female)
               (make-nameinfo "John" 1890 1 'Male)
               (make-nameinfo "John" 2000 30 'Male)
               (make-nameinfo "Mary" 1890 1 'Female)))

(check-expect (name-sort empty) empty)

;; Definition:
(define (name-sort namelist)
  (cond
    [(empty? namelist) empty]
    [else (name-insert (first namelist) (name-sort (rest namelist)))]))

;; Test:
(check-expect (name-sort (list name3 name1)) 
              (list
               (make-nameinfo "Finley" 2000 1000'Female)
               (make-nameinfo "Mary" 1890 1 'Female)))


;; Contrast:
;; name-insert: nameinfo (listof nameinfo) -> (listof nameinfo)

;; Purpose: adds the nameinfo to the sorted list.
;; Example:
(check-expect (name-insert name1 empty) 
              (list 
               (make-nameinfo "Finley" 2000 1000'Female)))

(check-expect (name-insert name4 (list name5)) 
              (list
               (make-nameinfo "John" 2000 2 'Female)
               (make-nameinfo "John" 2000 30 'Male)))

;; Definition:
(define (name-insert info namelist)
  (cond 
    [(empty? namelist) (cons info empty)]
    [else 
     (cond 
       [(string<? (nameinfo-name info) 
                  (nameinfo-name (first namelist)))
        (cons info namelist)]
       [(and (equal? (nameinfo-name info) 
                     (nameinfo-name (first namelist)))
             (not (equal? (nameinfo-gender info) 
                          (nameinfo-gender (first namelist))))
             (equal? (nameinfo-gender info)
                     'Female))
        (cons info namelist)]
       [(and (equal? (nameinfo-name info) 
                     (nameinfo-name (first namelist)))
             (equal?  (nameinfo-gender info) 
                      (nameinfo-gender (first namelist)))
             (< (nameinfo-decade info)
                (nameinfo-decade (first namelist))))
        (cons info namelist)]
       [else (cons (first namelist) (name-insert info (rest namelist)))])]))

;; Test: 
(check-expect (name-insert name2 (list name1 name3)) 
              (list
               (make-nameinfo "Finley" 2000 1000'Female)
               (make-nameinfo "John" 1890 1 'Male)
               (make-nameinfo "Mary" 1890 1 'Female)))

(check-expect (name-insert name2 (list name5 name4))
              (list
               (make-nameinfo "John" 2000 2 'Female)
               (make-nameinfo "John" 1890 1 'Male)
               (make-nameinfo "John" 2000 30 'Male)))

;; 6.
;; Contrast: 
;; bar-graph: (listof Nat) -> String

;; Purpose: make a bar graph by using the list of natural numbers.
;; Example:
(check-expect (bar-graph empty) "")
(check-expect (bar-graph (list 1)) "*\n")

;; Definition:
(define (bar-graph lon)
  (cond 
    [(empty? lon) ""]
    [else (list->string (count-stars lon))]))
;; Test: 
(check-expect (bar-graph (list 1 2 3 4)) "*\n**\n***\n****\n")
(check-expect (bar-graph (list 5 10 0 3)) "*****\n**********\n\n***\n")

;; Contrast: 
;; count-stars: (listof Nat) -> (listof String)

;; Purpose: count how many stars in one element.
;; Example: 
(check-expect (count-stars empty) empty)
(check-expect (count-stars (list 1)) (list #\* #\newline))

;; Definition:
(define (count-stars lon)
  (cond
    [(empty? lon) empty]
    [else
     (cond
       [(zero? (first lon)) 
        (cons #\newline (count-stars (rest lon)))]
       [else (cons #\* (count-stars (cons (sub1 (first lon)) (rest lon))))])]))
;; Test:
(check-expect (count-stars (list 1 2 3)) (list #\* #\newline #\* #\* #\newline #\* #\* #\* #\newline))

;; 7.
;; Contrast: 
;; name-popularity-graph: (listof nameinfo) String Symbol -> String

;; Purpose: make a bar graph for the person popularity rank.
;; Example:
(check-expect (name-popularity-graph empty "Kimberly" 'Female) empty)

;; Definition:
(define (name-popularity-graph namelist name gender)
  (cond
    [(empty? namelist) empty]
    [else (bar-graph (inserted-rank namelist name gender))]))
    
    
;; Contrast:
;; find-names: (listof nameinfo) String Symbol -> (listof nameinfo)
(define (find-names namelist name gender)
  (cond 
    [(empty? namelist) empty]
    [else 
     (cond
       [(and (equal? (nameinfo-name (first namelist)) name)
             (equal? (nameinfo-gender (first namelist)) gender))
        (cons (first namelist) (find-names (rest namelist) name gender))]
       [else (find-names (rest namelist) name gender)])]))

;; Contrast:
;; inserted-rank: (listof nameinfo) String Symbol -> (listof Int)
(define (inserted-rank namelist name gender)
  (rank-stars (insert-missing-decades 1890 2000 (name-sort (find-names namelist name gender))) name gender))

;; Contrast: 
;; rank-stars: (listof nameinfo) String Symbol -> (listof Int)
(define (rank-stars namelist name gender)
  (cond
    [(empty? namelist) empty]
    [else 
     (cond 
       [(> (nameinfo-rank (first namelist)) 1000)
        (cons 0 (rank-stars (rest namelist) name gender))]
       [else (cons (- 67 
                      (floor (/ (nameinfo-rank (first namelist)) 
                                15)))
                   (rank-stars (rest namelist) name gender))])]))
;; Test:
(check-expect (name-popularity-graph (list name1 name3 name5 name6) "John" 'Male) 
              "\n\n\n\n\n\n\n\n\n\n\n**********************************\n")
(check-expect (name-popularity-graph (list name1 name3 name5) "John" 'Male) 
              "\n\n\n\n\n\n\n\n\n\n\n\n")