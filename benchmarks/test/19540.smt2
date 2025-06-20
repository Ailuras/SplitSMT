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

(declare-sort var2713 0)
(declare-sort var2811 0)
(declare-sort var2824 0)
(declare-sort var2622 0)
(declare-sort var2380 0)
(declare-sort var1789 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var2380_toString/-575966009 ((Array Int var1789)) String)
(declare-fun cast-from-__Array__Int__ClassObject__-to-__Array__Int__var1789__ ((Array Int ClassObject)) (Array Int var1789))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var2622_error/377575788 (var2622 String String String String var2824) void)
(declare-const null-var2713 var2713)
(declare-const null-var2811 var2811)
(declare-const null-__Array__Int__ClassObject__ (Array Int ClassObject))
(declare-const null-var2824 var2824)
(declare-const var2713-logger var2622)
(declare-const var3482 var2713) ; Statement: r21 := @this: org.apache.dubbo.rpc.proxy.javassist.JavassistProxyFactory 
(assert (not (= var3482 null-var2713)))
(declare-const var257 var2811) ; Statement: r2 := @parameter0: org.apache.dubbo.rpc.Invoker 
(assert (not (= var257 null-var2811)))
(declare-const var3193 (Array Int ClassObject)) ; Statement: r0 := @parameter1: java.lang.Class[] 
(assert (not (= var3193 null-__Array__Int__ClassObject__)))
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var3973 var2824) ; Statement: $r20 := @caughtexception 
(assert (not (= var3973 null-var2824)))
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var368 var2824) ; Statement: $r5 := @caughtexception 
(assert (not (= var368 null-var2824)))
(define-const var296 var2622 var2713-logger) ; Statement: $r7 = <org.apache.dubbo.rpc.proxy.javassist.JavassistProxyFactory: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var2093 String String-init) ; Statement: $r6 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2093)) ; Statement: specialinvoke $r6.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2093!1 String)
(assert (= var2093!1 ""))
(assert true)
(define-const var1299 String (append/672562846 var2093!1 "Failed to generate proxy by Javassist failed. Fallback to use JDK proxy is also failed. Interfaces: ")) ; Statement: $r9 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to generate proxy by Javassist failed. Fallback to use JDK proxy is also failed. Interfaces: ") 
(declare-const var2093!2 String)
(assert (= var2093!2 (str.++ var2093!1 "Failed to generate proxy by Javassist failed. Fallback to use JDK proxy is also failed. Interfaces: ")))
(define-const var42 String (var2380_toString/-575966009 (cast-from-__Array__Int__ClassObject__-to-__Array__Int__var1789__ var3193))) ; Statement: $r8 = staticinvoke <java.util.Arrays: java.lang.String toString(java.lang.Object[])>(r0) 
(assert true)
(define-const var2813 String (append/672562846 var1299 var42)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r8) 
(declare-const var1299!1 String)
(assert (= var1299!1 (str.++ var1299 var42)))
(assert true)
(define-const var2958 String (append/672562846 var2813 " Javassist Error.")) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" Javassist Error.") 
(declare-const var2813!1 String)
(assert (= var2813!1 (str.++ var2813 " Javassist Error.")))
(assert true)
(define-const var202 String (toString/-2075883882 var2958)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var2622_error/377575788 var296 "3-8" "" "" var202 var3973)) ; Statement: interfaceinvoke $r7.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("3-8", "", "", $r12, $r20) 

(declare-const var296!1 var2622)
(declare-const var2459 String)
(declare-const var655 String)
(declare-const var655!1 String)
(declare-const var202!1 String)
(declare-const var3973!1 var2824)
(define-const var1597 var2622 var2713-logger) ; Statement: $r14 = <org.apache.dubbo.rpc.proxy.javassist.JavassistProxyFactory: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var2838 String String-init) ; Statement: $r13 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2838)) ; Statement: specialinvoke $r13.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2838!1 String)
(assert (= var2838!1 ""))
(assert true)
(define-const var3934 String (append/672562846 var2838!1 "Failed to generate proxy by Javassist failed. Fallback to use JDK proxy is also failed. Interfaces: ")) ; Statement: $r16 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to generate proxy by Javassist failed. Fallback to use JDK proxy is also failed. Interfaces: ") 
(declare-const var2838!2 String)
(assert (= var2838!2 (str.++ var2838!1 "Failed to generate proxy by Javassist failed. Fallback to use JDK proxy is also failed. Interfaces: ")))
(define-const var3666 String (var2380_toString/-575966009 (cast-from-__Array__Int__ClassObject__-to-__Array__Int__var1789__ var3193))) ; Statement: $r15 = staticinvoke <java.util.Arrays: java.lang.String toString(java.lang.Object[])>(r0) 
(assert true)
(define-const var1585 String (append/672562846 var3934 var3666)) ; Statement: $r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r15) 
(declare-const var3934!1 String)
(assert (= var3934!1 (str.++ var3934 var3666)))
(assert true)
(define-const var3355 String (append/672562846 var1585 " JDK Error.")) ; Statement: $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" JDK Error.") 
(declare-const var1585!1 String)
(assert (= var1585!1 (str.++ var1585 " JDK Error.")))
(assert true)
(define-const var53 String (toString/-2075883882 var3355)) ; Statement: $r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var2622_error/377575788 var1597 "3-8" "" "" var53 var368)) ; Statement: interfaceinvoke $r14.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("3-8", "", "", $r19, $r5) 

(declare-const var1597!1 var2622)
(declare-const var2459!1 String)
(declare-const var655!2 String)
(declare-const var655!3 String)
(declare-const var53!1 String)
(declare-const var368!1 var2824)
 ; Statement: throw $r20 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var2380_toString/-575966009=([java.lang.Object[]], java.lang.String), cast-from-__Array__Int__ClassObject__-to-__Array__Int__var1789__=([java.lang.Class[]], java.lang.Object[]), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var2622_error/377575788=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void)}
; {var2713=org.apache.dubbo.rpc.proxy.javassist.JavassistProxyFactory, var3482=r21, var2811=org.apache.dubbo.rpc.Invoker, var257=r2, var3193=r0, var2824=java.lang.Throwable, var3973=$r20, var368=$r5, var2622=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var296=$r7, var2093=$r6, var1299=$r9, var2380=java.util.Arrays, var1789=java.lang.Object, var42=$r8, var2813=$r10, var2958=$r11, var202=$r12, var2459="3-8", var655="", var1597=$r14, var2838=$r13, var3934=$r16, var3666=$r15, var1585=$r17, var3355=$r18, var53=$r19}
; {org.apache.dubbo.rpc.proxy.javassist.JavassistProxyFactory=var2713, r21=var3482, org.apache.dubbo.rpc.Invoker=var2811, r2=var257, r0=var3193, java.lang.Throwable=var2824, $r20=var3973, $r5=var368, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var2622, $r7=var296, $r6=var2093, $r9=var1299, java.util.Arrays=var2380, java.lang.Object=var1789, $r8=var42, $r10=var2813, $r11=var2958, $r12=var202, "3-8"=var2459, ""=var655, $r14=var1597, $r13=var2838, $r16=var3934, $r15=var3666, $r17=var1585, $r18=var3355, $r19=var53}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.util.Arrays: java.lang.String toString(java.lang.Object[])>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.util.Arrays: java.lang.String toString(java.lang.Object[])>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 6,"<java.lang.StringBuilder: java.lang.String toString()>": 2}
;stmts r21 := @this: org.apache.dubbo.rpc.proxy.javassist.JavassistProxyFactory;	r2 := @parameter0: org.apache.dubbo.rpc.Invoker;	r0 := @parameter1: java.lang.Class[];	$r20 := @caughtexception;	$r5 := @caughtexception;	$r7 = <org.apache.dubbo.rpc.proxy.javassist.JavassistProxyFactory: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r6 = new java.lang.StringBuilder;	specialinvoke $r6.<java.lang.StringBuilder: void <init>()>();	$r9 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to generate proxy by Javassist failed. Fallback to use JDK proxy is also failed. Interfaces: ");	$r8 = staticinvoke <java.util.Arrays: java.lang.String toString(java.lang.Object[])>(r0);	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r8);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" Javassist Error.");	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r7.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("3-8", "", "", $r12, $r20);	$r14 = <org.apache.dubbo.rpc.proxy.javassist.JavassistProxyFactory: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r13 = new java.lang.StringBuilder;	specialinvoke $r13.<java.lang.StringBuilder: void <init>()>();	$r16 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to generate proxy by Javassist failed. Fallback to use JDK proxy is also failed. Interfaces: ");	$r15 = staticinvoke <java.util.Arrays: java.lang.String toString(java.lang.Object[])>(r0);	$r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r15);	$r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" JDK Error.");	$r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r14.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("3-8", "", "", $r19, $r5);	throw $r20
;block_num 3