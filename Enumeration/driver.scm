;; Lab: Propositional Logic
;; CSC 261 
;;
;; File
;;   driver.scm
;;
;; Summary
;;   A testing program for enumeration.scm
;;
;; Provides
;;   Nothing; produces test output when run
(load "enumeration.scm")


;; Tests for pl-true?

;; Test 1: Simplest sentence
(display "\nTest 1/1 - Expected: #t Actual: ")
(display (pl-true? #t '()))


;; Test 2: sentence-model link
(display "\nTest 1/2 - Expected: #f Actual: ")
(display (pl-true? 'P (list (cons 'P #f))))

;; Test 3: complex sentence
(display "\nTest 1/3 - Expected: #f Actual: ")
(display (pl-true? (list '=> (list 'and 'M 'N) 'O)
                         (list (cons 'M #t) (cons 'N #t) (cons 'O #f))))


;; Tests for tt-check-all
;; Test 1 - edge case (anything entailed from an empty KB)
(display "\nTest 2/1 - Expected: #t Actual: ")
(display (tt-check-all '()
              (list 'and 'M 'N)
              (list 'M 'N 'O)
              '()))

;; Test 2 - Simple entailment
(display "\nTest 2/2 - Expected: #t Actual: ")
(display (tt-check-all (list 'and 'M 'N)
              'N
              (list 'M 'N)
              '()))

;; Test 3 - Complex entailment
(display "\nTest 2/3 - Expected: #t Actual: ")
(display (tt-check-all (list '=> (list 'and 'M 'N) 'O)
              (list 'not (list 'and 'M (list 'and 'N (list 'not 'O))))
              (list 'M 'N 'O)
              '()))

;; Tests for tt-entails?
;; Test 1 - edge case (anything entailed from an empty KB)
(display "\nTest 3/1 - Expected: #t Actual: ")
(display (tt-entails? '()
              (list 'and 'M 'N)))

;; Test 2 - Simple entailment
(display "\nTest 3/2 - Expected: #t Actual: ")
(display (tt-entails? (list 'and 'M 'N)
             'N))

;; Test 3 - Complex entailment
(display "\nTest 3/3 - Expected: #t Actual: ")
(display (tt-entails? (list '=> (list 'and 'M 'N) 'O)
              (list 'not (list 'and 'M (list 'and 'N (list 'not 'O))))))



