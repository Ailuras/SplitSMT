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

(declare-sort var1558 0)
(declare-sort var1879 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getName/1227988463 (var1879) String)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(declare-const null-var1558 var1558)
(declare-const null-var1879 var1879)
(declare-const var1948 var1558) ; Statement: r10 := @this: org.apache.dubbo.common.extension.ExtensionLoader 
(assert (not (= var1948 null-var1558)))
(declare-const var303 var1879) ; Statement: r0 := @parameter0: java.lang.reflect.Method 
(assert (not (= var303 null-var1879)))
(assert true)
(define-const var1729 String (getName/1227988463 var303)) ; Statement: $r1 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.String getName()>() 
(assert true)
(define-const var548 Int (length/-134980193 var1729)) ; Statement: $i0 = virtualinvoke $r1.<java.lang.String: int length()>() 
 ; Statement: if $i0 <= 3 goto $r11 = "" 
(assert (<= var548 3)) ; Cond: $i0 <= 3 
(define-const var967 String "") ; Statement: $r11 = "" 
(assert true) ; Non Conditional
 ; Statement: return $r11 
(check-sat)
; {getName/1227988463=([java.lang.reflect.Method], java.lang.String), length/-134980193=([java.lang.String], int)}
; {var1558=org.apache.dubbo.common.extension.ExtensionLoader, var1948=r10, var1879=java.lang.reflect.Method, var303=r0, var1729=$r1, var548=$i0, var967=$r11}
; {org.apache.dubbo.common.extension.ExtensionLoader=var1558, r10=var1948, java.lang.reflect.Method=var1879, r0=var303, $r1=var1729, $i0=var548, $r11=var967}
;seq <java.lang.String: int length()>
;cnt {"<java.lang.String: int length()>": 1}
;stmts r10 := @this: org.apache.dubbo.common.extension.ExtensionLoader;	r0 := @parameter0: java.lang.reflect.Method;	$r1 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.String getName()>();	$i0 = virtualinvoke $r1.<java.lang.String: int length()>();	if $i0 <= 3 goto $r11 = "";	$r11 = "";	return $r11
;block_num 3