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

(declare-sort var2449 0)
(declare-sort var583 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getName/1227988463 (var583) String)
(declare-fun getParameterTypes/827748249 (var583) (Array Int ClassObject))
(define-fun startsWith/-1785782452 ((s String) (prefix String)) Bool (str.prefixof prefix s))
(declare-const null-var2449 var2449)
(declare-const null-var583 var583)
(declare-const var1162 var2449) ; Statement: r14 := @this: org.apache.dubbo.metadata.definition.protobuf.ProtobufTypeBuilder 
(assert (not (= var1162 null-var2449)))
(declare-const var2713 var583) ; Statement: r0 := @parameter0: java.lang.reflect.Method 
(assert (not (= var2713 null-var583)))
(assert true)
(define-const var1911 String (getName/1227988463 var2713)) ; Statement: r1 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.String getName()>() 
(assert true)
(define-const var1916 (Array Int ClassObject) (getParameterTypes/827748249 var2713)) ; Statement: r2 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.Class[] getParameterTypes()>() 
(assert true)
(define-const var1240 Bool (startsWith/-1785782452 var1911 "set")) ; Statement: $z0 = virtualinvoke r1.<java.lang.String: boolean startsWith(java.lang.String)>("set") 
 ; Statement: if $z0 == 0 goto return 0 
(assert (= (ite var1240 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return 0 
(check-sat)
; {getName/1227988463=([java.lang.reflect.Method], java.lang.String), getParameterTypes/827748249=([java.lang.reflect.Method], java.lang.Class[]), startsWith/-1785782452=([java.lang.String, java.lang.String], boolean)}
; {var2449=org.apache.dubbo.metadata.definition.protobuf.ProtobufTypeBuilder, var1162=r14, var583=java.lang.reflect.Method, var2713=r0, var1911=r1, var1916=r2, var1240=$z0}
; {org.apache.dubbo.metadata.definition.protobuf.ProtobufTypeBuilder=var2449, r14=var1162, java.lang.reflect.Method=var583, r0=var2713, r1=var1911, r2=var1916, $z0=var1240}
;seq <java.lang.String: boolean startsWith(java.lang.String)>
;cnt {"<java.lang.String: boolean startsWith(java.lang.String)>": 1}
;stmts r14 := @this: org.apache.dubbo.metadata.definition.protobuf.ProtobufTypeBuilder;	r0 := @parameter0: java.lang.reflect.Method;	r1 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.String getName()>();	r2 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.Class[] getParameterTypes()>();	$z0 = virtualinvoke r1.<java.lang.String: boolean startsWith(java.lang.String)>("set");	if $z0 == 0 goto return 0;	return 0
;block_num 2