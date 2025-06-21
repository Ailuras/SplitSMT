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

(declare-sort var3021 0)
(declare-sort var1746 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const null-var3021 var3021)
(declare-const null-String String)
(declare-const null-__Array__Int__var3021__ (Array Int var3021))
(declare-const var1593 var3021) ; Statement: r0 := @parameter0: java.lang.Object 
(assert (not (= var1593 null-var3021)))
(declare-const var609 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var609 null-String)))
(declare-const var3331 (Array Int var3021)) ; Statement: r3 := @parameter2: java.lang.Object[] 
(assert (not (= var3331 null-__Array__Int__var3021__)))
 ; Statement: if r0 != null goto return 
(assert (not (= var1593 null-var3021))) ; Cond: r0 != null 
 ; Statement: return 
(check-sat)
; {}
; {var3021=java.lang.Object, var1593=r0, var609=r2, var1746=null_type, var3331=r3}
; {java.lang.Object=var3021, r0=var1593, r2=var609, null_type=var1746, r3=var3331}
;seq 
;cnt {}
;stmts r0 := @parameter0: java.lang.Object;	r2 := @parameter1: java.lang.String;	r3 := @parameter2: java.lang.Object[];	if r0 != null goto return;	return
;block_num 2