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

(declare-sort var1841 0)
(declare-sort var1534 0)
(declare-sort var3102 0)
(declare-sort var1244 0)
(declare-sort var3642 0)
(declare-sort var3793 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getClass/1258963082 (var1244) ClassObject)
(declare-fun cast-from-var1841-to-var1244 (var1841) var1244)
(declare-fun getSimpleName/-390194377 (ClassObject) String)
(declare-fun logger/159573722 (var1841) var3642)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var3793_toString/-575966009 ((Array Int var1244)) String)
(declare-fun cast-from-__Array__Int__ClassObject__-to-__Array__Int__var1244__ ((Array Int ClassObject)) (Array Int var1244))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var3642_error/377575788 (var3642 String String String String var3102) void)
(declare-const null-var1841 var1841)
(declare-const null-var1534 var1534)
(declare-const null-__Array__Int__ClassObject__ (Array Int ClassObject))
(declare-const null-var3102 var3102)
(declare-const var1981 var1841) ; Statement: r0 := @this: org.apache.dubbo.rpc.proxy.AbstractFallbackJdkProxyFactory 
(assert (not (= var1981 null-var1841)))
(declare-const var661 var1534) ; Statement: r1 := @parameter0: org.apache.dubbo.rpc.Invoker 
(assert (not (= var661 null-var1534)))
(declare-const var1650 (Array Int ClassObject)) ; Statement: r2 := @parameter1: java.lang.Class[] 
(assert (not (= var1650 null-__Array__Int__ClassObject__)))
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var6 var3102) ; Statement: $r24 := @caughtexception 
(assert (not (= var6 null-var3102)))
(assert true)
(define-const var1578 ClassObject (getClass/1258963082 (cast-from-var1841-to-var1244 var1981))) ; Statement: $r25 = virtualinvoke r0.<java.lang.Object: java.lang.Class getClass()>() 
(assert true)
(define-const var1492 String (getSimpleName/-390194377 var1578)) ; Statement: r7 = virtualinvoke $r25.<java.lang.Class: java.lang.String getSimpleName()>() 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var3202 var3102) ; Statement: $r4 := @caughtexception 
(assert (not (= var3202 null-var3102)))
(define-const var3802 var3642 (logger/159573722 var1981)) ; Statement: $r6 = r0.<org.apache.dubbo.rpc.proxy.AbstractFallbackJdkProxyFactory: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var1195 String String-init) ; Statement: $r5 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1195)) ; Statement: specialinvoke $r5.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1195!1 String)
(assert (= var1195!1 ""))
(assert true)
(define-const var2686 String (append/672562846 var1195!1 "Failed to generate proxy by ")) ; Statement: $r8 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to generate proxy by ") 
(declare-const var1195!2 String)
(assert (= var1195!2 (str.++ var1195!1 "Failed to generate proxy by ")))
(assert true)
(define-const var1457 String (append/672562846 var2686 var1492)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r7) 
(declare-const var2686!1 String)
(assert (= var2686!1 (str.++ var2686 var1492)))
(assert true)
(define-const var3578 String (append/672562846 var1457 " failed. Fallback to use JDK proxy is also failed. Interfaces: ")) ; Statement: $r11 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" failed. Fallback to use JDK proxy is also failed. Interfaces: ") 
(declare-const var1457!1 String)
(assert (= var1457!1 (str.++ var1457 " failed. Fallback to use JDK proxy is also failed. Interfaces: ")))
(define-const var2112 String (var3793_toString/-575966009 (cast-from-__Array__Int__ClassObject__-to-__Array__Int__var1244__ var1650))) ; Statement: $r10 = staticinvoke <java.util.Arrays: java.lang.String toString(java.lang.Object[])>(r2) 
(assert true)
(define-const var3972 String (append/672562846 var3578 var2112)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r10) 
(declare-const var3578!1 String)
(assert (= var3578!1 (str.++ var3578 var2112)))
(assert true)
(define-const var867 String (append/672562846 var3972 " Javassist Error.")) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" Javassist Error.") 
(declare-const var3972!1 String)
(assert (= var3972!1 (str.++ var3972 " Javassist Error.")))
(assert true)
(define-const var2830 String (toString/-2075883882 var867)) ; Statement: $r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var3642_error/377575788 var3802 "3-8" "" "" var2830 var6)) ; Statement: interfaceinvoke $r6.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("3-8", "", "", $r14, $r24) 

(declare-const var3802!1 var3642)
(declare-const var1820 String)
(declare-const var1842 String)
(declare-const var1842!1 String)
(declare-const var2830!1 String)
(declare-const var6!1 var3102)
(define-const var1064 var3642 (logger/159573722 var1981)) ; Statement: $r16 = r0.<org.apache.dubbo.rpc.proxy.AbstractFallbackJdkProxyFactory: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var2864 String String-init) ; Statement: $r15 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2864)) ; Statement: specialinvoke $r15.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2864!1 String)
(assert (= var2864!1 ""))
(assert true)
(define-const var1855 String (append/672562846 var2864!1 "Failed to generate proxy by ")) ; Statement: $r17 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to generate proxy by ") 
(declare-const var2864!2 String)
(assert (= var2864!2 (str.++ var2864!1 "Failed to generate proxy by ")))
(assert true)
(define-const var3339 String (append/672562846 var1855 var1492)) ; Statement: $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r7) 
(declare-const var1855!1 String)
(assert (= var1855!1 (str.++ var1855 var1492)))
(assert true)
(define-const var2824 String (append/672562846 var3339 " failed. Fallback to use JDK proxy is also failed. Interfaces: ")) ; Statement: $r20 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" failed. Fallback to use JDK proxy is also failed. Interfaces: ") 
(declare-const var3339!1 String)
(assert (= var3339!1 (str.++ var3339 " failed. Fallback to use JDK proxy is also failed. Interfaces: ")))
(define-const var758 String (var3793_toString/-575966009 (cast-from-__Array__Int__ClassObject__-to-__Array__Int__var1244__ var1650))) ; Statement: $r19 = staticinvoke <java.util.Arrays: java.lang.String toString(java.lang.Object[])>(r2) 
(assert true)
(define-const var1013 String (append/672562846 var2824 var758)) ; Statement: $r21 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r19) 
(declare-const var2824!1 String)
(assert (= var2824!1 (str.++ var2824 var758)))
(assert true)
(define-const var1506 String (append/672562846 var1013 " JDK Error.")) ; Statement: $r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" JDK Error.") 
(declare-const var1013!1 String)
(assert (= var1013!1 (str.++ var1013 " JDK Error.")))
(assert true)
(define-const var2200 String (toString/-2075883882 var1506)) ; Statement: $r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var3642_error/377575788 var1064 "3-8" "" "" var2200 var3202)) ; Statement: interfaceinvoke $r16.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("3-8", "", "", $r23, $r4) 

(declare-const var1064!1 var3642)
(declare-const var1820!1 String)
(declare-const var1842!2 String)
(declare-const var1842!3 String)
(declare-const var2200!1 String)
(declare-const var3202!1 var3102)
 ; Statement: throw $r24 
(check-sat)
; {getClass/1258963082=([java.lang.Object], java.lang.Class), cast-from-var1841-to-var1244=([org.apache.dubbo.rpc.proxy.AbstractFallbackJdkProxyFactory], java.lang.Object), getSimpleName/-390194377=([java.lang.Class], java.lang.String), logger/159573722=([org.apache.dubbo.rpc.proxy.AbstractFallbackJdkProxyFactory], org.apache.dubbo.common.logger.ErrorTypeAwareLogger), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var3793_toString/-575966009=([java.lang.Object[]], java.lang.String), cast-from-__Array__Int__ClassObject__-to-__Array__Int__var1244__=([java.lang.Class[]], java.lang.Object[]), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var3642_error/377575788=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void)}
; {var1841=org.apache.dubbo.rpc.proxy.AbstractFallbackJdkProxyFactory, var1981=r0, var1534=org.apache.dubbo.rpc.Invoker, var661=r1, var1650=r2, var3102=java.lang.Throwable, var6=$r24, var1244=java.lang.Object, var1578=$r25, var1492=r7, var3202=$r4, var3642=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var3802=$r6, var1195=$r5, var2686=$r8, var1457=$r9, var3578=$r11, var3793=java.util.Arrays, var2112=$r10, var3972=$r12, var867=$r13, var2830=$r14, var1820="3-8", var1842="", var1064=$r16, var2864=$r15, var1855=$r17, var3339=$r18, var2824=$r20, var758=$r19, var1013=$r21, var1506=$r22, var2200=$r23}
; {org.apache.dubbo.rpc.proxy.AbstractFallbackJdkProxyFactory=var1841, r0=var1981, org.apache.dubbo.rpc.Invoker=var1534, r1=var661, r2=var1650, java.lang.Throwable=var3102, $r24=var6, java.lang.Object=var1244, $r25=var1578, r7=var1492, $r4=var3202, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var3642, $r6=var3802, $r5=var1195, $r8=var2686, $r9=var1457, $r11=var3578, java.util.Arrays=var3793, $r10=var2112, $r12=var3972, $r13=var867, $r14=var2830, "3-8"=var1820, ""=var1842, $r16=var1064, $r15=var2864, $r17=var1855, $r18=var3339, $r20=var2824, $r19=var758, $r21=var1013, $r22=var1506, $r23=var2200}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.util.Arrays: java.lang.String toString(java.lang.Object[])>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.util.Arrays: java.lang.String toString(java.lang.Object[])>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 10,"<java.lang.StringBuilder: java.lang.String toString()>": 2}
;stmts r0 := @this: org.apache.dubbo.rpc.proxy.AbstractFallbackJdkProxyFactory;	r1 := @parameter0: org.apache.dubbo.rpc.Invoker;	r2 := @parameter1: java.lang.Class[];	$r24 := @caughtexception;	$r25 = virtualinvoke r0.<java.lang.Object: java.lang.Class getClass()>();	r7 = virtualinvoke $r25.<java.lang.Class: java.lang.String getSimpleName()>();	$r4 := @caughtexception;	$r6 = r0.<org.apache.dubbo.rpc.proxy.AbstractFallbackJdkProxyFactory: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r5 = new java.lang.StringBuilder;	specialinvoke $r5.<java.lang.StringBuilder: void <init>()>();	$r8 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to generate proxy by ");	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r7);	$r11 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" failed. Fallback to use JDK proxy is also failed. Interfaces: ");	$r10 = staticinvoke <java.util.Arrays: java.lang.String toString(java.lang.Object[])>(r2);	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r10);	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" Javassist Error.");	$r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r6.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("3-8", "", "", $r14, $r24);	$r16 = r0.<org.apache.dubbo.rpc.proxy.AbstractFallbackJdkProxyFactory: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r15 = new java.lang.StringBuilder;	specialinvoke $r15.<java.lang.StringBuilder: void <init>()>();	$r17 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to generate proxy by ");	$r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r7);	$r20 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" failed. Fallback to use JDK proxy is also failed. Interfaces: ");	$r19 = staticinvoke <java.util.Arrays: java.lang.String toString(java.lang.Object[])>(r2);	$r21 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r19);	$r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" JDK Error.");	$r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r16.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("3-8", "", "", $r23, $r4);	throw $r24
;block_num 3