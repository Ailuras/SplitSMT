(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_at_re (String RegLan Int) String)
(declare-fun split_rest_re (String RegLan Int) String)
(declare-fun num_splits_re (String RegLan) Int)

(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (num_splits x d) limit)
         (num_splits x d)
         limit)
    (num_splits x d)
  )
)

(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (num_splits x d) limit))
    (split_rest x d (- limit 1))
    (split_at x d i)
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

(declare-sort var593 0)
(declare-sort var832 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var832-init () var832)
(declare-fun <init>/-325640736 (var832) void)
(declare-const null-String String)
(declare-const var3325 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var3325 null-String)))
(define-const var3553 var832 var832-init) ; Statement: $r0 = new java.util.ArrayList 
(assert true)
;(assert (<init>/-325640736 var3553)) ; Statement: specialinvoke $r0.<java.util.ArrayList: void <init>()>() 

(declare-const var3553!1 var832)
; split operation: var2920 = var3325.split("[,;]") ; Statement: r2 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("[,;]") 
(define-const var2365 Int (get_split_length_re var3325 (re.union (str.to_re ",") (str.to_re ";")) (- 1))) ; Statement: i0 = lengthof r2 
(define-const var694 Int 0) ; Statement: i2 = 0 
(assert true) ; Non Conditional
 ; Statement: if i2 >= i0 goto return $r0 
(assert (>= var694 var2365)) ; Cond: i2 >= i0 
 ; Statement: return $r0 
(check-sat)
; {var832-init=([], java.util.ArrayList), <init>/-325640736=([java.util.ArrayList], void)}
; {var3325=r1, var593=null_type, var832=java.util.ArrayList, var3553=$r0, var2920=r2, var2365=i0, var694=i2}
; {r1=var3325, null_type=var593, java.util.ArrayList=var832, $r0=var3553, r2=var2920, i0=var2365, i2=var694}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r1 := @parameter0: java.lang.String;	$r0 = new java.util.ArrayList;	specialinvoke $r0.<java.util.ArrayList: void <init>()>();	r2 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("[,;]");	i0 = lengthof r2;	i2 = 0;	if i2 >= i0 goto return $r0;	return $r0
;block_num 3
(exit)
