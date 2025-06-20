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

(declare-sort var421 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getLength-Arr-String-1 ((Array Int String)) Int)
(declare-const null-String String)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const null-Bool Bool)
(declare-const var3438 String) ; Statement: r3 := @parameter0: java.lang.String 
(assert (not (= var3438 null-String)))
(declare-const var3127 (Array Int String)) ; Statement: r0 := @parameter1: java.lang.String[] 
(assert (not (= var3127 null-__Array__Int__String__)))
(declare-const var3400 Bool) ; Statement: z0 := @parameter2: boolean 
(assert (not (= var3400 null-Bool)))
 ; Statement: if z0 != 0 goto $i0 = lengthof r0 
(assert (not (= (ite var3400 1 0) 0))) ; Cond: z0 != 0 
(define-const var2471 Int (getLength-Arr-String-1 var3127)) ; Statement: $i0 = lengthof r0 
 ; Statement: if $i0 == 4 goto return 
(assert (= var2471 4)) ; Cond: $i0 == 4 
 ; Statement: return 
(check-sat)
; {getLength-Arr-String-1=([java.lang.String[]], int)}
; {var3438=r3, var421=null_type, var3127=r0, var3400=z0, var2471=$i0}
; {r3=var3438, null_type=var421, r0=var3127, z0=var3400, $i0=var2471}
;seq 
;cnt {}
;stmts r3 := @parameter0: java.lang.String;	r0 := @parameter1: java.lang.String[];	z0 := @parameter2: boolean;	if z0 != 0 goto $i0 = lengthof r0;	$i0 = lengthof r0;	if $i0 == 4 goto return;	return
;block_num 3