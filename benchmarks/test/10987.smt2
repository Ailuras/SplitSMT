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

(declare-sort var1436 0)
(declare-sort var372 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getName/1227988463 (var372) String)
(declare-fun getParameterTypes/827748249 (var372) (Array Int ClassObject))
(define-fun startsWith/-1785782452 ((s String) (prefix String)) Bool (str.prefixof prefix s))
(declare-const null-var1436 var1436)
(declare-const null-var372 var372)
(declare-const var1020 var1436) ; Statement: r5 := @this: org.apache.dubbo.metadata.definition.protobuf.ProtobufTypeBuilder 
(assert (not (= var1020 null-var1436)))
(declare-const var897 var372) ; Statement: r0 := @parameter0: java.lang.reflect.Method 
(assert (not (= var897 null-var372)))
(assert true)
(define-const var411 String (getName/1227988463 var897)) ; Statement: r1 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.String getName()>() 
(assert true)
(define-const var2159 (Array Int ClassObject) (getParameterTypes/827748249 var897)) ; Statement: r2 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.Class[] getParameterTypes()>() 
(assert true)
(define-const var3315 Bool (startsWith/-1785782452 var411 "putAll")) ; Statement: $z0 = virtualinvoke r1.<java.lang.String: boolean startsWith(java.lang.String)>("putAll") 
 ; Statement: if $z0 == 0 goto $z2 = 0 
(assert (= (ite var3315 1 0) 0)) ; Cond: $z0 == 0 
(define-const var728 Bool (ite (= 1 0) true false)) ; Statement: $z2 = 0 
(assert true) ; Non Conditional
 ; Statement: return $z2 
(check-sat)
; {getName/1227988463=([java.lang.reflect.Method], java.lang.String), getParameterTypes/827748249=([java.lang.reflect.Method], java.lang.Class[]), startsWith/-1785782452=([java.lang.String, java.lang.String], boolean)}
; {var1436=org.apache.dubbo.metadata.definition.protobuf.ProtobufTypeBuilder, var1020=r5, var372=java.lang.reflect.Method, var897=r0, var411=r1, var2159=r2, var3315=$z0, var728=$z2}
; {org.apache.dubbo.metadata.definition.protobuf.ProtobufTypeBuilder=var1436, r5=var1020, java.lang.reflect.Method=var372, r0=var897, r1=var411, r2=var2159, $z0=var3315, $z2=var728}
;seq <java.lang.String: boolean startsWith(java.lang.String)>
;cnt {"<java.lang.String: boolean startsWith(java.lang.String)>": 1}
;stmts r5 := @this: org.apache.dubbo.metadata.definition.protobuf.ProtobufTypeBuilder;	r0 := @parameter0: java.lang.reflect.Method;	r1 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.String getName()>();	r2 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.Class[] getParameterTypes()>();	$z0 = virtualinvoke r1.<java.lang.String: boolean startsWith(java.lang.String)>("putAll");	if $z0 == 0 goto $z2 = 0;	$z2 = 0;	return $z2
;block_num 3