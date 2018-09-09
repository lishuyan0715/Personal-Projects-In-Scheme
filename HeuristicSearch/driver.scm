;; Lab 3: Heuristic Search
;; CSC 261 
;;
;; File
;;   driver.scm
;;
;; Summary
;;   Test suites for the A* search algorithm with the jump-heuristic
;;
;; Provides
;;   A test-suite to check that the output of A* search algorithm
;;   implemented in search.scm is the same as expected
;;   

(require "search.scm")
(require "problem.scm")
(require "sort.scm")
(require "node.scm")
(require "jump.scm")
(load "heuristic.scm")
(load "astar.scm")
(require rackunit)
(require rackunit/text-ui)
  
;;Algorithem Definition - A-star search & heuristic)

(define as a-star-search)
(define jh jump-heuristic)

;;Problem Definitions - jump Problem 5,10,20,50,80,0,and 1)
;Short jumping problem
(define js-five (jump-start-state 5))
(define jp-five (jump-problem 5))
(define js-ten (jump-start-state 10))
(define jp-ten (jump-problem 10))
(define js-twenty (jump-start-state 20))
(define jp-twenty (jump-problem 20))
;Long jumping problem
(define js-fifty (jump-start-state 50))
(define jp-fifty (jump-problem 50))
(define js-eighty(jump-start-state 80))
(define jp-eighty (jump-problem 80))
;Edge cases
(define js-zero(jump-start-state 0))
(define jp-zero(jump-problem 0))
(define js-one(jump-start-state 1))
(define jp-one(jump-problem 1))
;Solutions
(define five-jumping-sol (as js-five jp-five jh))
(define ten-jumping-sol (as js-ten jp-ten jh))
(define twenty-jumping-sol (as js-twenty jp-twenty jh))
(define fifty-jumping-sol (as js-fifty jp-fifty jh))
(define eighty-jumping-sol (as js-eighty jp-eighty jh))
(define zero-jumping-sol (as js-zero jp-zero jh))
(define one-jumping-sol (as js-one jp-one jh))

(define test-astar-search-algorithm
  (test-suite
   "Tests for astar-search procedure"
   (test-case
    "A* Search - 5 Jump Problem"
    (check-equal? (list (length (car five-jumping-sol)) (cadr five-jumping-sol))
                  (list 4 9) ;expected
                  "A* Search -5 jump Problem"))
   (test-case
    "A* Search - 10 Jump Problem"
    (check-equal? (list (length (car ten-jumping-sol)) (cadr ten-jumping-sol))
                  (list 5 21) ;expected
                  "A* Search -10 jump Problem"))
   (test-case
    "A* Search - 20 Jump Problem"
    (check-equal? (list (length (car twenty-jumping-sol)) (cadr twenty-jumping-sol))
                  (list 8 297) ;expected
                  "A* Search -20 jump Problem"))
   (test-case
    "A* Search - 50 Jump Problem"
    (check-equal? (list (length (car fifty-jumping-sol)) (cadr fifty-jumping-sol))
                  (list 12 2337) ;expected
                  "A* Search -50 jump Problem"))
   (test-case
    "A* Search - 80 Jump Problem"
    (check-equal? (list (length (car eighty-jumping-sol)) (cadr eighty-jumping-sol))
                  (list 15 8248) ;expected
                  "A* Search -80 jump Problem"))
   (test-case
    "A* Search - 0 Jump Problem"
    (check-equal? (list (car zero-jumping-sol) (cadr zero-jumping-sol))
                  (list #f 2) ;expected
                  "A* Search -0 jump Problem"))
   (test-case
    "A* Search - 1 Jump Problem"
    (check-equal? (list (length (car one-jumping-sol)) (cadr one-jumping-sol))
                  (list 1 1) ;expected
                  "A* Search -1 jump Problem"))))

(run-tests test-astar-search-algorithm)