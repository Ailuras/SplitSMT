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

(declare-sort var3537 0)
(declare-sort var3551 0)
(declare-sort var959 0)
(declare-sort var1517 0)
(declare-sort var339 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var3551) String)
(declare-fun cast-from-ClassObject-to-var3551 (ClassObject) var3551)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var339_error/377575788 (var339 String String String String var1517) void)
(declare-const null-var3537 var3537)
(declare-const null-var3551 var3551)
(declare-const null-ClassObject ClassObject)
(declare-const null-var959 var959)
(declare-const null-var1517 var1517)
(declare-const var3537-logger var339)
(declare-const var1621 var3537) ; Statement: r5 := @this: org.apache.dubbo.rpc.proxy.javassist.JavassistProxyFactory 
(assert (not (= var1621 null-var3537)))
(declare-const var2661 var3551) ; Statement: r0 := @parameter0: java.lang.Object 
(assert (not (= var2661 null-var3551)))
(declare-const var3256 ClassObject) ; Statement: r3 := @parameter1: java.lang.Class 
(assert (not (= var3256 null-ClassObject)))
(declare-const var1447 var959) ; Statement: r6 := @parameter2: org.apache.dubbo.common.URL 
(assert (not (= var1447 null-var959)))
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var1805 var1517) ; Statement: $r21 := @caughtexception 
(assert (not (= var1805 null-var1517)))
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var3902 var1517) ; Statement: $r8 := @caughtexception 
(assert (not (= var3902 null-var1517)))
(define-const var2207 var339 var3537-logger) ; Statement: $r10 = <org.apache.dubbo.rpc.proxy.javassist.JavassistProxyFactory: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var3238 String String-init) ; Statement: $r9 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3238)) ; Statement: specialinvoke $r9.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3238!1 String)
(assert (= var3238!1 ""))
(assert true)
(define-const var1576 String (append/672562846 var3238!1 "Failed to generate invoker by Javassist failed. Fallback to use JDK proxy is also failed. Interfaces: ")) ; Statement: $r11 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to generate invoker by Javassist failed. Fallback to use JDK proxy is also failed. Interfaces: ") 
(declare-const var3238!2 String)
(assert (= var3238!2 (str.++ var3238!1 "Failed to generate invoker by Javassist failed. Fallback to use JDK proxy is also failed. Interfaces: ")))
(assert true)
(define-const var1527 String (append/-1031950772 var1576 (cast-from-ClassObject-to-var3551 var3256))) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r3) 
(declare-const var1576!1 String)
(assert (str.prefixof var1576 var1576!1))
(assert true)
(define-const var3967 String (append/672562846 var1527 " Javassist Error.")) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" Javassist Error.") 
(declare-const var1527!1 String)
(assert (= var1527!1 (str.++ var1527 " Javassist Error.")))
(assert true)
(define-const var1051 String (toString/-2075883882 var3967)) ; Statement: $r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var339_error/377575788 var2207 "3-8" "" "" var1051 var1805)) ; Statement: interfaceinvoke $r10.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("3-8", "", "", $r14, $r21) 

(declare-const var2207!1 var339)
(declare-const var331 String)
(declare-const var1434 String)
(declare-const var1434!1 String)
(declare-const var1051!1 String)
(declare-const var1805!1 var1517)
(define-const var3011 var339 var3537-logger) ; Statement: $r16 = <org.apache.dubbo.rpc.proxy.javassist.JavassistProxyFactory: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var1815 String String-init) ; Statement: $r15 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1815)) ; Statement: specialinvoke $r15.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1815!1 String)
(assert (= var1815!1 ""))
(assert true)
(define-const var2100 String (append/672562846 var1815!1 "Failed to generate invoker by Javassist failed. Fallback to use JDK proxy is also failed. Interfaces: ")) ; Statement: $r17 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to generate invoker by Javassist failed. Fallback to use JDK proxy is also failed. Interfaces: ") 
(declare-const var1815!2 String)
(assert (= var1815!2 (str.++ var1815!1 "Failed to generate invoker by Javassist failed. Fallback to use JDK proxy is also failed. Interfaces: ")))
(assert true)
(define-const var874 String (append/-1031950772 var2100 (cast-from-ClassObject-to-var3551 var3256))) ; Statement: $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r3) 
(declare-const var2100!1 String)
(assert (str.prefixof var2100 var2100!1))
(assert true)
(define-const var2813 String (append/672562846 var874 " JDK Error.")) ; Statement: $r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" JDK Error.") 
(declare-const var874!1 String)
(assert (= var874!1 (str.++ var874 " JDK Error.")))
(assert true)
(define-const var1947 String (toString/-2075883882 var2813)) ; Statement: $r20 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var339_error/377575788 var3011 "3-8" "" "" var1947 var3902)) ; Statement: interfaceinvoke $r16.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("3-8", "", "", $r20, $r8) 

(declare-const var3011!1 var339)
(declare-const var331!1 String)
(declare-const var1434!2 String)
(declare-const var1434!3 String)
(declare-const var1947!1 String)
(declare-const var3902!1 var1517)
 ; Statement: throw $r21 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-ClassObject-to-var3551=([java.lang.Class], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var339_error/377575788=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void)}
; {var3537=org.apache.dubbo.rpc.proxy.javassist.JavassistProxyFactory, var1621=r5, var3551=java.lang.Object, var2661=r0, var3256=r3, var959=org.apache.dubbo.common.URL, var1447=r6, var1517=java.lang.Throwable, var1805=$r21, var3902=$r8, var339=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var2207=$r10, var3238=$r9, var1576=$r11, var1527=$r12, var3967=$r13, var1051=$r14, var331="3-8", var1434="", var3011=$r16, var1815=$r15, var2100=$r17, var874=$r18, var2813=$r19, var1947=$r20}
; {org.apache.dubbo.rpc.proxy.javassist.JavassistProxyFactory=var3537, r5=var1621, java.lang.Object=var3551, r0=var2661, r3=var3256, org.apache.dubbo.common.URL=var959, r6=var1447, java.lang.Throwable=var1517, $r21=var1805, $r8=var3902, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var339, $r10=var2207, $r9=var3238, $r11=var1576, $r12=var1527, $r13=var3967, $r14=var1051, "3-8"=var331, ""=var1434, $r16=var3011, $r15=var1815, $r17=var2100, $r18=var874, $r19=var2813, $r20=var1947}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 2}
;stmts r5 := @this: org.apache.dubbo.rpc.proxy.javassist.JavassistProxyFactory;	r0 := @parameter0: java.lang.Object;	r3 := @parameter1: java.lang.Class;	r6 := @parameter2: org.apache.dubbo.common.URL;	$r21 := @caughtexception;	$r8 := @caughtexception;	$r10 = <org.apache.dubbo.rpc.proxy.javassist.JavassistProxyFactory: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r9 = new java.lang.StringBuilder;	specialinvoke $r9.<java.lang.StringBuilder: void <init>()>();	$r11 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to generate invoker by Javassist failed. Fallback to use JDK proxy is also failed. Interfaces: ");	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r3);	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" Javassist Error.");	$r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r10.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("3-8", "", "", $r14, $r21);	$r16 = <org.apache.dubbo.rpc.proxy.javassist.JavassistProxyFactory: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r15 = new java.lang.StringBuilder;	specialinvoke $r15.<java.lang.StringBuilder: void <init>()>();	$r17 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to generate invoker by Javassist failed. Fallback to use JDK proxy is also failed. Interfaces: ");	$r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r3);	$r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" JDK Error.");	$r20 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r16.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("3-8", "", "", $r20, $r8);	throw $r21
;block_num 3