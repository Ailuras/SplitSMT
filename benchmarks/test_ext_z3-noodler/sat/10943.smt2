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

(declare-sort var373 0)
(declare-sort var1254 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getName/1227988463 (var1254) String)
(declare-fun getReturnType/-1494237887 (var1254) ClassObject)
(define-fun startsWith/-1785782452 ((s String) (prefix String)) Bool (str.prefixof prefix s))
(declare-const null-var373 var373)
(declare-const null-var1254 var1254)
(declare-const var2092 var373) ; Statement: r4 := @this: org.apache.dubbo.metadata.definition.protobuf.ProtobufTypeBuilder 
(assert (not (= var2092 null-var373)))
(declare-const var3049 var1254) ; Statement: r0 := @parameter0: java.lang.reflect.Method 
(assert (not (= var3049 null-var1254)))
(assert true)
(define-const var3391 String (getName/1227988463 var3049)) ; Statement: r1 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.String getName()>() 
(assert true)
(define-const var38 ClassObject (getReturnType/-1494237887 var3049)) ; Statement: r2 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.Class getReturnType()>() 
(assert true)
(define-const var2377 Bool (startsWith/-1785782452 var3391 "get")) ; Statement: $z0 = virtualinvoke r1.<java.lang.String: boolean startsWith(java.lang.String)>("get") 
 ; Statement: if $z0 == 0 goto return 0 
(assert (= (ite var2377 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return 0 
(check-sat)
; {getName/1227988463=([java.lang.reflect.Method], java.lang.String), getReturnType/-1494237887=([java.lang.reflect.Method], java.lang.Class), startsWith/-1785782452=([java.lang.String, java.lang.String], boolean)}
; {var373=org.apache.dubbo.metadata.definition.protobuf.ProtobufTypeBuilder, var2092=r4, var1254=java.lang.reflect.Method, var3049=r0, var3391=r1, var38=r2, var2377=$z0}
; {org.apache.dubbo.metadata.definition.protobuf.ProtobufTypeBuilder=var373, r4=var2092, java.lang.reflect.Method=var1254, r0=var3049, r1=var3391, r2=var38, $z0=var2377}
;seq <java.lang.String: boolean startsWith(java.lang.String)>
;cnt {"<java.lang.String: boolean startsWith(java.lang.String)>": 1}
;stmts r4 := @this: org.apache.dubbo.metadata.definition.protobuf.ProtobufTypeBuilder;	r0 := @parameter0: java.lang.reflect.Method;	r1 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.String getName()>();	r2 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.Class getReturnType()>();	$z0 = virtualinvoke r1.<java.lang.String: boolean startsWith(java.lang.String)>("get");	if $z0 == 0 goto return 0;	return 0
;block_num 2