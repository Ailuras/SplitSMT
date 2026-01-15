(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)
(declare-fun split_at_re (String RegLan Int) String)
(declare-fun split_rest_re (String RegLan Int) String)
(declare-fun num_splits_re (String RegLan) Int)

(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(define-fun get_split_length_re ((x String) (d RegLan) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (num_splits_re x d) limit)
         (num_splits_re x d)
         limit)
    (num_splits_re x d)
  )
)

(define-fun get_split_element_re ((x String) (d RegLan) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (num_splits_re x d) limit))
    (split_rest_re x d (- limit 1))
    (split_at_re x d i)
  )
)

(declare-sort var3493 0)
(declare-sort var495 0)
(declare-sort var984 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun is-whitespace ((char String)) Bool (< (str.to_code char) 33))
(define-fun-rec trim-left ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s 0 1)) (trim-left (str.substr s 1 (- (str.len s) 1))) s)))
(define-fun-rec trim-right ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s (- (str.len s) 1) 1)) (trim-right (str.substr s 0 (- (str.len s) 1))) s)))
(define-fun trim/-847153721 ((s String)) String (trim-right (trim-left s)))
(declare-const null-var3493 var3493)
(declare-const null-var495 var495)
(declare-const null-String String)
(declare-const var1452 var3493) ; Statement: r4 := @parameter0: java.util.Map 
(assert (not (= var1452 null-var3493)))
(declare-const var1256 var495) ; Statement: r3 := @parameter1: java.util.List 
(assert (not (= var1256 null-var495)))
(declare-const var1466 String) ; Statement: r0 := @parameter2: java.lang.String 
(assert (not (= var1466 null-String)))
(assert true)
(define-const var153 String (trim/-847153721 var1466)) ; Statement: $r1 = virtualinvoke r0.<java.lang.String: java.lang.String trim()>() 
; split operation: var189 = var153.split("\u005cs+") ; Statement: r2 = virtualinvoke $r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+") 
(define-const var1928 Int (get_split_length_re var153 (re.+ (re.union (str.to_re " ") (str.to_re "\u{09}"))) (- 1))) ; Statement: $i0 = lengthof r2 
 ; Statement: if $i0 != 0 goto $i1 = lengthof r2 
(assert (not (not (= var1928 0)))) ; Negate: Cond: $i0 != 0  
 ; Statement: return 
(check-sat)
; {trim/-847153721=([java.lang.String], java.lang.String)}
; {var3493=java.util.Map, var1452=r4, var495=java.util.List, var1256=r3, var1466=r0, var984=null_type, var153=$r1, var189=r2, var1928=$i0}
; {java.util.Map=var3493, r4=var1452, java.util.List=var495, r3=var1256, r0=var1466, null_type=var984, $r1=var153, r2=var189, $i0=var1928}
;seq <java.lang.String: java.lang.String trim()>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String trim()>": 1,"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r4 := @parameter0: java.util.Map;	r3 := @parameter1: java.util.List;	r0 := @parameter2: java.lang.String;	$r1 = virtualinvoke r0.<java.lang.String: java.lang.String trim()>();	r2 = virtualinvoke $r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+");	$i0 = lengthof r2;	if $i0 != 0 goto $i1 = lengthof r2;	return
;block_num 2
(exit)
