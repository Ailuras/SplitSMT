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

(declare-sort var1044 0)
(declare-sort var1628 0)
(declare-sort var262 0)
(declare-sort var92 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1628_getKey/-33423493 (var1628) var262)
(declare-fun cast-from-var262-to-var92 (var262) var92)
(declare-fun getName/1227988463 (var92) String)
(declare-const null-String String)
(declare-const null-var1628 var1628)
(declare-const var2057 String) ; Statement: r3 := @parameter0: java.lang.String 
(assert (not (= var2057 null-String)))
(declare-const var3899 var1628) ; Statement: r0 := @parameter1: java.util.Map$Entry 
(assert (not (= var3899 null-var1628)))
(define-const var1065 var262 (var1628_getKey/-33423493 var3899)) ; Statement: $r1 = interfaceinvoke r0.<java.util.Map$Entry: java.lang.Object getKey()>() 
(define-const var499 var92 (cast-from-var262-to-var92 var1065)) ; Statement: $r2 = (java.lang.reflect.Method) $r1 
(assert true)
(define-const var2911 String (getName/1227988463 var499)) ; Statement: $r4 = virtualinvoke $r2.<java.lang.reflect.Method: java.lang.String getName()>() 
(assert true)
(define-const var3235 Bool (= var2911 var2057)) ; Statement: $z0 = virtualinvoke $r4.<java.lang.String: boolean equals(java.lang.Object)>(r3) 
 ; Statement: return $z0 
(check-sat)
; {var1628_getKey/-33423493=([java.util.Map$Entry], java.lang.Object), cast-from-var262-to-var92=([java.lang.Object], java.lang.reflect.Method), getName/1227988463=([java.lang.reflect.Method], java.lang.String)}
; {var2057=r3, var1044=null_type, var1628=java.util.Map$Entry, var3899=r0, var262=java.lang.Object, var1065=$r1, var92=java.lang.reflect.Method, var499=$r2, var2911=$r4, var3235=$z0}
; {r3=var2057, null_type=var1044, java.util.Map$Entry=var1628, r0=var3899, java.lang.Object=var262, $r1=var1065, java.lang.reflect.Method=var92, $r2=var499, $r4=var2911, $z0=var3235}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r3 := @parameter0: java.lang.String;	r0 := @parameter1: java.util.Map$Entry;	$r1 = interfaceinvoke r0.<java.util.Map$Entry: java.lang.Object getKey()>();	$r2 = (java.lang.reflect.Method) $r1;	$r4 = virtualinvoke $r2.<java.lang.reflect.Method: java.lang.String getName()>();	$z0 = virtualinvoke $r4.<java.lang.String: boolean equals(java.lang.Object)>(r3);	return $z0
;block_num 1