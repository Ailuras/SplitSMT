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

(declare-sort var360 0)
(declare-sort var1080 0)
(declare-sort var3160 0)
(declare-sort var2948 0)
(declare-sort var3889 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameterTypes/827748249 (var1080) (Array Int ClassObject))
(declare-fun var3160-init () var3160)
(declare-fun <init>/-201242697 (var3160) void)
(declare-fun getLength-Arr-ClassObject-1 ((Array Int ClassObject)) Int)
(declare-fun var2948_size/-1594421051 (var2948) Int)
(declare-fun cast-from-var3160-to-var2948 (var3160) var2948)
(declare-fun var3889-init () var3889)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun type/-670994832 (var360) ClassObject)
(declare-fun getName/-1958580599 (ClassObject) String)
(declare-fun getName/1227988463 (var1080) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1092629202 (var3889 String) void)
(declare-const null-var360 var360)
(declare-const null-var1080 var1080)
(declare-const var1636 var360) ; Statement: r7 := @this: org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator 
(assert (not (= var1636 null-var360)))
(declare-const var1181 var1080) ; Statement: r0 := @parameter0: java.lang.reflect.Method 
(assert (not (= var1181 null-var1080)))
(assert true)
(define-const var3200 (Array Int ClassObject) (getParameterTypes/827748249 var1181)) ; Statement: r1 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.Class[] getParameterTypes()>() 
(define-const var774 var3160 var3160-init) ; Statement: $r2 = new java.util.HashMap 
(assert true)
;(assert (<init>/-201242697 var774)) ; Statement: specialinvoke $r2.<java.util.HashMap: void <init>()>() 

(declare-const var774!1 var3160)
(define-const var2751 Int 0) ; Statement: i11 = 0 
(assert true) ; Non Conditional
(define-const var1845 Int (getLength-Arr-ClassObject-1 var3200)) ; Statement: $i0 = lengthof r1 
 ; Statement: if i11 >= $i0 goto $i1 = interfaceinvoke $r2.<java.util.Map: int size()>() 
(assert (>= var2751 var1845)) ; Cond: i11 >= $i0 
(define-const var42 Int (var2948_size/-1594421051 (cast-from-var3160-to-var2948 var774!1))) ; Statement: $i1 = interfaceinvoke $r2.<java.util.Map: int size()>() 
 ; Statement: if $i1 > 0 goto $r3 = interfaceinvoke $r2.<java.util.Map: java.lang.Object get(java.lang.Object)>("getUrl") 
(assert (not (> var42 0))) ; Negate: Cond: $i1 > 0  
(define-const var3794 var3889 var3889-init) ; Statement: $r18 = new java.lang.IllegalStateException 
(define-const var2813 String String-init) ; Statement: $r19 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2813)) ; Statement: specialinvoke $r19.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2813!1 String)
(assert (= var2813!1 ""))
(assert true)
(define-const var1927 String (append/672562846 var2813!1 "Failed to create adaptive class for interface ")) ; Statement: $r22 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to create adaptive class for interface ") 
(declare-const var2813!2 String)
(assert (= var2813!2 (str.++ var2813!1 "Failed to create adaptive class for interface ")))
(define-const var2382 ClassObject (type/-670994832 var1636)) ; Statement: $r20 = r7.<org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator: java.lang.Class type> 
(assert true)
(define-const var606 String (getName/-1958580599 var2382)) ; Statement: $r21 = virtualinvoke $r20.<java.lang.Class: java.lang.String getName()>() 
(assert true)
(define-const var612 String (append/672562846 var1927 var606)) ; Statement: $r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r21) 
(declare-const var1927!1 String)
(assert (= var1927!1 (str.++ var1927 var606)))
(assert true)
(define-const var717 String (append/672562846 var612 ": not found url parameter or url attribute in parameters of method ")) ; Statement: $r25 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(": not found url parameter or url attribute in parameters of method ") 
(declare-const var612!1 String)
(assert (= var612!1 (str.++ var612 ": not found url parameter or url attribute in parameters of method ")))
(assert true)
(define-const var2292 String (getName/1227988463 var1181)) ; Statement: $r24 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.String getName()>() 
(assert true)
(define-const var1679 String (append/672562846 var717 var2292)) ; Statement: $r26 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r24) 
(declare-const var717!1 String)
(assert (= var717!1 (str.++ var717 var2292)))
(assert true)
(define-const var2759 String (toString/-2075883882 var1679)) ; Statement: $r27 = virtualinvoke $r26.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1092629202 var3794 var2759)) ; Statement: specialinvoke $r18.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r27) 

(declare-const var3794!1 var3889)
(declare-const var2759!1 String)
 ; Statement: throw $r18 
(check-sat)
; {getParameterTypes/827748249=([java.lang.reflect.Method], java.lang.Class[]), var3160-init=([], java.util.HashMap), <init>/-201242697=([java.util.HashMap], void), getLength-Arr-ClassObject-1=([java.lang.Class[]], int), var2948_size/-1594421051=([java.util.Map], int), cast-from-var3160-to-var2948=([java.util.HashMap], java.util.Map), var3889-init=([], java.lang.IllegalStateException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), type/-670994832=([org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator], java.lang.Class), getName/-1958580599=([java.lang.Class], java.lang.String), getName/1227988463=([java.lang.reflect.Method], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1092629202=([java.lang.IllegalStateException, java.lang.String], void)}
; {var360=org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator, var1636=r7, var1080=java.lang.reflect.Method, var1181=r0, var3200=r1, var3160=java.util.HashMap, var774=$r2, var2751=i11, var1845=$i0, var2948=java.util.Map, var42=$i1, var3889=java.lang.IllegalStateException, var3794=$r18, var2813=$r19, var1927=$r22, var2382=$r20, var606=$r21, var612=$r23, var717=$r25, var2292=$r24, var1679=$r26, var2759=$r27}
; {org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator=var360, r7=var1636, java.lang.reflect.Method=var1080, r0=var1181, r1=var3200, java.util.HashMap=var3160, $r2=var774, i11=var2751, $i0=var1845, java.util.Map=var2948, $i1=var42, java.lang.IllegalStateException=var3889, $r18=var3794, $r19=var2813, $r22=var1927, $r20=var2382, $r21=var606, $r23=var612, $r25=var717, $r24=var2292, $r26=var1679, $r27=var2759}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r7 := @this: org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator;	r0 := @parameter0: java.lang.reflect.Method;	r1 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.Class[] getParameterTypes()>();	$r2 = new java.util.HashMap;	specialinvoke $r2.<java.util.HashMap: void <init>()>();	i11 = 0;	$i0 = lengthof r1;	if i11 >= $i0 goto $i1 = interfaceinvoke $r2.<java.util.Map: int size()>();	$i1 = interfaceinvoke $r2.<java.util.Map: int size()>();	if $i1 > 0 goto $r3 = interfaceinvoke $r2.<java.util.Map: java.lang.Object get(java.lang.Object)>("getUrl");	$r18 = new java.lang.IllegalStateException;	$r19 = new java.lang.StringBuilder;	specialinvoke $r19.<java.lang.StringBuilder: void <init>()>();	$r22 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to create adaptive class for interface ");	$r20 = r7.<org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator: java.lang.Class type>;	$r21 = virtualinvoke $r20.<java.lang.Class: java.lang.String getName()>();	$r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r21);	$r25 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(": not found url parameter or url attribute in parameters of method ");	$r24 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.String getName()>();	$r26 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r24);	$r27 = virtualinvoke $r26.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r18.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r27);	throw $r18
;block_num 4