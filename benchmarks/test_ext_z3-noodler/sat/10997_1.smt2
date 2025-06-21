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

(declare-sort var1309 0)
(declare-sort var1350 0)
(declare-sort var1533 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var1533!class ClassObject)
(declare-fun getName/1227988463 (var1350) String)
(declare-fun getParameterTypes/827748249 (var1350) (Array Int ClassObject))
(define-fun startsWith/-1785782452 ((s String) (prefix String)) Bool (str.prefixof prefix s))
(declare-fun getLength-Arr-ClassObject-1 ((Array Int ClassObject)) Int)
(declare-fun isAssignableFrom/-1028998700 (ClassObject ClassObject) Bool)
(declare-const null-var1309 var1309)
(declare-const null-var1350 var1350)
(declare-const var3171 var1309) ; Statement: r5 := @this: org.apache.dubbo.metadata.definition.protobuf.ProtobufTypeBuilder 
(assert (not (= var3171 null-var1309)))
(declare-const var3591 var1350) ; Statement: r0 := @parameter0: java.lang.reflect.Method 
(assert (not (= var3591 null-var1350)))
(assert true)
(define-const var3869 String (getName/1227988463 var3591)) ; Statement: r1 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.String getName()>() 
(assert true)
(define-const var2365 (Array Int ClassObject) (getParameterTypes/827748249 var3591)) ; Statement: r2 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.Class[] getParameterTypes()>() 
(assert true)
(define-const var3623 Bool (startsWith/-1785782452 var3869 "putAll")) ; Statement: $z0 = virtualinvoke r1.<java.lang.String: boolean startsWith(java.lang.String)>("putAll") 
 ; Statement: if $z0 == 0 goto $z2 = 0 
(assert (not (= (ite var3623 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var950 Int (getLength-Arr-ClassObject-1 var2365)) ; Statement: $i0 = lengthof r2 
 ; Statement: if $i0 != 1 goto $z2 = 0 
(assert (not (not (= var950 1)))) ; Negate: Cond: $i0 != 1  
(define-const var1635 ClassObject var1533!class) ; Statement: $r4 = class "Ljava/util/Map;" 
(define-const var155 ClassObject (select var2365 0)) ; Statement: $r3 = r2[0] 
(assert true)
(define-const var2048 Bool (isAssignableFrom/-1028998700 var1635 var155)) ; Statement: $z1 = virtualinvoke $r4.<java.lang.Class: boolean isAssignableFrom(java.lang.Class)>($r3) 
 ; Statement: if $z1 == 0 goto $z2 = 0 
(assert (= (ite var2048 1 0) 0)) ; Cond: $z1 == 0 
(define-const var1495 Bool (ite (= 1 0) true false)) ; Statement: $z2 = 0 
(assert true) ; Non Conditional
 ; Statement: return $z2 
(check-sat)
; {getName/1227988463=([java.lang.reflect.Method], java.lang.String), getParameterTypes/827748249=([java.lang.reflect.Method], java.lang.Class[]), startsWith/-1785782452=([java.lang.String, java.lang.String], boolean), getLength-Arr-ClassObject-1=([java.lang.Class[]], int), isAssignableFrom/-1028998700=([java.lang.Class, java.lang.Class], boolean)}
; {var1309=org.apache.dubbo.metadata.definition.protobuf.ProtobufTypeBuilder, var3171=r5, var1350=java.lang.reflect.Method, var3591=r0, var3869=r1, var2365=r2, var3623=$z0, var950=$i0, var1533=java.util.Map, var1635=$r4, var155=$r3, var2048=$z1, var1495=$z2}
; {org.apache.dubbo.metadata.definition.protobuf.ProtobufTypeBuilder=var1309, r5=var3171, java.lang.reflect.Method=var1350, r0=var3591, r1=var3869, r2=var2365, $z0=var3623, $i0=var950, java.util.Map=var1533, $r4=var1635, $r3=var155, $z1=var2048, $z2=var1495}
;seq <java.lang.String: boolean startsWith(java.lang.String)>
;cnt {"<java.lang.String: boolean startsWith(java.lang.String)>": 1}
;stmts r5 := @this: org.apache.dubbo.metadata.definition.protobuf.ProtobufTypeBuilder;	r0 := @parameter0: java.lang.reflect.Method;	r1 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.String getName()>();	r2 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.Class[] getParameterTypes()>();	$z0 = virtualinvoke r1.<java.lang.String: boolean startsWith(java.lang.String)>("putAll");	if $z0 == 0 goto $z2 = 0;	$i0 = lengthof r2;	if $i0 != 1 goto $z2 = 0;	$r4 = class "Ljava/util/Map;";	$r3 = r2[0];	$z1 = virtualinvoke $r4.<java.lang.Class: boolean isAssignableFrom(java.lang.Class)>($r3);	if $z1 == 0 goto $z2 = 0;	$z2 = 0;	return $z2
;block_num 5