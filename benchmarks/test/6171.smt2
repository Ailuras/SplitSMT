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

(declare-sort var1505 0)
(declare-sort var3616 0)
(declare-sort var2549 0)
(declare-sort var2757 0)
(declare-sort var3816 0)
(declare-sort var1767 0)
(declare-sort var1843 0)
(declare-sort var3678 0)
(declare-sort var3253 0)
(declare-sort var1921 0)
(declare-sort var2755 0)
(declare-sort var854 0)
(declare-sort var1476 0)
(declare-sort var3034 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun <init>/-279557996 (var2549) void)
(declare-fun cast-from-var1505-to-var2549 (var1505) var2549)
(declare-fun var2757-init () var2757)
(declare-fun <init>/-2175807 (var2757) void)
(declare-fun cast-from-var2757-to-var3816 (var2757) var3816)
(declare-fun attributeMap/639256687 (var1505) var3816)
(declare-fun method/639256687 (var1505) var3616)
(declare-fun getName/1227988463 (var3616) String)
(declare-fun methodName/639256687 (var1505) String)
(declare-fun getParameterTypes/827748249 (var3616) (Array Int ClassObject))
(declare-fun parameterClasses/639256687 (var1505) (Array Int ClassObject))
(declare-fun getReturnType/-1494237887 (var3616) ClassObject)
(declare-fun returnClass/639256687 (var1505) ClassObject)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getDeclaringClass/501867354 (var3616) ClassObject)
(declare-fun getName/-1958580599 (ClassObject) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var1843_error/377575788 (var1843 String String String String var1767) void)
(declare-fun arr-ClassObject-init () (Array Int ClassObject))
(define-fun cast-from-ClassObject-to-ClassObject ((arg ClassObject)) ClassObject arg)
(declare-fun returnTypes/639256687 (var1505) (Array Int ClassObject))
(declare-fun var3678_getDesc/-2047538545 ((Array Int ClassObject)) String)
(declare-fun paramDesc/639256687 (var1505) String)
(declare-fun var3253_of/184955601 ((Array Int var2549)) var3253)
(declare-fun cast-from-__Array__Int__ClassObject__-to-__Array__Int__var2549__ ((Array Int ClassObject)) (Array Int var2549))
(declare-fun var2755_bootstrap$/-276343291 () var1921)
(declare-fun var3253_map/130902797 (var3253 var1921) var3253)
(declare-fun var1476_bootstrap$/1633046284 () var854)
(declare-fun var3253_toArray/-73424125 (var3253 var854) (Array Int var2549))
(declare-fun cast-from-__Array__Int__var2549__-to-__Array__Int__String__ ((Array Int var2549)) (Array Int String))
(declare-fun compatibleParamSignatures/639256687 (var1505) (Array Int String))
(declare-fun getLength-Arr-ClassObject-1 ((Array Int ClassObject)) Int)
(declare-fun generic/639256687 (var1505) Bool)
(declare-fun determineRpcType/1716683319 (var1505) var3034)
(declare-fun rpcType/639256687 (var1505) var3034)
(declare-const null-var1505 var1505)
(declare-const null-var3616 var3616)
(declare-const null-var1767 var1767)
(declare-const var1505-logger var1843)
(declare-const null-__Array__Int__ClassObject__ (Array Int ClassObject))
(declare-const var2361 var1505) ; Statement: r0 := @this: org.apache.dubbo.rpc.model.ReflectionMethodDescriptor 
(assert (not (= var2361 null-var1505)))
(declare-const var3237 var3616) ; Statement: r2 := @parameter0: java.lang.reflect.Method 
(assert (not (= var3237 null-var3616)))
(assert true)
;(assert (<init>/-279557996 (cast-from-var1505-to-var2549 var2361))) ; Statement: specialinvoke r0.<java.lang.Object: void <init>()>() 

(declare-const var2361!1 var1505)
(define-const var943 var2757 var2757-init) ; Statement: $r1 = new java.util.concurrent.ConcurrentHashMap 
(assert true)
;(assert (<init>/-2175807 var943)) ; Statement: specialinvoke $r1.<java.util.concurrent.ConcurrentHashMap: void <init>()>() 

(declare-const var943!1 var2757)
(declare-const var2361!2 var1505)
(assert (not (= var2361!2 null-var1505)))
(assert (= (attributeMap/639256687 var2361!2) (cast-from-var2757-to-var3816 var943!1))) ; Statement: r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.util.concurrent.ConcurrentMap attributeMap> = $r1 
(declare-const var2361!3 var1505)
(assert (not (= var2361!3 null-var1505)))
(assert (= (method/639256687 var2361!3) var3237)) ; Statement: r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.reflect.Method method> = r2 
(assert true)
(define-const var1090 String (getName/1227988463 var3237)) ; Statement: $r3 = virtualinvoke r2.<java.lang.reflect.Method: java.lang.String getName()>() 
(declare-const var2361!4 var1505)
(assert (not (= var2361!4 null-var1505)))
(assert (= (methodName/639256687 var2361!4) var1090)) ; Statement: r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.String methodName> = $r3 
(assert true)
(define-const var2488 (Array Int ClassObject) (getParameterTypes/827748249 var3237)) ; Statement: $r4 = virtualinvoke r2.<java.lang.reflect.Method: java.lang.Class[] getParameterTypes()>() 
(declare-const var2361!5 var1505)
(assert (not (= var2361!5 null-var1505)))
(assert (= (parameterClasses/639256687 var2361!5) var2488)) ; Statement: r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.Class[] parameterClasses> = $r4 
(assert true)
(define-const var2216 ClassObject (getReturnType/-1494237887 var3237)) ; Statement: $r5 = virtualinvoke r2.<java.lang.reflect.Method: java.lang.Class getReturnType()>() 
(declare-const var2361!6 var1505)
(assert (not (= var2361!6 null-var1505)))
(assert (= (returnClass/639256687 var2361!6) var2216)) ; Statement: r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.Class returnClass> = $r5 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var3758 var1767) ; Statement: $r18 := @caughtexception 
(assert (not (= var3758 null-var1767)))
(define-const var210 var1843 var1505-logger) ; Statement: $r20 = <org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var2268 String String-init) ; Statement: $r19 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2268)) ; Statement: specialinvoke $r19.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2268!1 String)
(assert (= var2268!1 ""))
(assert true)
(define-const var887 String (append/672562846 var2268!1 "fail to get return types. Method name: ")) ; Statement: $r22 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("fail to get return types. Method name: ") 
(declare-const var2268!2 String)
(assert (= var2268!2 (str.++ var2268!1 "fail to get return types. Method name: ")))
(define-const var1041 String (methodName/639256687 var2361!6)) ; Statement: $r21 = r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.String methodName> 
(assert true)
(define-const var2267 String (append/672562846 var887 var1041)) ; Statement: $r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r21) 
(declare-const var887!1 String)
(assert (= var887!1 (str.++ var887 var1041)))
(assert true)
(define-const var1735 String (append/672562846 var2267 " Declaring class:")) ; Statement: $r26 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" Declaring class:") 
(declare-const var2267!1 String)
(assert (= var2267!1 (str.++ var2267 " Declaring class:")))
(assert true)
(define-const var2605 ClassObject (getDeclaringClass/501867354 var3237)) ; Statement: $r24 = virtualinvoke r2.<java.lang.reflect.Method: java.lang.Class getDeclaringClass()>() 
(assert true)
(define-const var931 String (getName/-1958580599 var2605)) ; Statement: $r25 = virtualinvoke $r24.<java.lang.Class: java.lang.String getName()>() 
(assert true)
(define-const var3325 String (append/672562846 var1735 var931)) ; Statement: $r27 = virtualinvoke $r26.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r25) 
(declare-const var1735!1 String)
(assert (= var1735!1 (str.++ var1735 var931)))
(assert true)
(define-const var690 String (toString/-2075883882 var3325)) ; Statement: $r28 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var1843_error/377575788 var210 "0-8" "" "" var690 var3758)) ; Statement: interfaceinvoke $r20.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("0-8", "", "", $r28, $r18) 

(declare-const var210!1 var1843)
(declare-const var2319 String)
(declare-const var3396 String)
(declare-const var3396!1 String)
(declare-const var690!1 String)
(declare-const var3758!1 var1767)
(define-const var194 (Array Int ClassObject) arr-ClassObject-init) ; Statement: $r29 = newarray (java.lang.reflect.Type)[2] 
(define-const var241 ClassObject (returnClass/639256687 var2361!6)) ; Statement: $r30 = r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.Class returnClass> 
(declare-const var194!1 (Array Int ClassObject))
(assert (not (= var194!1 null-__Array__Int__ClassObject__)))
(assert (= (select var194!1 0) (cast-from-ClassObject-to-ClassObject var241))) ; Statement: $r29[0] = $r30 
(define-const var3923 ClassObject (returnClass/639256687 var2361!6)) ; Statement: $r31 = r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.Class returnClass> 
(declare-const var194!2 (Array Int ClassObject))
(assert (not (= var194!2 null-__Array__Int__ClassObject__)))
(assert (= (select var194!2 1) (cast-from-ClassObject-to-ClassObject var3923))) ; Statement: $r29[1] = $r31 
(define-const var1435 (Array Int ClassObject) var194!2) ; Statement: r32 = $r29 
(assert true) ; Non Conditional
(declare-const var2361!7 var1505)
(assert (not (= var2361!7 null-var1505)))
(assert (= (returnTypes/639256687 var2361!7) var1435)) ; Statement: r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.reflect.Type[] returnTypes> = r32 
(define-const var3746 (Array Int ClassObject) (parameterClasses/639256687 var2361!7)) ; Statement: $r6 = r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.Class[] parameterClasses> 
(define-const var2378 String (var3678_getDesc/-2047538545 var3746)) ; Statement: $r7 = staticinvoke <org.apache.dubbo.common.utils.ReflectUtils: java.lang.String getDesc(java.lang.Class[])>($r6) 
(declare-const var2361!8 var1505)
(assert (not (= var2361!8 null-var1505)))
(assert (= (paramDesc/639256687 var2361!8) var2378)) ; Statement: r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.String paramDesc> = $r7 
(define-const var1058 (Array Int ClassObject) (parameterClasses/639256687 var2361!8)) ; Statement: $r8 = r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.Class[] parameterClasses> 
(define-const var2660 var3253 (var3253_of/184955601 (cast-from-__Array__Int__ClassObject__-to-__Array__Int__var2549__ var1058))) ; Statement: $r10 = staticinvoke <java.util.stream.Stream: java.util.stream.Stream of(java.lang.Object[])>($r8) 
(define-const var442 var1921 var2755_bootstrap$/-276343291) ; Statement: $r9 = staticinvoke <org.apache.dubbo.rpc.model.ReflectionMethodDescriptor$getName__428: java.util.function.Function bootstrap$()>() 
(define-const var3400 var3253 (var3253_map/130902797 var2660 var442)) ; Statement: $r12 = interfaceinvoke $r10.<java.util.stream.Stream: java.util.stream.Stream map(java.util.function.Function)>($r9) 
(define-const var3648 var854 var1476_bootstrap$/1633046284) ; Statement: $r11 = staticinvoke <org.apache.dubbo.rpc.model.ReflectionMethodDescriptor$lambda_new_0__437: java.util.function.IntFunction bootstrap$()>() 
(define-const var2638 (Array Int var2549) (var3253_toArray/-73424125 var3400 var3648)) ; Statement: $r13 = interfaceinvoke $r12.<java.util.stream.Stream: java.lang.Object[] toArray(java.util.function.IntFunction)>($r11) 
(define-const var2175 (Array Int String) (cast-from-__Array__Int__var2549__-to-__Array__Int__String__ var2638)) ; Statement: $r14 = (java.lang.String[]) $r13 
(declare-const var2361!9 var1505)
(assert (not (= var2361!9 null-var1505)))
(assert (= (compatibleParamSignatures/639256687 var2361!9) var2175)) ; Statement: r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.String[] compatibleParamSignatures> = $r14 
(define-const var181 String (methodName/639256687 var2361!9)) ; Statement: $r15 = r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.String methodName> 
(assert true)
(define-const var3211 Bool (= var181 "$invoke")) ; Statement: $z0 = virtualinvoke $r15.<java.lang.String: boolean equals(java.lang.Object)>("$invoke") 
 ; Statement: if $z0 != 0 goto $r16 = r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.Class[] parameterClasses> 
(assert (not (= (ite var3211 1 0) 0))) ; Cond: $z0 != 0 
(define-const var2296 (Array Int ClassObject) (parameterClasses/639256687 var2361!9)) ; Statement: $r16 = r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.Class[] parameterClasses> 
(define-const var2251 Int (getLength-Arr-ClassObject-1 var2296)) ; Statement: $i0 = lengthof $r16 
 ; Statement: if $i0 != 3 goto $z2 = 0 
(assert (not (not (= var2251 3)))) ; Negate: Cond: $i0 != 3  
(define-const var1990 Bool (ite (= 1 1) true false)) ; Statement: $z2 = 1 
 ; Statement: goto [?= r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: boolean generic> = $z2] 
(assert true) ; Non Conditional
(declare-const var2361!10 var1505)
(assert (not (= var2361!10 null-var1505)))
(assert (= (generic/639256687 var2361!10) var1990)) ; Statement: r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: boolean generic> = $z2 
(assert true)
(define-const var3876 var3034 (determineRpcType/1716683319 var2361!10)) ; Statement: $r33 = specialinvoke r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: org.apache.dubbo.rpc.model.MethodDescriptor$RpcType determineRpcType()>() 
(declare-const var2361!11 var1505)
(assert (not (= var2361!11 null-var1505)))
(assert (= (rpcType/639256687 var2361!11) var3876)) ; Statement: r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: org.apache.dubbo.rpc.model.MethodDescriptor$RpcType rpcType> = $r33 
 ; Statement: return 
(check-sat)
; {<init>/-279557996=([java.lang.Object], void), cast-from-var1505-to-var2549=([org.apache.dubbo.rpc.model.ReflectionMethodDescriptor], java.lang.Object), var2757-init=([], java.util.concurrent.ConcurrentHashMap), <init>/-2175807=([java.util.concurrent.ConcurrentHashMap], void), cast-from-var2757-to-var3816=([java.util.concurrent.ConcurrentHashMap], java.util.concurrent.ConcurrentMap), attributeMap/639256687=([org.apache.dubbo.rpc.model.ReflectionMethodDescriptor], java.util.concurrent.ConcurrentMap), method/639256687=([org.apache.dubbo.rpc.model.ReflectionMethodDescriptor], java.lang.reflect.Method), getName/1227988463=([java.lang.reflect.Method], java.lang.String), methodName/639256687=([org.apache.dubbo.rpc.model.ReflectionMethodDescriptor], java.lang.String), getParameterTypes/827748249=([java.lang.reflect.Method], java.lang.Class[]), parameterClasses/639256687=([org.apache.dubbo.rpc.model.ReflectionMethodDescriptor], java.lang.Class[]), getReturnType/-1494237887=([java.lang.reflect.Method], java.lang.Class), returnClass/639256687=([org.apache.dubbo.rpc.model.ReflectionMethodDescriptor], java.lang.Class), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getDeclaringClass/501867354=([java.lang.reflect.Method], java.lang.Class), getName/-1958580599=([java.lang.Class], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var1843_error/377575788=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void), arr-ClassObject-init=([], java.lang.reflect.Type[]), cast-from-ClassObject-to-ClassObject=([java.lang.Class], java.lang.reflect.Type), returnTypes/639256687=([org.apache.dubbo.rpc.model.ReflectionMethodDescriptor], java.lang.reflect.Type[]), var3678_getDesc/-2047538545=([java.lang.Class[]], java.lang.String), paramDesc/639256687=([org.apache.dubbo.rpc.model.ReflectionMethodDescriptor], java.lang.String), var3253_of/184955601=([java.lang.Object[]], java.util.stream.Stream), cast-from-__Array__Int__ClassObject__-to-__Array__Int__var2549__=([java.lang.Class[]], java.lang.Object[]), var2755_bootstrap$/-276343291=([], java.util.function.Function), var3253_map/130902797=([java.util.stream.Stream, java.util.function.Function], java.util.stream.Stream), var1476_bootstrap$/1633046284=([], java.util.function.IntFunction), var3253_toArray/-73424125=([java.util.stream.Stream, java.util.function.IntFunction], java.lang.Object[]), cast-from-__Array__Int__var2549__-to-__Array__Int__String__=([java.lang.Object[]], java.lang.String[]), compatibleParamSignatures/639256687=([org.apache.dubbo.rpc.model.ReflectionMethodDescriptor], java.lang.String[]), getLength-Arr-ClassObject-1=([java.lang.Class[]], int), generic/639256687=([org.apache.dubbo.rpc.model.ReflectionMethodDescriptor], boolean), determineRpcType/1716683319=([org.apache.dubbo.rpc.model.ReflectionMethodDescriptor], org.apache.dubbo.rpc.model.MethodDescriptor$RpcType), rpcType/639256687=([org.apache.dubbo.rpc.model.ReflectionMethodDescriptor], org.apache.dubbo.rpc.model.MethodDescriptor$RpcType)}
; {var1505=org.apache.dubbo.rpc.model.ReflectionMethodDescriptor, var2361=r0, var3616=java.lang.reflect.Method, var3237=r2, var2549=java.lang.Object, var2757=java.util.concurrent.ConcurrentHashMap, var943=$r1, var3816=java.util.concurrent.ConcurrentMap, var1090=$r3, var2488=$r4, var2216=$r5, var1767=java.lang.Throwable, var3758=$r18, var1843=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var210=$r20, var2268=$r19, var887=$r22, var1041=$r21, var2267=$r23, var1735=$r26, var2605=$r24, var931=$r25, var3325=$r27, var690=$r28, var2319="0-8", var3396="", var194=$r29, var241=$r30, var3923=$r31, var1435=r32, var3746=$r6, var3678=org.apache.dubbo.common.utils.ReflectUtils, var2378=$r7, var1058=$r8, var3253=java.util.stream.Stream, var2660=$r10, var1921=java.util.function.Function, var2755=org.apache.dubbo.rpc.model.ReflectionMethodDescriptor$getName__428, var442=$r9, var3400=$r12, var854=java.util.function.IntFunction, var1476=org.apache.dubbo.rpc.model.ReflectionMethodDescriptor$lambda_new_0__437, var3648=$r11, var2638=$r13, var2175=$r14, var181=$r15, var3211=$z0, var2296=$r16, var2251=$i0, var1990=$z2, var3034=org.apache.dubbo.rpc.model.MethodDescriptor$RpcType, var3876=$r33}
; {org.apache.dubbo.rpc.model.ReflectionMethodDescriptor=var1505, r0=var2361, java.lang.reflect.Method=var3616, r2=var3237, java.lang.Object=var2549, java.util.concurrent.ConcurrentHashMap=var2757, $r1=var943, java.util.concurrent.ConcurrentMap=var3816, $r3=var1090, $r4=var2488, $r5=var2216, java.lang.Throwable=var1767, $r18=var3758, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var1843, $r20=var210, $r19=var2268, $r22=var887, $r21=var1041, $r23=var2267, $r26=var1735, $r24=var2605, $r25=var931, $r27=var3325, $r28=var690, "0-8"=var2319, ""=var3396, $r29=var194, $r30=var241, $r31=var3923, r32=var1435, $r6=var3746, org.apache.dubbo.common.utils.ReflectUtils=var3678, $r7=var2378, $r8=var1058, java.util.stream.Stream=var3253, $r10=var2660, java.util.function.Function=var1921, org.apache.dubbo.rpc.model.ReflectionMethodDescriptor$getName__428=var2755, $r9=var442, $r12=var3400, java.util.function.IntFunction=var854, org.apache.dubbo.rpc.model.ReflectionMethodDescriptor$lambda_new_0__437=var1476, $r11=var3648, $r13=var2638, $r14=var2175, $r15=var181, $z0=var3211, $r16=var2296, $i0=var2251, $z2=var1990, org.apache.dubbo.rpc.model.MethodDescriptor$RpcType=var3034, $r33=var3876}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.String toString()>": 1,"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.model.ReflectionMethodDescriptor;	r2 := @parameter0: java.lang.reflect.Method;	specialinvoke r0.<java.lang.Object: void <init>()>();	$r1 = new java.util.concurrent.ConcurrentHashMap;	specialinvoke $r1.<java.util.concurrent.ConcurrentHashMap: void <init>()>();	r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.util.concurrent.ConcurrentMap attributeMap> = $r1;	r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.reflect.Method method> = r2;	$r3 = virtualinvoke r2.<java.lang.reflect.Method: java.lang.String getName()>();	r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.String methodName> = $r3;	$r4 = virtualinvoke r2.<java.lang.reflect.Method: java.lang.Class[] getParameterTypes()>();	r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.Class[] parameterClasses> = $r4;	$r5 = virtualinvoke r2.<java.lang.reflect.Method: java.lang.Class getReturnType()>();	r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.Class returnClass> = $r5;	$r18 := @caughtexception;	$r20 = <org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r19 = new java.lang.StringBuilder;	specialinvoke $r19.<java.lang.StringBuilder: void <init>()>();	$r22 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("fail to get return types. Method name: ");	$r21 = r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.String methodName>;	$r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r21);	$r26 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" Declaring class:");	$r24 = virtualinvoke r2.<java.lang.reflect.Method: java.lang.Class getDeclaringClass()>();	$r25 = virtualinvoke $r24.<java.lang.Class: java.lang.String getName()>();	$r27 = virtualinvoke $r26.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r25);	$r28 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r20.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("0-8", "", "", $r28, $r18);	$r29 = newarray (java.lang.reflect.Type)[2];	$r30 = r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.Class returnClass>;	$r29[0] = $r30;	$r31 = r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.Class returnClass>;	$r29[1] = $r31;	r32 = $r29;	r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.reflect.Type[] returnTypes> = r32;	$r6 = r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.Class[] parameterClasses>;	$r7 = staticinvoke <org.apache.dubbo.common.utils.ReflectUtils: java.lang.String getDesc(java.lang.Class[])>($r6);	r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.String paramDesc> = $r7;	$r8 = r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.Class[] parameterClasses>;	$r10 = staticinvoke <java.util.stream.Stream: java.util.stream.Stream of(java.lang.Object[])>($r8);	$r9 = staticinvoke <org.apache.dubbo.rpc.model.ReflectionMethodDescriptor$getName__428: java.util.function.Function bootstrap$()>();	$r12 = interfaceinvoke $r10.<java.util.stream.Stream: java.util.stream.Stream map(java.util.function.Function)>($r9);	$r11 = staticinvoke <org.apache.dubbo.rpc.model.ReflectionMethodDescriptor$lambda_new_0__437: java.util.function.IntFunction bootstrap$()>();	$r13 = interfaceinvoke $r12.<java.util.stream.Stream: java.lang.Object[] toArray(java.util.function.IntFunction)>($r11);	$r14 = (java.lang.String[]) $r13;	r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.String[] compatibleParamSignatures> = $r14;	$r15 = r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.String methodName>;	$z0 = virtualinvoke $r15.<java.lang.String: boolean equals(java.lang.Object)>("$invoke");	if $z0 != 0 goto $r16 = r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.Class[] parameterClasses>;	$r16 = r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.Class[] parameterClasses>;	$i0 = lengthof $r16;	if $i0 != 3 goto $z2 = 0;	$z2 = 1;	goto [?= r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: boolean generic> = $z2];	r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: boolean generic> = $z2;	$r33 = specialinvoke r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: org.apache.dubbo.rpc.model.MethodDescriptor$RpcType determineRpcType()>();	r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: org.apache.dubbo.rpc.model.MethodDescriptor$RpcType rpcType> = $r33;	return
;block_num 6