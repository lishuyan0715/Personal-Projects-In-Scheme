;; Lab: Adversarial Search
;; CSC 261 
;;
;; File
;;   alphabeta.scm
;;
;; Authors
;;   Jerod Weinman
;;     Wrote all but the implementations of alpha-beta-max-value and 
;;      alpha-beta-min-value
;;
;; Summary
;;   Implementation of minimax search using alpha-beta pruning
;;
;; Provides
;;   (make-alpha-beta-player game plies evaluation-fun)
;;   (alpha-beta-search game state plies evaluation-fun)
;;   (alpha-beta-max-value game action-state alpha beta depth plies eval-fun)
;;   (alpha-beta-min-value game action-state alpha beta depth plies eval-fun)
(module alphabeta lang/plt-pretty-big
  (provide make-alpha-beta-player
           alpha-beta-search
           alpha-beta-max-value
           alpha-beta-min-value)
  (require "game.scm")


  ;;
  ;; Procedure
  ;;   make-alpha-beta-player
  ;;
  ;; Purpose
  ;;   Create a player using alpha-beta minimax search
  ;;
  ;; Parameters
  ;;   game, a game
  ;;   player, a boolean
  ;;   evaluation-fun, a procedure
  ;;
  ;; Produces
  ;;   play, a procedure
  ;;
  ;; Preconditions
  ;;   evaluation-fun takes a state of game and produces a number
  ;;
  ;; Postconditions
  ;;   play is a procedure that takes a state and produces a legal
  ;;   action for player in game
  (define make-alpha-beta-player
    (lambda (game plies evaluation-fun)
      (lambda (state)
        (alpha-beta-search game state plies evaluation-fun))))

  ;;
  ;; Procedure
  ;;   alpha-beta-search
  ;;
  ;; Purpose
  ;;   Return an action using alpha-beta search
  ;;
  ;; Parameters
  ;;   game, a game
  ;;   state, a value
  ;;   plies, a number
  ;;   evaluation-fun, a procedure
  ;;
  ;; Produces
  ;;   action, a value
  ;;
  ;; Preconditions
  ;;   plies >= 0
  ;;   evaluation-fun takes a state of game and produces a number
  ;;
  ;; Postconditions
  ;;   action is a valid action from the state
  (define alpha-beta-search
    (lambda (game state plies evaluation-fun)
      (car (alpha-beta-max-value game state
                                 -inf.0 +inf.0 
                                 0 plies 
                                 evaluation-fun))))


    
  ;;
  ;; Procedure
  ;;   alpha-beta-max-value
  ;;
  ;; Purpose
  ;;   Generate the best action-value pair for a state
  ;;
  ;; Parameters
  ;;   game, a game
  ;;   state, a value
  ;;   alpha, a number
  ;;   beta, a number
  ;;   depth, a number
  ;;   plies, a number
  ;;   evaluation-fun, a procedure
  ;;
  ;; Produces
  ;;   action-value, a pair
  ;;
  ;; Preconditions
  ;;   0 <= depth < plies
  ;;   evaluation-fun takes a state of game and produces a number
  ;;
  ;; Postconditions
  ;;   (car action-value) is a valid, optimal action from the state
  ;;      (cdr action-value) is the value of the action
                
   
  (define alpha-beta-max-value
    (lambda (game state alpha beta depth plies evaluation-fun)

      ;; Informative output        
      ;      (display "MAX state: ")
      ;      (display state)(newline)
      
      (cond 
        [(or (= depth plies)                 ; Maximum depth reached
             ((game-terminal? game) state))  ; We are given a terminal state
         ((game-display-fun game)state)
         (cons null (evaluation-fun state))] ; action-value pair
        [else
         (let loop ([successors ((game-successors-fun game) state)]
                    ; successors is a list of (action . state) pairs
                    [v-action null]  ; maximizing action
                    [v-value null]
                    [a alpha])   ; inherited value

           (if (null? successors)   ; No more moves
               (if (null? v-value)
                   (error "Game produced no successors from non-terminal"
                          state)
                   (cons v-action v-value)); Return the best action value pair

               (let* ([v1  ; correspond to v in figure 5.7
                       (get-max-of-pairs
                        (cons v-action v-value)
                        (alpha-beta-min-value game
                                              (cdar successors)
                                              a
                                              beta
                                              depth
                                              plies
                                              evaluation-fun))])
                 ;;Informative output                 
                 ;                (display "MAX value: ")
                 ;                (display (cdr v1))(newline)
                 
                 (cond 
                   [(or (null? (cdr v1))    
                        (>= (cdr v1) beta))
                    
                    ;;Informative output  
                    ;                   (display "beta: ")
                    ;                   (display beta)
                    ;                   (display " prune")(newline)
                    
                    (cons v-action v-value)]
                   [else
                    (loop (cdr successors)   ; remaining possibilities
                          (caar successors)
                          (cdr v1)
                          (max (cdr v1) a))]))))])))

  ;; evaluates two pairs
  ;; returns the entire pair with bigger cdr of the two pairs 
  (define get-max-of-pairs
    (lambda (pair1 pair2)
      (if (null? (cdr pair1))
          (if (null? (cdr pair2))
              (cons null null)
              pair2)
          (if (null? (cdr pair2))
              (cons null null)
              (if (> (cdr pair1) (cdr pair2))
                  pair1
                  pair2)))))

  
  ;;
  ;; Procedure
  ;;   alpha-beta-min-value
  ;;
  ;; Purpose
  ;;   Generate the worst action-value pair for a state
  ;;
  ;; Parameters
  ;;   game, a game
  ;;   state, a value
  ;;   alpha, a number
  ;;   beta, a number
  ;;   depth, a number
  ;;   plies, a number
  ;;   evaluation-fun, a procedure
  ;;
  ;; Produces
  ;;   action-value, a pair
  ;;
  ;; Preconditions
  ;;   0 <= depth < plies
  ;;   evaluation-fun that takes a state of game and produces a number
  ;;
  ;; Postconditions
  ;;   (car action-value) is a valid, optimal action from the state
  ;;   (cdr action-value) is the value of the action

  (define alpha-beta-min-value
    (lambda (game state alpha beta depth plies evaluation-fun)

      ;;Informative output  
      ;      (display "MIN state: ")
      ;      (display state)(newline)
      
      (cond 
        [(or (= depth plies)                 ; Maximum depth reached
             ((game-terminal? game) state)); We are given a terminal state
         ((game-display-fun game)state)

         (cons null (evaluation-fun state))] ; action-value pair
        [else
         
         (let loop ([successors ((game-successors-fun game) state)]
                    ; successors is a list of (action . state) pairs
                    [v-action null]  ; maximizing action
                    [v-value null]
                    [b beta])   ; inherited value

           (if (null? successors)   ; No more moves
               (if (null? v-value)
                   (error "Game produced no successors from non-terminal"
                          state)
                   (cons v-action v-value))

               (let* ([v1  ; correspond to v in figure 5.7
                       (get-min-of-pairs
                        (cons v-action v-value)
                        (alpha-beta-max-value game
                                              (cdar successors)
                                              alpha
                                              b
                                              (+ depth 1)
                                              plies
                                              evaluation-fun))])
                 ;;Informative output  
                 ;               (display "MIN value: ")
                 ;              (display (cdr v1))(newline)
                 
                 (cond 
                   [(or (null? (cdr v1))     
                        (<= (cdr v1) alpha))

                    ;;Informative output                     
                    ;                   (display "alpha: ")
                    ;                   (display alpha)
                    ;                   (display " prune")(newline)

                    (cons v-action v-value)]
                   [else
                    (loop (cdr successors)   
                          (caar successors)
                          (cdr v1)
                          (min (cdr v1) b))]))))])))

  (define get-min-of-pairs
    (lambda (pair1 pair2)
      (if (null? (cdr pair1))
          (if (null? (cdr pair2))
              (cons null null)
              pair2)
          (if (null? (cdr pair2))
              (cons null null)
              (if (< (cdr pair1) (cdr pair2))
                  pair1
                  pair2)))))



  ) ; module