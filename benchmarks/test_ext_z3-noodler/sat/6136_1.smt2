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

(declare-sort var1822 0)
(declare-sort var2111 0)
(declare-sort var447 0)
(declare-sort var1009 0)
(declare-sort var2863 0)
(declare-sort var92 0)
(declare-sort var2689 0)
(declare-sort var2477 0)
(declare-sort var706 0)
(declare-sort var3839 0)
(declare-sort var906 0)
(declare-sort var2449 0)
(declare-sort var530 0)
(declare-sort var2192 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun <init>/-279557996 (var447) void)
(declare-fun cast-from-var1822-to-var447 (var1822) var447)
(declare-fun var1009-init () var1009)
(declare-fun <init>/-2175807 (var1009) void)
(declare-fun cast-from-var1009-to-var2863 (var1009) var2863)
(declare-fun attributeMap/639256687 (var1822) var2863)
(declare-fun method/639256687 (var1822) var2111)
(declare-fun getName/1227988463 (var2111) String)
(declare-fun methodName/639256687 (var1822) String)
(declare-fun getParameterTypes/827748249 (var2111) (Array Int ClassObject))
(declare-fun parameterClasses/639256687 (var1822) (Array Int ClassObject))
(declare-fun getReturnType/-1494237887 (var2111) ClassObject)
(declare-fun returnClass/639256687 (var1822) ClassObject)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getDeclaringClass/501867354 (var2111) ClassObject)
(declare-fun getName/-1958580599 (ClassObject) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var2689_error/377575788 (var2689 String String String String var92) void)
(declare-fun arr-ClassObject-init () (Array Int ClassObject))
(define-fun cast-from-ClassObject-to-ClassObject ((arg ClassObject)) ClassObject arg)
(declare-fun returnTypes/639256687 (var1822) (Array Int ClassObject))
(declare-fun var2477_getDesc/-2047538545 ((Array Int ClassObject)) String)
(declare-fun paramDesc/639256687 (var1822) String)
(declare-fun var706_of/184955601 ((Array Int var447)) var706)
(declare-fun cast-from-__Array__Int__ClassObject__-to-__Array__Int__var447__ ((Array Int ClassObject)) (Array Int var447))
(declare-fun var906_bootstrap$/-276343291 () var3839)
(declare-fun var706_map/130902797 (var706 var3839) var706)
(declare-fun var530_bootstrap$/1633046284 () var2449)
(declare-fun var706_toArray/-73424125 (var706 var2449) (Array Int var447))
(declare-fun cast-from-__Array__Int__var447__-to-__Array__Int__String__ ((Array Int var447)) (Array Int String))
(declare-fun compatibleParamSignatures/639256687 (var1822) (Array Int String))
(declare-fun generic/639256687 (var1822) Bool)
(declare-fun determineRpcType/1716683319 (var1822) var2192)
(declare-fun rpcType/639256687 (var1822) var2192)
(declare-const null-var1822 var1822)
(declare-const null-var2111 var2111)
(declare-const null-var92 var92)
(declare-const var1822-logger var2689)
(declare-const null-__Array__Int__ClassObject__ (Array Int ClassObject))
(declare-const var1900 var1822) ; Statement: r0 := @this: org.apache.dubbo.rpc.model.ReflectionMethodDescriptor 
(assert (not (= var1900 null-var1822)))
(declare-const var2671 var2111) ; Statement: r2 := @parameter0: java.lang.reflect.Method 
(assert (not (= var2671 null-var2111)))
(assert true)
;(assert (<init>/-279557996 (cast-from-var1822-to-var447 var1900))) ; Statement: specialinvoke r0.<java.lang.Object: void <init>()>() 

(declare-const var1900!1 var1822)
(define-const var1168 var1009 var1009-init) ; Statement: $r1 = new java.util.concurrent.ConcurrentHashMap 
(assert true)
;(assert (<init>/-2175807 var1168)) ; Statement: specialinvoke $r1.<java.util.concurrent.ConcurrentHashMap: void <init>()>() 

(declare-const var1168!1 var1009)
(declare-const var1900!2 var1822)
(assert (not (= var1900!2 null-var1822)))
(assert (= (attributeMap/639256687 var1900!2) (cast-from-var1009-to-var2863 var1168!1))) ; Statement: r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.util.concurrent.ConcurrentMap attributeMap> = $r1 
(declare-const var1900!3 var1822)
(assert (not (= var1900!3 null-var1822)))
(assert (= (method/639256687 var1900!3) var2671)) ; Statement: r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.reflect.Method method> = r2 
(assert true)
(define-const var1122 String (getName/1227988463 var2671)) ; Statement: $r3 = virtualinvoke r2.<java.lang.reflect.Method: java.lang.String getName()>() 
(declare-const var1900!4 var1822)
(assert (not (= var1900!4 null-var1822)))
(assert (= (methodName/639256687 var1900!4) var1122)) ; Statement: r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.String methodName> = $r3 
(assert true)
(define-const var1449 (Array Int ClassObject) (getParameterTypes/827748249 var2671)) ; Statement: $r4 = virtualinvoke r2.<java.lang.reflect.Method: java.lang.Class[] getParameterTypes()>() 
(declare-const var1900!5 var1822)
(assert (not (= var1900!5 null-var1822)))
(assert (= (parameterClasses/639256687 var1900!5) var1449)) ; Statement: r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.Class[] parameterClasses> = $r4 
(assert true)
(define-const var3586 ClassObject (getReturnType/-1494237887 var2671)) ; Statement: $r5 = virtualinvoke r2.<java.lang.reflect.Method: java.lang.Class getReturnType()>() 
(declare-const var1900!6 var1822)
(assert (not (= var1900!6 null-var1822)))
(assert (= (returnClass/639256687 var1900!6) var3586)) ; Statement: r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.Class returnClass> = $r5 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var1541 var92) ; Statement: $r18 := @caughtexception 
(assert (not (= var1541 null-var92)))
(define-const var2359 var2689 var1822-logger) ; Statement: $r20 = <org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var3070 String String-init) ; Statement: $r19 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3070)) ; Statement: specialinvoke $r19.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3070!1 String)
(assert (= var3070!1 ""))
(assert true)
(define-const var1257 String (append/672562846 var3070!1 "fail to get return types. Method name: ")) ; Statement: $r22 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("fail to get return types. Method name: ") 
(declare-const var3070!2 String)
(assert (= var3070!2 (str.++ var3070!1 "fail to get return types. Method name: ")))
(define-const var2244 String (methodName/639256687 var1900!6)) ; Statement: $r21 = r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.String methodName> 
(assert true)
(define-const var1874 String (append/672562846 var1257 var2244)) ; Statement: $r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r21) 
(declare-const var1257!1 String)
(assert (= var1257!1 (str.++ var1257 var2244)))
(assert true)
(define-const var3389 String (append/672562846 var1874 " Declaring class:")) ; Statement: $r26 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" Declaring class:") 
(declare-const var1874!1 String)
(assert (= var1874!1 (str.++ var1874 " Declaring class:")))
(assert true)
(define-const var2247 ClassObject (getDeclaringClass/501867354 var2671)) ; Statement: $r24 = virtualinvoke r2.<java.lang.reflect.Method: java.lang.Class getDeclaringClass()>() 
(assert true)
(define-const var3310 String (getName/-1958580599 var2247)) ; Statement: $r25 = virtualinvoke $r24.<java.lang.Class: java.lang.String getName()>() 
(assert true)
(define-const var217 String (append/672562846 var3389 var3310)) ; Statement: $r27 = virtualinvoke $r26.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r25) 
(declare-const var3389!1 String)
(assert (= var3389!1 (str.++ var3389 var3310)))
(assert true)
(define-const var2156 String (toString/-2075883882 var217)) ; Statement: $r28 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var2689_error/377575788 var2359 "0-8" "" "" var2156 var1541)) ; Statement: interfaceinvoke $r20.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("0-8", "", "", $r28, $r18) 

(declare-const var2359!1 var2689)
(declare-const var1046 String)
(declare-const var3928 String)
(declare-const var3928!1 String)
(declare-const var2156!1 String)
(declare-const var1541!1 var92)
(define-const var2788 (Array Int ClassObject) arr-ClassObject-init) ; Statement: $r29 = newarray (java.lang.reflect.Type)[2] 
(define-const var3647 ClassObject (returnClass/639256687 var1900!6)) ; Statement: $r30 = r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.Class returnClass> 
(declare-const var2788!1 (Array Int ClassObject))
(assert (not (= var2788!1 null-__Array__Int__ClassObject__)))
(assert (= (select var2788!1 0) (cast-from-ClassObject-to-ClassObject var3647))) ; Statement: $r29[0] = $r30 
(define-const var1024 ClassObject (returnClass/639256687 var1900!6)) ; Statement: $r31 = r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.Class returnClass> 
(declare-const var2788!2 (Array Int ClassObject))
(assert (not (= var2788!2 null-__Array__Int__ClassObject__)))
(assert (= (select var2788!2 1) (cast-from-ClassObject-to-ClassObject var1024))) ; Statement: $r29[1] = $r31 
(define-const var2862 (Array Int ClassObject) var2788!2) ; Statement: r32 = $r29 
(assert true) ; Non Conditional
(declare-const var1900!7 var1822)
(assert (not (= var1900!7 null-var1822)))
(assert (= (returnTypes/639256687 var1900!7) var2862)) ; Statement: r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.reflect.Type[] returnTypes> = r32 
(define-const var2168 (Array Int ClassObject) (parameterClasses/639256687 var1900!7)) ; Statement: $r6 = r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.Class[] parameterClasses> 
(define-const var209 String (var2477_getDesc/-2047538545 var2168)) ; Statement: $r7 = staticinvoke <org.apache.dubbo.common.utils.ReflectUtils: java.lang.String getDesc(java.lang.Class[])>($r6) 
(declare-const var1900!8 var1822)
(assert (not (= var1900!8 null-var1822)))
(assert (= (paramDesc/639256687 var1900!8) var209)) ; Statement: r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.String paramDesc> = $r7 
(define-const var630 (Array Int ClassObject) (parameterClasses/639256687 var1900!8)) ; Statement: $r8 = r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.Class[] parameterClasses> 
(define-const var2736 var706 (var706_of/184955601 (cast-from-__Array__Int__ClassObject__-to-__Array__Int__var447__ var630))) ; Statement: $r10 = staticinvoke <java.util.stream.Stream: java.util.stream.Stream of(java.lang.Object[])>($r8) 
(define-const var3687 var3839 var906_bootstrap$/-276343291) ; Statement: $r9 = staticinvoke <org.apache.dubbo.rpc.model.ReflectionMethodDescriptor$getName__428: java.util.function.Function bootstrap$()>() 
(define-const var84 var706 (var706_map/130902797 var2736 var3687)) ; Statement: $r12 = interfaceinvoke $r10.<java.util.stream.Stream: java.util.stream.Stream map(java.util.function.Function)>($r9) 
(define-const var3628 var2449 var530_bootstrap$/1633046284) ; Statement: $r11 = staticinvoke <org.apache.dubbo.rpc.model.ReflectionMethodDescriptor$lambda_new_0__437: java.util.function.IntFunction bootstrap$()>() 
(define-const var334 (Array Int var447) (var706_toArray/-73424125 var84 var3628)) ; Statement: $r13 = interfaceinvoke $r12.<java.util.stream.Stream: java.lang.Object[] toArray(java.util.function.IntFunction)>($r11) 
(define-const var3079 (Array Int String) (cast-from-__Array__Int__var447__-to-__Array__Int__String__ var334)) ; Statement: $r14 = (java.lang.String[]) $r13 
(declare-const var1900!9 var1822)
(assert (not (= var1900!9 null-var1822)))
(assert (= (compatibleParamSignatures/639256687 var1900!9) var3079)) ; Statement: r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.String[] compatibleParamSignatures> = $r14 
(define-const var3513 String (methodName/639256687 var1900!9)) ; Statement: $r15 = r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.String methodName> 
(assert true)
(define-const var2074 Bool (= var3513 "$invoke")) ; Statement: $z0 = virtualinvoke $r15.<java.lang.String: boolean equals(java.lang.Object)>("$invoke") 
 ; Statement: if $z0 != 0 goto $r16 = r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.Class[] parameterClasses> 
(assert (not (not (= (ite var2074 1 0) 0)))) ; Negate: Cond: $z0 != 0  
(define-const var813 String (methodName/639256687 var1900!9)) ; Statement: $r17 = r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.String methodName> 
(assert true)
(define-const var3025 Bool (= var813 "$invokeAsync")) ; Statement: $z1 = virtualinvoke $r17.<java.lang.String: boolean equals(java.lang.Object)>("$invokeAsync") 
 ; Statement: if $z1 == 0 goto $z2 = 0 
(assert (= (ite var3025 1 0) 0)) ; Cond: $z1 == 0 
(define-const var1751 Bool (ite (= 1 0) true false)) ; Statement: $z2 = 0 
(assert true) ; Non Conditional
(declare-const var1900!10 var1822)
(assert (not (= var1900!10 null-var1822)))
(assert (= (generic/639256687 var1900!10) var1751)) ; Statement: r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: boolean generic> = $z2 
(assert true)
(define-const var3622 var2192 (determineRpcType/1716683319 var1900!10)) ; Statement: $r33 = specialinvoke r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: org.apache.dubbo.rpc.model.MethodDescriptor$RpcType determineRpcType()>() 
(declare-const var1900!11 var1822)
(assert (not (= var1900!11 null-var1822)))
(assert (= (rpcType/639256687 var1900!11) var3622)) ; Statement: r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: org.apache.dubbo.rpc.model.MethodDescriptor$RpcType rpcType> = $r33 
 ; Statement: return 
(check-sat)
; {<init>/-279557996=([java.lang.Object], void), cast-from-var1822-to-var447=([org.apache.dubbo.rpc.model.ReflectionMethodDescriptor], java.lang.Object), var1009-init=([], java.util.concurrent.ConcurrentHashMap), <init>/-2175807=([java.util.concurrent.ConcurrentHashMap], void), cast-from-var1009-to-var2863=([java.util.concurrent.ConcurrentHashMap], java.util.concurrent.ConcurrentMap), attributeMap/639256687=([org.apache.dubbo.rpc.model.ReflectionMethodDescriptor], java.util.concurrent.ConcurrentMap), method/639256687=([org.apache.dubbo.rpc.model.ReflectionMethodDescriptor], java.lang.reflect.Method), getName/1227988463=([java.lang.reflect.Method], java.lang.String), methodName/639256687=([org.apache.dubbo.rpc.model.ReflectionMethodDescriptor], java.lang.String), getParameterTypes/827748249=([java.lang.reflect.Method], java.lang.Class[]), parameterClasses/639256687=([org.apache.dubbo.rpc.model.ReflectionMethodDescriptor], java.lang.Class[]), getReturnType/-1494237887=([java.lang.reflect.Method], java.lang.Class), returnClass/639256687=([org.apache.dubbo.rpc.model.ReflectionMethodDescriptor], java.lang.Class), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getDeclaringClass/501867354=([java.lang.reflect.Method], java.lang.Class), getName/-1958580599=([java.lang.Class], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var2689_error/377575788=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void), arr-ClassObject-init=([], java.lang.reflect.Type[]), cast-from-ClassObject-to-ClassObject=([java.lang.Class], java.lang.reflect.Type), returnTypes/639256687=([org.apache.dubbo.rpc.model.ReflectionMethodDescriptor], java.lang.reflect.Type[]), var2477_getDesc/-2047538545=([java.lang.Class[]], java.lang.String), paramDesc/639256687=([org.apache.dubbo.rpc.model.ReflectionMethodDescriptor], java.lang.String), var706_of/184955601=([java.lang.Object[]], java.util.stream.Stream), cast-from-__Array__Int__ClassObject__-to-__Array__Int__var447__=([java.lang.Class[]], java.lang.Object[]), var906_bootstrap$/-276343291=([], java.util.function.Function), var706_map/130902797=([java.util.stream.Stream, java.util.function.Function], java.util.stream.Stream), var530_bootstrap$/1633046284=([], java.util.function.IntFunction), var706_toArray/-73424125=([java.util.stream.Stream, java.util.function.IntFunction], java.lang.Object[]), cast-from-__Array__Int__var447__-to-__Array__Int__String__=([java.lang.Object[]], java.lang.String[]), compatibleParamSignatures/639256687=([org.apache.dubbo.rpc.model.ReflectionMethodDescriptor], java.lang.String[]), generic/639256687=([org.apache.dubbo.rpc.model.ReflectionMethodDescriptor], boolean), determineRpcType/1716683319=([org.apache.dubbo.rpc.model.ReflectionMethodDescriptor], org.apache.dubbo.rpc.model.MethodDescriptor$RpcType), rpcType/639256687=([org.apache.dubbo.rpc.model.ReflectionMethodDescriptor], org.apache.dubbo.rpc.model.MethodDescriptor$RpcType)}
; {var1822=org.apache.dubbo.rpc.model.ReflectionMethodDescriptor, var1900=r0, var2111=java.lang.reflect.Method, var2671=r2, var447=java.lang.Object, var1009=java.util.concurrent.ConcurrentHashMap, var1168=$r1, var2863=java.util.concurrent.ConcurrentMap, var1122=$r3, var1449=$r4, var3586=$r5, var92=java.lang.Throwable, var1541=$r18, var2689=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var2359=$r20, var3070=$r19, var1257=$r22, var2244=$r21, var1874=$r23, var3389=$r26, var2247=$r24, var3310=$r25, var217=$r27, var2156=$r28, var1046="0-8", var3928="", var2788=$r29, var3647=$r30, var1024=$r31, var2862=r32, var2168=$r6, var2477=org.apache.dubbo.common.utils.ReflectUtils, var209=$r7, var630=$r8, var706=java.util.stream.Stream, var2736=$r10, var3839=java.util.function.Function, var906=org.apache.dubbo.rpc.model.ReflectionMethodDescriptor$getName__428, var3687=$r9, var84=$r12, var2449=java.util.function.IntFunction, var530=org.apache.dubbo.rpc.model.ReflectionMethodDescriptor$lambda_new_0__437, var3628=$r11, var334=$r13, var3079=$r14, var3513=$r15, var2074=$z0, var813=$r17, var3025=$z1, var1751=$z2, var2192=org.apache.dubbo.rpc.model.MethodDescriptor$RpcType, var3622=$r33}
; {org.apache.dubbo.rpc.model.ReflectionMethodDescriptor=var1822, r0=var1900, java.lang.reflect.Method=var2111, r2=var2671, java.lang.Object=var447, java.util.concurrent.ConcurrentHashMap=var1009, $r1=var1168, java.util.concurrent.ConcurrentMap=var2863, $r3=var1122, $r4=var1449, $r5=var3586, java.lang.Throwable=var92, $r18=var1541, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var2689, $r20=var2359, $r19=var3070, $r22=var1257, $r21=var2244, $r23=var1874, $r26=var3389, $r24=var2247, $r25=var3310, $r27=var217, $r28=var2156, "0-8"=var1046, ""=var3928, $r29=var2788, $r30=var3647, $r31=var1024, r32=var2862, $r6=var2168, org.apache.dubbo.common.utils.ReflectUtils=var2477, $r7=var209, $r8=var630, java.util.stream.Stream=var706, $r10=var2736, java.util.function.Function=var3839, org.apache.dubbo.rpc.model.ReflectionMethodDescriptor$getName__428=var906, $r9=var3687, $r12=var84, java.util.function.IntFunction=var2449, org.apache.dubbo.rpc.model.ReflectionMethodDescriptor$lambda_new_0__437=var530, $r11=var3628, $r13=var334, $r14=var3079, $r15=var3513, $z0=var2074, $r17=var813, $z1=var3025, $z2=var1751, org.apache.dubbo.rpc.model.MethodDescriptor$RpcType=var2192, $r33=var3622}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.String: boolean equals(java.lang.Object)>;	<java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.String toString()>": 1,"<java.lang.String: boolean equals(java.lang.Object)>": 2}
;stmts r0 := @this: org.apache.dubbo.rpc.model.ReflectionMethodDescriptor;	r2 := @parameter0: java.lang.reflect.Method;	specialinvoke r0.<java.lang.Object: void <init>()>();	$r1 = new java.util.concurrent.ConcurrentHashMap;	specialinvoke $r1.<java.util.concurrent.ConcurrentHashMap: void <init>()>();	r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.util.concurrent.ConcurrentMap attributeMap> = $r1;	r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.reflect.Method method> = r2;	$r3 = virtualinvoke r2.<java.lang.reflect.Method: java.lang.String getName()>();	r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.String methodName> = $r3;	$r4 = virtualinvoke r2.<java.lang.reflect.Method: java.lang.Class[] getParameterTypes()>();	r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.Class[] parameterClasses> = $r4;	$r5 = virtualinvoke r2.<java.lang.reflect.Method: java.lang.Class getReturnType()>();	r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.Class returnClass> = $r5;	$r18 := @caughtexception;	$r20 = <org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r19 = new java.lang.StringBuilder;	specialinvoke $r19.<java.lang.StringBuilder: void <init>()>();	$r22 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("fail to get return types. Method name: ");	$r21 = r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.String methodName>;	$r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r21);	$r26 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" Declaring class:");	$r24 = virtualinvoke r2.<java.lang.reflect.Method: java.lang.Class getDeclaringClass()>();	$r25 = virtualinvoke $r24.<java.lang.Class: java.lang.String getName()>();	$r27 = virtualinvoke $r26.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r25);	$r28 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r20.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("0-8", "", "", $r28, $r18);	$r29 = newarray (java.lang.reflect.Type)[2];	$r30 = r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.Class returnClass>;	$r29[0] = $r30;	$r31 = r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.Class returnClass>;	$r29[1] = $r31;	r32 = $r29;	r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.reflect.Type[] returnTypes> = r32;	$r6 = r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.Class[] parameterClasses>;	$r7 = staticinvoke <org.apache.dubbo.common.utils.ReflectUtils: java.lang.String getDesc(java.lang.Class[])>($r6);	r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.String paramDesc> = $r7;	$r8 = r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.Class[] parameterClasses>;	$r10 = staticinvoke <java.util.stream.Stream: java.util.stream.Stream of(java.lang.Object[])>($r8);	$r9 = staticinvoke <org.apache.dubbo.rpc.model.ReflectionMethodDescriptor$getName__428: java.util.function.Function bootstrap$()>();	$r12 = interfaceinvoke $r10.<java.util.stream.Stream: java.util.stream.Stream map(java.util.function.Function)>($r9);	$r11 = staticinvoke <org.apache.dubbo.rpc.model.ReflectionMethodDescriptor$lambda_new_0__437: java.util.function.IntFunction bootstrap$()>();	$r13 = interfaceinvoke $r12.<java.util.stream.Stream: java.lang.Object[] toArray(java.util.function.IntFunction)>($r11);	$r14 = (java.lang.String[]) $r13;	r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.String[] compatibleParamSignatures> = $r14;	$r15 = r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.String methodName>;	$z0 = virtualinvoke $r15.<java.lang.String: boolean equals(java.lang.Object)>("$invoke");	if $z0 != 0 goto $r16 = r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.Class[] parameterClasses>;	$r17 = r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.String methodName>;	$z1 = virtualinvoke $r17.<java.lang.String: boolean equals(java.lang.Object)>("$invokeAsync");	if $z1 == 0 goto $z2 = 0;	$z2 = 0;	r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: boolean generic> = $z2;	$r33 = specialinvoke r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: org.apache.dubbo.rpc.model.MethodDescriptor$RpcType determineRpcType()>();	r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: org.apache.dubbo.rpc.model.MethodDescriptor$RpcType rpcType> = $r33;	return
;block_num 6