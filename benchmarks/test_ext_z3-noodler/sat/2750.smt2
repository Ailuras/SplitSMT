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

(declare-sort var1242 0)
(declare-sort var2268 0)
(declare-sort var114 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun endsWith/985337093 ((s String) (suffix String)) Bool (str.suffixof suffix s))
(declare-const null-var1242 var1242)
(declare-const null-String String)
(declare-const null-var114 var114)
(declare-const var2723 var1242) ; Statement: r0 := @parameter0: java.util.Map 
(assert (not (= var2723 null-var1242)))
(declare-const var3319 String) ; Statement: r12 := @parameter1: java.lang.String 
(assert (not (= var3319 null-String)))
(assert true)
(define-const var1633 Bool (endsWith/985337093 var3319 ".")) ; Statement: $z0 = virtualinvoke r12.<java.lang.String: boolean endsWith(java.lang.String)>(".") 
 ; Statement: if $z0 != 0 goto entermonitor r0 
(assert (not (= (ite var1633 1 0) 0))) ; Cond: $z0 != 0 
 ; Statement: entermonitor r0 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var3974 var114) ; Statement: $r11 := @caughtexception 
(assert (not (= var3974 null-var114)))
(assert true) ; Non Conditional
 ; Statement: exitmonitor r0 
(assert true) ; Non Conditional
 ; Statement: throw $r11 
(check-sat)
; {endsWith/985337093=([java.lang.String, java.lang.String], boolean)}
; {var1242=java.util.Map, var2723=r0, var3319=r12, var2268=null_type, var1633=$z0, var114=java.lang.Throwable, var3974=$r11}
; {java.util.Map=var1242, r0=var2723, r12=var3319, null_type=var2268, $z0=var1633, java.lang.Throwable=var114, $r11=var3974}
;seq <java.lang.String: boolean endsWith(java.lang.String)>
;cnt {"<java.lang.String: boolean endsWith(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.util.Map;	r12 := @parameter1: java.lang.String;	$z0 = virtualinvoke r12.<java.lang.String: boolean endsWith(java.lang.String)>(".");	if $z0 != 0 goto entermonitor r0;	entermonitor r0;	$r11 := @caughtexception;	exitmonitor r0;	throw $r11
;block_num 5