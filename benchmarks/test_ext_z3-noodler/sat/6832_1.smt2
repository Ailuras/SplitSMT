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

(declare-sort var1228 0)
(declare-sort var3125 0)
(declare-sort var2853 0)
(declare-sort var2368 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3125_getKey/-33423493 (var3125) var2853)
(declare-fun cast-from-var2853-to-var2368 (var2853) var2368)
(declare-fun getName/1227988463 (var2368) String)
(declare-const null-String String)
(declare-const null-var3125 var3125)
(declare-const var629 String) ; Statement: r3 := @parameter0: java.lang.String 
(assert (not (= var629 null-String)))
(declare-const var649 var3125) ; Statement: r0 := @parameter1: java.util.Map$Entry 
(assert (not (= var649 null-var3125)))
(define-const var987 var2853 (var3125_getKey/-33423493 var649)) ; Statement: $r1 = interfaceinvoke r0.<java.util.Map$Entry: java.lang.Object getKey()>() 
(define-const var3346 var2368 (cast-from-var2853-to-var2368 var987)) ; Statement: $r2 = (java.lang.reflect.Method) $r1 
(assert true)
(define-const var596 String (getName/1227988463 var3346)) ; Statement: $r4 = virtualinvoke $r2.<java.lang.reflect.Method: java.lang.String getName()>() 
(assert true)
(define-const var504 Bool (= var596 var629)) ; Statement: $z0 = virtualinvoke $r4.<java.lang.String: boolean equals(java.lang.Object)>(r3) 
 ; Statement: return $z0 
(check-sat)
; {var3125_getKey/-33423493=([java.util.Map$Entry], java.lang.Object), cast-from-var2853-to-var2368=([java.lang.Object], java.lang.reflect.Method), getName/1227988463=([java.lang.reflect.Method], java.lang.String)}
; {var629=r3, var1228=null_type, var3125=java.util.Map$Entry, var649=r0, var2853=java.lang.Object, var987=$r1, var2368=java.lang.reflect.Method, var3346=$r2, var596=$r4, var504=$z0}
; {r3=var629, null_type=var1228, java.util.Map$Entry=var3125, r0=var649, java.lang.Object=var2853, $r1=var987, java.lang.reflect.Method=var2368, $r2=var3346, $r4=var596, $z0=var504}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r3 := @parameter0: java.lang.String;	r0 := @parameter1: java.util.Map$Entry;	$r1 = interfaceinvoke r0.<java.util.Map$Entry: java.lang.Object getKey()>();	$r2 = (java.lang.reflect.Method) $r1;	$r4 = virtualinvoke $r2.<java.lang.reflect.Method: java.lang.String getName()>();	$z0 = virtualinvoke $r4.<java.lang.String: boolean equals(java.lang.Object)>(r3);	return $z0
;block_num 1