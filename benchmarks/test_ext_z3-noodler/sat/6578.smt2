(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

; 统一获取长度的函数
(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

; 统一获取元素的函数
(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var364 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun contains/1009244746 ((s String) (subs String)) Bool (str.contains s subs))
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-const null-String String)
(declare-const var2671 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2671 null-String)))
(assert true)
(define-const var3116 Bool (contains/1009244746 var2671 (cast-from-String-to-String "*"))) ; Statement: $z0 = virtualinvoke r0.<java.lang.String: boolean contains(java.lang.CharSequence)>("*") 
 ; Statement: if $z0 != 0 goto $z2 = 1 
(assert (not (not (= (ite var3116 1 0) 0)))) ; Negate: Cond: $z0 != 0  
(assert true)
(define-const var505 Bool (contains/1009244746 var2671 (cast-from-String-to-String "-"))) ; Statement: $z1 = virtualinvoke r0.<java.lang.String: boolean contains(java.lang.CharSequence)>("-") 
 ; Statement: if $z1 == 0 goto $z2 = 0 
(assert (= (ite var505 1 0) 0)) ; Cond: $z1 == 0 
(define-const var121 Bool (ite (= 1 0) true false)) ; Statement: $z2 = 0 
(assert true) ; Non Conditional
 ; Statement: return $z2 
(check-sat)
; {contains/1009244746=([java.lang.String, java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence)}
; {var2671=r0, var364=null_type, var3116=$z0, var505=$z1, var121=$z2}
; {r0=var2671, null_type=var364, $z0=var3116, $z1=var505, $z2=var121}
;seq <java.lang.String: boolean contains(java.lang.CharSequence)>;	<java.lang.String: boolean contains(java.lang.CharSequence)>
;cnt {"<java.lang.String: boolean contains(java.lang.CharSequence)>": 2}
;stmts r0 := @parameter0: java.lang.String;	$z0 = virtualinvoke r0.<java.lang.String: boolean contains(java.lang.CharSequence)>("*");	if $z0 != 0 goto $z2 = 1;	$z1 = virtualinvoke r0.<java.lang.String: boolean contains(java.lang.CharSequence)>("-");	if $z1 == 0 goto $z2 = 0;	$z2 = 0;	return $z2
;block_num 4