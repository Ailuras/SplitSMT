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

(declare-sort var1266 0)
(declare-sort var415 0)
(declare-sort var2509 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var2509!class ClassObject)
(declare-fun getName/1227988463 (var415) String)
(declare-fun getParameterTypes/827748249 (var415) (Array Int ClassObject))
(define-fun startsWith/-1785782452 ((s String) (prefix String)) Bool (str.prefixof prefix s))
(declare-fun getLength-Arr-ClassObject-1 ((Array Int ClassObject)) Int)
(declare-fun isAssignableFrom/-1028998700 (ClassObject ClassObject) Bool)
(declare-const null-var1266 var1266)
(declare-const null-var415 var415)
(declare-const var2573 var1266) ; Statement: r5 := @this: org.apache.dubbo.metadata.definition.protobuf.ProtobufTypeBuilder 
(assert (not (= var2573 null-var1266)))
(declare-const var2731 var415) ; Statement: r0 := @parameter0: java.lang.reflect.Method 
(assert (not (= var2731 null-var415)))
(assert true)
(define-const var3725 String (getName/1227988463 var2731)) ; Statement: r1 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.String getName()>() 
(assert true)
(define-const var3443 (Array Int ClassObject) (getParameterTypes/827748249 var2731)) ; Statement: r2 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.Class[] getParameterTypes()>() 
(assert true)
(define-const var2829 Bool (startsWith/-1785782452 var3725 "putAll")) ; Statement: $z0 = virtualinvoke r1.<java.lang.String: boolean startsWith(java.lang.String)>("putAll") 
 ; Statement: if $z0 == 0 goto $z2 = 0 
(assert (not (= (ite var2829 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var3685 Int (getLength-Arr-ClassObject-1 var3443)) ; Statement: $i0 = lengthof r2 
 ; Statement: if $i0 != 1 goto $z2 = 0 
(assert (not (not (= var3685 1)))) ; Negate: Cond: $i0 != 1  
(define-const var321 ClassObject var2509!class) ; Statement: $r4 = class "Ljava/util/Map;" 
(define-const var510 ClassObject (select var3443 0)) ; Statement: $r3 = r2[0] 
(assert true)
(define-const var1998 Bool (isAssignableFrom/-1028998700 var321 var510)) ; Statement: $z1 = virtualinvoke $r4.<java.lang.Class: boolean isAssignableFrom(java.lang.Class)>($r3) 
 ; Statement: if $z1 == 0 goto $z2 = 0 
(assert (not (= (ite var1998 1 0) 0))) ; Negate: Cond: $z1 == 0  
(define-const var2175 Bool (ite (= 1 1) true false)) ; Statement: $z2 = 1 
 ; Statement: goto [?= return $z2] 
(assert true) ; Non Conditional
 ; Statement: return $z2 
(check-sat)
; {getName/1227988463=([java.lang.reflect.Method], java.lang.String), getParameterTypes/827748249=([java.lang.reflect.Method], java.lang.Class[]), startsWith/-1785782452=([java.lang.String, java.lang.String], boolean), getLength-Arr-ClassObject-1=([java.lang.Class[]], int), isAssignableFrom/-1028998700=([java.lang.Class, java.lang.Class], boolean)}
; {var1266=org.apache.dubbo.metadata.definition.protobuf.ProtobufTypeBuilder, var2573=r5, var415=java.lang.reflect.Method, var2731=r0, var3725=r1, var3443=r2, var2829=$z0, var3685=$i0, var2509=java.util.Map, var321=$r4, var510=$r3, var1998=$z1, var2175=$z2}
; {org.apache.dubbo.metadata.definition.protobuf.ProtobufTypeBuilder=var1266, r5=var2573, java.lang.reflect.Method=var415, r0=var2731, r1=var3725, r2=var3443, $z0=var2829, $i0=var3685, java.util.Map=var2509, $r4=var321, $r3=var510, $z1=var1998, $z2=var2175}
;seq <java.lang.String: boolean startsWith(java.lang.String)>
;cnt {"<java.lang.String: boolean startsWith(java.lang.String)>": 1}
;stmts r5 := @this: org.apache.dubbo.metadata.definition.protobuf.ProtobufTypeBuilder;	r0 := @parameter0: java.lang.reflect.Method;	r1 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.String getName()>();	r2 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.Class[] getParameterTypes()>();	$z0 = virtualinvoke r1.<java.lang.String: boolean startsWith(java.lang.String)>("putAll");	if $z0 == 0 goto $z2 = 0;	$i0 = lengthof r2;	if $i0 != 1 goto $z2 = 0;	$r4 = class "Ljava/util/Map;";	$r3 = r2[0];	$z1 = virtualinvoke $r4.<java.lang.Class: boolean isAssignableFrom(java.lang.Class)>($r3);	if $z1 == 0 goto $z2 = 0;	$z2 = 1;	goto [?= return $z2];	return $z2
;block_num 5