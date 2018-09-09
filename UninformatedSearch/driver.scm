(load "search.scm")
(require rackunit)
(require rackunit/text-ui)

;; Lab: Uninformed Search
;; CSC 261 
;;
;; File
;;   driver.scm
;;
;; Summary
;;   A collection of routines finding solutions to search space problem
;;
;; Provides
;;   A test-suite to check that the output of algorithms
;;   implemented in search.scm is the same as expected
;;   

  
;;Problem Definitions - jump Problem 10 & 25)
  
(define small-course 10)
(define large-course 25)
(define start-small (jump-start-state small-course))
(define start-big (jump-start-state large-course))
;;Depth First Test Defintions
(define depth-first-solutions-small (depth-first-search start-small (jump-problem small-course)))
(define depth-first-solutions-big (depth-first-search start-big (jump-problem large-course)))
(define depth-test-small (list (length (car depth-first-solutions-small)) (cadr depth-first-solutions-small)))
(define depth-test-big (list (length (car depth-first-solutions-big)) (cadr depth-first-solutions-big)))
;Breadth First Test Definitions
(define breadth-first-solutions-small (breadth-first-search start-small (jump-problem small-course)))
(define breadth-first-solutions-big (breadth-first-search start-big (jump-problem large-course)))
(define breadth-test-small (list (length (car breadth-first-solutions-small)) (cadr breadth-first-solutions-small)))
(define breadth-test-big (list (length (car breadth-first-solutions-big)) (cadr breadth-first-solutions-big)))
;;Depth Limited Test Definitions
;Normal depth limit
(define depth-limited-solutions-small (depth-limited-search start-small (jump-problem small-course) 10))
(define depth-limited-solutions-big (depth-limited-search start-big (jump-problem large-course) 30))

(define limited-test-small (list (length (car depth-limited-solutions-small)) (cadr depth-limited-solutions-small)))
(define limited-test-big (list (length (car depth-limited-solutions-big)) (cadr depth-limited-solutions-big)))
;depth limit too low
(define depth-limited-low (depth-limited-search start-small (jump-problem small-course) 3))
(define limited-test-low (list (car depth-limited-low) (cadr depth-limited-low)))

(define depth-limited-low-big-course (depth-limited-search start-big (jump-problem large-course) 3))
(define limited-test-low-big-course (list (car depth-limited-low) (cadr depth-limited-low)))
;;Iterative Deepening Test Definitions
(define iterative-solutions (iterative-deepening-search start-big (jump-problem large-course)))
(define iterative-test (list (length (car iterative-solutions)) (cadr iterative-solutions)))
(define iterative-solutions-small (iterative-deepening-search start-small (jump-problem small-course)))
(define iterative-test-small (list (length (car iterative-solutions-small)) (cadr iterative-solutions-small)))


(define test-search-algorithms
  (test-suite
   "Tests for search procedure"
   (test-case
    "Depth First Search - 10 Jump Problem"
    (check-equal? depth-test-small
                  (list 5 8)
                  "Depth First Search - 10 jump Problem"))
   (test-case
    "Depth First Search - 25 Jump Problem"
    (check-equal? depth-test-big
                  (list 9 35)
                  "Depth First Search - 25 jump Problem"))
   (test-case
    "Breadth First Search - 10 Jump Problem"
    (check-equal? breadth-test-small
                  (list 5 44)
                  "Breadth First Search - 10 jump Problem"))
   (test-case
    "Breadth First Search - 25 Jump Problem"
    (check-equal? breadth-test-big
                  (list 9 6207)
                  "Breadth First Search - 25 jump Problem"))
   (test-case
    "Depth Limited - Adequate Limit Small Problem (10)"
    (check-equal? limited-test-small
                  (list 5 8)
                  "Adequate limit Small Problem"))
   (test-case
    "Depth Limited - Adequate Limit Large Problem (25)"
    (check-equal? limited-test-big
                  (list 9 35)
                  "Adequate limit Large Problem"))
   (test-case
    "Depth Limited - Limit Too Low (3) Small Problem"
    (check-equal? limited-test-low
                  (list #f 16)
                  "Limit Too Low Small Problem"))
   (test-case
    "Depth Limited - Limit Too Low (3) Large Problem"
    (check-equal? limited-test-low-big-course
                  (list #f 16)
                  "Limit Too Low Large Problem"))
   (test-case
    "Iterative Deepening - Large Problem"
    (check-equal? iterative-test
                  (list 9 9674)
                  "Large problem"))
   (test-case
    "Iterative Deepening - Large Problem"
    (check-equal? iterative-test
                  (list 9 9674)
                  "Large problem"))))
(run-tests test-search-algorithms)