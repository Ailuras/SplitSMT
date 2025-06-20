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

(declare-sort var2353 0)
(declare-sort var3911 0)
(declare-sort var91 0)
(declare-sort var12 0)
(declare-sort var3130 0)
(declare-sort var3225 0)
(declare-sort var564 0)
(declare-sort var3793 0)
(declare-sort var1078 0)
(declare-sort var42 0)
(declare-sort var3224 0)
(declare-sort var2204 0)
(declare-sort var1624 0)
(declare-sort var2230 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun <init>/-279557996 (var91) void)
(declare-fun cast-from-var2353-to-var91 (var2353) var91)
(declare-fun var12-init () var12)
(declare-fun <init>/-2175807 (var12) void)
(declare-fun cast-from-var12-to-var3130 (var12) var3130)
(declare-fun attributeMap/639256687 (var2353) var3130)
(declare-fun method/639256687 (var2353) var3911)
(declare-fun getName/1227988463 (var3911) String)
(declare-fun methodName/639256687 (var2353) String)
(declare-fun getParameterTypes/827748249 (var3911) (Array Int ClassObject))
(declare-fun parameterClasses/639256687 (var2353) (Array Int ClassObject))
(declare-fun getReturnType/-1494237887 (var3911) ClassObject)
(declare-fun returnClass/639256687 (var2353) ClassObject)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getDeclaringClass/501867354 (var3911) ClassObject)
(declare-fun getName/-1958580599 (ClassObject) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var564_error/377575788 (var564 String String String String var3225) void)
(declare-fun arr-ClassObject-init () (Array Int ClassObject))
(define-fun cast-from-ClassObject-to-ClassObject ((arg ClassObject)) ClassObject arg)
(declare-fun returnTypes/639256687 (var2353) (Array Int ClassObject))
(declare-fun var3793_getDesc/-2047538545 ((Array Int ClassObject)) String)
(declare-fun paramDesc/639256687 (var2353) String)
(declare-fun var1078_of/184955601 ((Array Int var91)) var1078)
(declare-fun cast-from-__Array__Int__ClassObject__-to-__Array__Int__var91__ ((Array Int ClassObject)) (Array Int var91))
(declare-fun var3224_bootstrap$/-276343291 () var42)
(declare-fun var1078_map/130902797 (var1078 var42) var1078)
(declare-fun var1624_bootstrap$/1633046284 () var2204)
(declare-fun var1078_toArray/-73424125 (var1078 var2204) (Array Int var91))
(declare-fun cast-from-__Array__Int__var91__-to-__Array__Int__String__ ((Array Int var91)) (Array Int String))
(declare-fun compatibleParamSignatures/639256687 (var2353) (Array Int String))
(declare-fun getLength-Arr-ClassObject-1 ((Array Int ClassObject)) Int)
(declare-fun generic/639256687 (var2353) Bool)
(declare-fun determineRpcType/1716683319 (var2353) var2230)
(declare-fun rpcType/639256687 (var2353) var2230)
(declare-const null-var2353 var2353)
(declare-const null-var3911 var3911)
(declare-const null-var3225 var3225)
(declare-const var2353-logger var564)
(declare-const null-__Array__Int__ClassObject__ (Array Int ClassObject))
(declare-const var2391 var2353) ; Statement: r0 := @this: org.apache.dubbo.rpc.model.ReflectionMethodDescriptor 
(assert (not (= var2391 null-var2353)))
(declare-const var2766 var3911) ; Statement: r2 := @parameter0: java.lang.reflect.Method 
(assert (not (= var2766 null-var3911)))
(assert true)
;(assert (<init>/-279557996 (cast-from-var2353-to-var91 var2391))) ; Statement: specialinvoke r0.<java.lang.Object: void <init>()>() 

(declare-const var2391!1 var2353)
(define-const var1430 var12 var12-init) ; Statement: $r1 = new java.util.concurrent.ConcurrentHashMap 
(assert true)
;(assert (<init>/-2175807 var1430)) ; Statement: specialinvoke $r1.<java.util.concurrent.ConcurrentHashMap: void <init>()>() 

(declare-const var1430!1 var12)
(declare-const var2391!2 var2353)
(assert (not (= var2391!2 null-var2353)))
(assert (= (attributeMap/639256687 var2391!2) (cast-from-var12-to-var3130 var1430!1))) ; Statement: r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.util.concurrent.ConcurrentMap attributeMap> = $r1 
(declare-const var2391!3 var2353)
(assert (not (= var2391!3 null-var2353)))
(assert (= (method/639256687 var2391!3) var2766)) ; Statement: r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.reflect.Method method> = r2 
(assert true)
(define-const var3776 String (getName/1227988463 var2766)) ; Statement: $r3 = virtualinvoke r2.<java.lang.reflect.Method: java.lang.String getName()>() 
(declare-const var2391!4 var2353)
(assert (not (= var2391!4 null-var2353)))
(assert (= (methodName/639256687 var2391!4) var3776)) ; Statement: r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.String methodName> = $r3 
(assert true)
(define-const var743 (Array Int ClassObject) (getParameterTypes/827748249 var2766)) ; Statement: $r4 = virtualinvoke r2.<java.lang.reflect.Method: java.lang.Class[] getParameterTypes()>() 
(declare-const var2391!5 var2353)
(assert (not (= var2391!5 null-var2353)))
(assert (= (parameterClasses/639256687 var2391!5) var743)) ; Statement: r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.Class[] parameterClasses> = $r4 
(assert true)
(define-const var800 ClassObject (getReturnType/-1494237887 var2766)) ; Statement: $r5 = virtualinvoke r2.<java.lang.reflect.Method: java.lang.Class getReturnType()>() 
(declare-const var2391!6 var2353)
(assert (not (= var2391!6 null-var2353)))
(assert (= (returnClass/639256687 var2391!6) var800)) ; Statement: r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.Class returnClass> = $r5 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var817 var3225) ; Statement: $r18 := @caughtexception 
(assert (not (= var817 null-var3225)))
(define-const var976 var564 var2353-logger) ; Statement: $r20 = <org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var1925 String String-init) ; Statement: $r19 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1925)) ; Statement: specialinvoke $r19.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1925!1 String)
(assert (= var1925!1 ""))
(assert true)
(define-const var1174 String (append/672562846 var1925!1 "fail to get return types. Method name: ")) ; Statement: $r22 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("fail to get return types. Method name: ") 
(declare-const var1925!2 String)
(assert (= var1925!2 (str.++ var1925!1 "fail to get return types. Method name: ")))
(define-const var2583 String (methodName/639256687 var2391!6)) ; Statement: $r21 = r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.String methodName> 
(assert true)
(define-const var1908 String (append/672562846 var1174 var2583)) ; Statement: $r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r21) 
(declare-const var1174!1 String)
(assert (= var1174!1 (str.++ var1174 var2583)))
(assert true)
(define-const var148 String (append/672562846 var1908 " Declaring class:")) ; Statement: $r26 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" Declaring class:") 
(declare-const var1908!1 String)
(assert (= var1908!1 (str.++ var1908 " Declaring class:")))
(assert true)
(define-const var1724 ClassObject (getDeclaringClass/501867354 var2766)) ; Statement: $r24 = virtualinvoke r2.<java.lang.reflect.Method: java.lang.Class getDeclaringClass()>() 
(assert true)
(define-const var727 String (getName/-1958580599 var1724)) ; Statement: $r25 = virtualinvoke $r24.<java.lang.Class: java.lang.String getName()>() 
(assert true)
(define-const var204 String (append/672562846 var148 var727)) ; Statement: $r27 = virtualinvoke $r26.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r25) 
(declare-const var148!1 String)
(assert (= var148!1 (str.++ var148 var727)))
(assert true)
(define-const var1469 String (toString/-2075883882 var204)) ; Statement: $r28 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var564_error/377575788 var976 "0-8" "" "" var1469 var817)) ; Statement: interfaceinvoke $r20.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("0-8", "", "", $r28, $r18) 

(declare-const var976!1 var564)
(declare-const var3618 String)
(declare-const var850 String)
(declare-const var850!1 String)
(declare-const var1469!1 String)
(declare-const var817!1 var3225)
(define-const var2794 (Array Int ClassObject) arr-ClassObject-init) ; Statement: $r29 = newarray (java.lang.reflect.Type)[2] 
(define-const var780 ClassObject (returnClass/639256687 var2391!6)) ; Statement: $r30 = r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.Class returnClass> 
(declare-const var2794!1 (Array Int ClassObject))
(assert (not (= var2794!1 null-__Array__Int__ClassObject__)))
(assert (= (select var2794!1 0) (cast-from-ClassObject-to-ClassObject var780))) ; Statement: $r29[0] = $r30 
(define-const var2408 ClassObject (returnClass/639256687 var2391!6)) ; Statement: $r31 = r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.Class returnClass> 
(declare-const var2794!2 (Array Int ClassObject))
(assert (not (= var2794!2 null-__Array__Int__ClassObject__)))
(assert (= (select var2794!2 1) (cast-from-ClassObject-to-ClassObject var2408))) ; Statement: $r29[1] = $r31 
(define-const var3523 (Array Int ClassObject) var2794!2) ; Statement: r32 = $r29 
(assert true) ; Non Conditional
(declare-const var2391!7 var2353)
(assert (not (= var2391!7 null-var2353)))
(assert (= (returnTypes/639256687 var2391!7) var3523)) ; Statement: r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.reflect.Type[] returnTypes> = r32 
(define-const var2680 (Array Int ClassObject) (parameterClasses/639256687 var2391!7)) ; Statement: $r6 = r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.Class[] parameterClasses> 
(define-const var451 String (var3793_getDesc/-2047538545 var2680)) ; Statement: $r7 = staticinvoke <org.apache.dubbo.common.utils.ReflectUtils: java.lang.String getDesc(java.lang.Class[])>($r6) 
(declare-const var2391!8 var2353)
(assert (not (= var2391!8 null-var2353)))
(assert (= (paramDesc/639256687 var2391!8) var451)) ; Statement: r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.String paramDesc> = $r7 
(define-const var937 (Array Int ClassObject) (parameterClasses/639256687 var2391!8)) ; Statement: $r8 = r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.Class[] parameterClasses> 
(define-const var3484 var1078 (var1078_of/184955601 (cast-from-__Array__Int__ClassObject__-to-__Array__Int__var91__ var937))) ; Statement: $r10 = staticinvoke <java.util.stream.Stream: java.util.stream.Stream of(java.lang.Object[])>($r8) 
(define-const var2457 var42 var3224_bootstrap$/-276343291) ; Statement: $r9 = staticinvoke <org.apache.dubbo.rpc.model.ReflectionMethodDescriptor$getName__428: java.util.function.Function bootstrap$()>() 
(define-const var3579 var1078 (var1078_map/130902797 var3484 var2457)) ; Statement: $r12 = interfaceinvoke $r10.<java.util.stream.Stream: java.util.stream.Stream map(java.util.function.Function)>($r9) 
(define-const var866 var2204 var1624_bootstrap$/1633046284) ; Statement: $r11 = staticinvoke <org.apache.dubbo.rpc.model.ReflectionMethodDescriptor$lambda_new_0__437: java.util.function.IntFunction bootstrap$()>() 
(define-const var493 (Array Int var91) (var1078_toArray/-73424125 var3579 var866)) ; Statement: $r13 = interfaceinvoke $r12.<java.util.stream.Stream: java.lang.Object[] toArray(java.util.function.IntFunction)>($r11) 
(define-const var2902 (Array Int String) (cast-from-__Array__Int__var91__-to-__Array__Int__String__ var493)) ; Statement: $r14 = (java.lang.String[]) $r13 
(declare-const var2391!9 var2353)
(assert (not (= var2391!9 null-var2353)))
(assert (= (compatibleParamSignatures/639256687 var2391!9) var2902)) ; Statement: r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.String[] compatibleParamSignatures> = $r14 
(define-const var2141 String (methodName/639256687 var2391!9)) ; Statement: $r15 = r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.String methodName> 
(assert true)
(define-const var1754 Bool (= var2141 "$invoke")) ; Statement: $z0 = virtualinvoke $r15.<java.lang.String: boolean equals(java.lang.Object)>("$invoke") 
 ; Statement: if $z0 != 0 goto $r16 = r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.Class[] parameterClasses> 
(assert (not (= (ite var1754 1 0) 0))) ; Cond: $z0 != 0 
(define-const var3880 (Array Int ClassObject) (parameterClasses/639256687 var2391!9)) ; Statement: $r16 = r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.Class[] parameterClasses> 
(define-const var2249 Int (getLength-Arr-ClassObject-1 var3880)) ; Statement: $i0 = lengthof $r16 
 ; Statement: if $i0 != 3 goto $z2 = 0 
(assert (not (= var2249 3))) ; Cond: $i0 != 3 
(define-const var869 Bool (ite (= 1 0) true false)) ; Statement: $z2 = 0 
(assert true) ; Non Conditional
(declare-const var2391!10 var2353)
(assert (not (= var2391!10 null-var2353)))
(assert (= (generic/639256687 var2391!10) var869)) ; Statement: r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: boolean generic> = $z2 
(assert true)
(define-const var1886 var2230 (determineRpcType/1716683319 var2391!10)) ; Statement: $r33 = specialinvoke r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: org.apache.dubbo.rpc.model.MethodDescriptor$RpcType determineRpcType()>() 
(declare-const var2391!11 var2353)
(assert (not (= var2391!11 null-var2353)))
(assert (= (rpcType/639256687 var2391!11) var1886)) ; Statement: r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: org.apache.dubbo.rpc.model.MethodDescriptor$RpcType rpcType> = $r33 
 ; Statement: return 
(check-sat)
; {<init>/-279557996=([java.lang.Object], void), cast-from-var2353-to-var91=([org.apache.dubbo.rpc.model.ReflectionMethodDescriptor], java.lang.Object), var12-init=([], java.util.concurrent.ConcurrentHashMap), <init>/-2175807=([java.util.concurrent.ConcurrentHashMap], void), cast-from-var12-to-var3130=([java.util.concurrent.ConcurrentHashMap], java.util.concurrent.ConcurrentMap), attributeMap/639256687=([org.apache.dubbo.rpc.model.ReflectionMethodDescriptor], java.util.concurrent.ConcurrentMap), method/639256687=([org.apache.dubbo.rpc.model.ReflectionMethodDescriptor], java.lang.reflect.Method), getName/1227988463=([java.lang.reflect.Method], java.lang.String), methodName/639256687=([org.apache.dubbo.rpc.model.ReflectionMethodDescriptor], java.lang.String), getParameterTypes/827748249=([java.lang.reflect.Method], java.lang.Class[]), parameterClasses/639256687=([org.apache.dubbo.rpc.model.ReflectionMethodDescriptor], java.lang.Class[]), getReturnType/-1494237887=([java.lang.reflect.Method], java.lang.Class), returnClass/639256687=([org.apache.dubbo.rpc.model.ReflectionMethodDescriptor], java.lang.Class), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getDeclaringClass/501867354=([java.lang.reflect.Method], java.lang.Class), getName/-1958580599=([java.lang.Class], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var564_error/377575788=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void), arr-ClassObject-init=([], java.lang.reflect.Type[]), cast-from-ClassObject-to-ClassObject=([java.lang.Class], java.lang.reflect.Type), returnTypes/639256687=([org.apache.dubbo.rpc.model.ReflectionMethodDescriptor], java.lang.reflect.Type[]), var3793_getDesc/-2047538545=([java.lang.Class[]], java.lang.String), paramDesc/639256687=([org.apache.dubbo.rpc.model.ReflectionMethodDescriptor], java.lang.String), var1078_of/184955601=([java.lang.Object[]], java.util.stream.Stream), cast-from-__Array__Int__ClassObject__-to-__Array__Int__var91__=([java.lang.Class[]], java.lang.Object[]), var3224_bootstrap$/-276343291=([], java.util.function.Function), var1078_map/130902797=([java.util.stream.Stream, java.util.function.Function], java.util.stream.Stream), var1624_bootstrap$/1633046284=([], java.util.function.IntFunction), var1078_toArray/-73424125=([java.util.stream.Stream, java.util.function.IntFunction], java.lang.Object[]), cast-from-__Array__Int__var91__-to-__Array__Int__String__=([java.lang.Object[]], java.lang.String[]), compatibleParamSignatures/639256687=([org.apache.dubbo.rpc.model.ReflectionMethodDescriptor], java.lang.String[]), getLength-Arr-ClassObject-1=([java.lang.Class[]], int), generic/639256687=([org.apache.dubbo.rpc.model.ReflectionMethodDescriptor], boolean), determineRpcType/1716683319=([org.apache.dubbo.rpc.model.ReflectionMethodDescriptor], org.apache.dubbo.rpc.model.MethodDescriptor$RpcType), rpcType/639256687=([org.apache.dubbo.rpc.model.ReflectionMethodDescriptor], org.apache.dubbo.rpc.model.MethodDescriptor$RpcType)}
; {var2353=org.apache.dubbo.rpc.model.ReflectionMethodDescriptor, var2391=r0, var3911=java.lang.reflect.Method, var2766=r2, var91=java.lang.Object, var12=java.util.concurrent.ConcurrentHashMap, var1430=$r1, var3130=java.util.concurrent.ConcurrentMap, var3776=$r3, var743=$r4, var800=$r5, var3225=java.lang.Throwable, var817=$r18, var564=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var976=$r20, var1925=$r19, var1174=$r22, var2583=$r21, var1908=$r23, var148=$r26, var1724=$r24, var727=$r25, var204=$r27, var1469=$r28, var3618="0-8", var850="", var2794=$r29, var780=$r30, var2408=$r31, var3523=r32, var2680=$r6, var3793=org.apache.dubbo.common.utils.ReflectUtils, var451=$r7, var937=$r8, var1078=java.util.stream.Stream, var3484=$r10, var42=java.util.function.Function, var3224=org.apache.dubbo.rpc.model.ReflectionMethodDescriptor$getName__428, var2457=$r9, var3579=$r12, var2204=java.util.function.IntFunction, var1624=org.apache.dubbo.rpc.model.ReflectionMethodDescriptor$lambda_new_0__437, var866=$r11, var493=$r13, var2902=$r14, var2141=$r15, var1754=$z0, var3880=$r16, var2249=$i0, var869=$z2, var2230=org.apache.dubbo.rpc.model.MethodDescriptor$RpcType, var1886=$r33}
; {org.apache.dubbo.rpc.model.ReflectionMethodDescriptor=var2353, r0=var2391, java.lang.reflect.Method=var3911, r2=var2766, java.lang.Object=var91, java.util.concurrent.ConcurrentHashMap=var12, $r1=var1430, java.util.concurrent.ConcurrentMap=var3130, $r3=var3776, $r4=var743, $r5=var800, java.lang.Throwable=var3225, $r18=var817, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var564, $r20=var976, $r19=var1925, $r22=var1174, $r21=var2583, $r23=var1908, $r26=var148, $r24=var1724, $r25=var727, $r27=var204, $r28=var1469, "0-8"=var3618, ""=var850, $r29=var2794, $r30=var780, $r31=var2408, r32=var3523, $r6=var2680, org.apache.dubbo.common.utils.ReflectUtils=var3793, $r7=var451, $r8=var937, java.util.stream.Stream=var1078, $r10=var3484, java.util.function.Function=var42, org.apache.dubbo.rpc.model.ReflectionMethodDescriptor$getName__428=var3224, $r9=var2457, $r12=var3579, java.util.function.IntFunction=var2204, org.apache.dubbo.rpc.model.ReflectionMethodDescriptor$lambda_new_0__437=var1624, $r11=var866, $r13=var493, $r14=var2902, $r15=var2141, $z0=var1754, $r16=var3880, $i0=var2249, $z2=var869, org.apache.dubbo.rpc.model.MethodDescriptor$RpcType=var2230, $r33=var1886}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.String toString()>": 1,"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.model.ReflectionMethodDescriptor;	r2 := @parameter0: java.lang.reflect.Method;	specialinvoke r0.<java.lang.Object: void <init>()>();	$r1 = new java.util.concurrent.ConcurrentHashMap;	specialinvoke $r1.<java.util.concurrent.ConcurrentHashMap: void <init>()>();	r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.util.concurrent.ConcurrentMap attributeMap> = $r1;	r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.reflect.Method method> = r2;	$r3 = virtualinvoke r2.<java.lang.reflect.Method: java.lang.String getName()>();	r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.String methodName> = $r3;	$r4 = virtualinvoke r2.<java.lang.reflect.Method: java.lang.Class[] getParameterTypes()>();	r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.Class[] parameterClasses> = $r4;	$r5 = virtualinvoke r2.<java.lang.reflect.Method: java.lang.Class getReturnType()>();	r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.Class returnClass> = $r5;	$r18 := @caughtexception;	$r20 = <org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r19 = new java.lang.StringBuilder;	specialinvoke $r19.<java.lang.StringBuilder: void <init>()>();	$r22 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("fail to get return types. Method name: ");	$r21 = r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.String methodName>;	$r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r21);	$r26 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" Declaring class:");	$r24 = virtualinvoke r2.<java.lang.reflect.Method: java.lang.Class getDeclaringClass()>();	$r25 = virtualinvoke $r24.<java.lang.Class: java.lang.String getName()>();	$r27 = virtualinvoke $r26.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r25);	$r28 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r20.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("0-8", "", "", $r28, $r18);	$r29 = newarray (java.lang.reflect.Type)[2];	$r30 = r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.Class returnClass>;	$r29[0] = $r30;	$r31 = r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.Class returnClass>;	$r29[1] = $r31;	r32 = $r29;	r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.reflect.Type[] returnTypes> = r32;	$r6 = r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.Class[] parameterClasses>;	$r7 = staticinvoke <org.apache.dubbo.common.utils.ReflectUtils: java.lang.String getDesc(java.lang.Class[])>($r6);	r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.String paramDesc> = $r7;	$r8 = r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.Class[] parameterClasses>;	$r10 = staticinvoke <java.util.stream.Stream: java.util.stream.Stream of(java.lang.Object[])>($r8);	$r9 = staticinvoke <org.apache.dubbo.rpc.model.ReflectionMethodDescriptor$getName__428: java.util.function.Function bootstrap$()>();	$r12 = interfaceinvoke $r10.<java.util.stream.Stream: java.util.stream.Stream map(java.util.function.Function)>($r9);	$r11 = staticinvoke <org.apache.dubbo.rpc.model.ReflectionMethodDescriptor$lambda_new_0__437: java.util.function.IntFunction bootstrap$()>();	$r13 = interfaceinvoke $r12.<java.util.stream.Stream: java.lang.Object[] toArray(java.util.function.IntFunction)>($r11);	$r14 = (java.lang.String[]) $r13;	r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.String[] compatibleParamSignatures> = $r14;	$r15 = r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.String methodName>;	$z0 = virtualinvoke $r15.<java.lang.String: boolean equals(java.lang.Object)>("$invoke");	if $z0 != 0 goto $r16 = r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.Class[] parameterClasses>;	$r16 = r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.Class[] parameterClasses>;	$i0 = lengthof $r16;	if $i0 != 3 goto $z2 = 0;	$z2 = 0;	r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: boolean generic> = $z2;	$r33 = specialinvoke r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: org.apache.dubbo.rpc.model.MethodDescriptor$RpcType determineRpcType()>();	r0.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: org.apache.dubbo.rpc.model.MethodDescriptor$RpcType rpcType> = $r33;	return
;block_num 6