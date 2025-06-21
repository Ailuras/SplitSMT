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

(declare-sort var3563 0)
(declare-sort var59 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getName/1227988463 (var59) String)
(define-fun startsWith/-1785782452 ((s String) (prefix String)) Bool (str.prefixof prefix s))
(declare-const null-var3563 var3563)
(declare-const null-var59 var59)
(declare-const var2255 var3563) ; Statement: r3 := @this: org.apache.dubbo.common.extension.ExtensionLoader 
(assert (not (= var2255 null-var3563)))
(declare-const var1679 var59) ; Statement: r0 := @parameter0: java.lang.reflect.Method 
(assert (not (= var1679 null-var59)))
(assert true)
(define-const var433 String (getName/1227988463 var1679)) ; Statement: $r1 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.String getName()>() 
(assert true)
(define-const var1116 Bool (startsWith/-1785782452 var433 "set")) ; Statement: $z0 = virtualinvoke $r1.<java.lang.String: boolean startsWith(java.lang.String)>("set") 
 ; Statement: if $z0 == 0 goto $z2 = 0 
(assert (= (ite var1116 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2913 Bool (ite (= 1 0) true false)) ; Statement: $z2 = 0 
(assert true) ; Non Conditional
 ; Statement: return $z2 
(check-sat)
; {getName/1227988463=([java.lang.reflect.Method], java.lang.String), startsWith/-1785782452=([java.lang.String, java.lang.String], boolean)}
; {var3563=org.apache.dubbo.common.extension.ExtensionLoader, var2255=r3, var59=java.lang.reflect.Method, var1679=r0, var433=$r1, var1116=$z0, var2913=$z2}
; {org.apache.dubbo.common.extension.ExtensionLoader=var3563, r3=var2255, java.lang.reflect.Method=var59, r0=var1679, $r1=var433, $z0=var1116, $z2=var2913}
;seq <java.lang.String: boolean startsWith(java.lang.String)>
;cnt {"<java.lang.String: boolean startsWith(java.lang.String)>": 1}
;stmts r3 := @this: org.apache.dubbo.common.extension.ExtensionLoader;	r0 := @parameter0: java.lang.reflect.Method;	$r1 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.String getName()>();	$z0 = virtualinvoke $r1.<java.lang.String: boolean startsWith(java.lang.String)>("set");	if $z0 == 0 goto $z2 = 0;	$z2 = 0;	return $z2
;block_num 3