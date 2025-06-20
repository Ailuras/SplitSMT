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

(declare-sort var1875 0)
(declare-sort var1387 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getName/1227988463 (var1387) String)
(declare-fun getParameterTypes/827748249 (var1387) (Array Int ClassObject))
(define-fun startsWith/-1785782452 ((s String) (prefix String)) Bool (str.prefixof prefix s))
(declare-fun getLength-Arr-ClassObject-1 ((Array Int ClassObject)) Int)
(declare-const null-var1875 var1875)
(declare-const null-var1387 var1387)
(declare-const var1841 var1875) ; Statement: r5 := @this: org.apache.dubbo.metadata.definition.protobuf.ProtobufTypeBuilder 
(assert (not (= var1841 null-var1875)))
(declare-const var3642 var1387) ; Statement: r0 := @parameter0: java.lang.reflect.Method 
(assert (not (= var3642 null-var1387)))
(assert true)
(define-const var2301 String (getName/1227988463 var3642)) ; Statement: r1 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.String getName()>() 
(assert true)
(define-const var2665 (Array Int ClassObject) (getParameterTypes/827748249 var3642)) ; Statement: r2 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.Class[] getParameterTypes()>() 
(assert true)
(define-const var2391 Bool (startsWith/-1785782452 var2301 "putAll")) ; Statement: $z0 = virtualinvoke r1.<java.lang.String: boolean startsWith(java.lang.String)>("putAll") 
 ; Statement: if $z0 == 0 goto $z2 = 0 
(assert (not (= (ite var2391 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var3483 Int (getLength-Arr-ClassObject-1 var2665)) ; Statement: $i0 = lengthof r2 
 ; Statement: if $i0 != 1 goto $z2 = 0 
(assert (not (= var3483 1))) ; Cond: $i0 != 1 
(define-const var741 Bool (ite (= 1 0) true false)) ; Statement: $z2 = 0 
(assert true) ; Non Conditional
 ; Statement: return $z2 
(check-sat)
; {getName/1227988463=([java.lang.reflect.Method], java.lang.String), getParameterTypes/827748249=([java.lang.reflect.Method], java.lang.Class[]), startsWith/-1785782452=([java.lang.String, java.lang.String], boolean), getLength-Arr-ClassObject-1=([java.lang.Class[]], int)}
; {var1875=org.apache.dubbo.metadata.definition.protobuf.ProtobufTypeBuilder, var1841=r5, var1387=java.lang.reflect.Method, var3642=r0, var2301=r1, var2665=r2, var2391=$z0, var3483=$i0, var741=$z2}
; {org.apache.dubbo.metadata.definition.protobuf.ProtobufTypeBuilder=var1875, r5=var1841, java.lang.reflect.Method=var1387, r0=var3642, r1=var2301, r2=var2665, $z0=var2391, $i0=var3483, $z2=var741}
;seq <java.lang.String: boolean startsWith(java.lang.String)>
;cnt {"<java.lang.String: boolean startsWith(java.lang.String)>": 1}
;stmts r5 := @this: org.apache.dubbo.metadata.definition.protobuf.ProtobufTypeBuilder;	r0 := @parameter0: java.lang.reflect.Method;	r1 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.String getName()>();	r2 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.Class[] getParameterTypes()>();	$z0 = virtualinvoke r1.<java.lang.String: boolean startsWith(java.lang.String)>("putAll");	if $z0 == 0 goto $z2 = 0;	$i0 = lengthof r2;	if $i0 != 1 goto $z2 = 0;	$z2 = 0;	return $z2
;block_num 4