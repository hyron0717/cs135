;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname d) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
(define (place-guess brd pos val)
  (cond
    [(empty? brd) empty]
    [(not (= 0 (posn-y pos)))
     (cons (first brd) 
           (place-guess (rest brd) 
                        (make-posn (posn-x pos)
                                   (sub1 (posn-y pos)))
                        val))]
    [else 
     (cond
       [(empty? (first brd)) empty]
       [(not (= 0 (posn-x pos)))
        (cons (first (first brd))
              (place-guess (list (rest (first brd)))
                           (make-posn (sub1 (posn-x pos))
                                      (posn-y pos))
                           val))]
       [else (cons (make-guess (first (first brd))
                               val)
                   (place-guess (list (rest (first brd)))
                                (make-posn (sub1 (posn-x pos))
                                           (posn-y pos))
                                val))])]))