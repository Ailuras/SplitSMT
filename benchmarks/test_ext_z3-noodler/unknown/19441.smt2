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

(declare-sort var2098 0)
(declare-sort var2005 0)
(declare-sort var2386 0)
(declare-sort var2690 0)
(declare-sort var3262 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getClass/1258963082 (var2005) ClassObject)
(declare-fun cast-from-var2098-to-var2005 (var2098) var2005)
(declare-fun getSimpleName/-390194377 (ClassObject) String)
(declare-fun logger/159573722 (var2098) var3262)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var2005) String)
(declare-fun cast-from-ClassObject-to-var2005 (ClassObject) var2005)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var3262_error/377575788 (var3262 String String String String var2690) void)
(declare-const null-var2098 var2098)
(declare-const null-var2005 var2005)
(declare-const null-ClassObject ClassObject)
(declare-const null-var2386 var2386)
(declare-const null-var2690 var2690)
(declare-const var3173 var2098) ; Statement: r0 := @this: org.apache.dubbo.rpc.proxy.AbstractFallbackJdkProxyFactory 
(assert (not (= var3173 null-var2098)))
(declare-const var3835 var2005) ; Statement: r1 := @parameter0: java.lang.Object 
(assert (not (= var3835 null-var2005)))
(declare-const var1280 ClassObject) ; Statement: r2 := @parameter1: java.lang.Class 
(assert (not (= var1280 null-ClassObject)))
(declare-const var691 var2386) ; Statement: r3 := @parameter2: org.apache.dubbo.common.URL 
(assert (not (= var691 null-var2386)))
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var863 var2690) ; Statement: $r23 := @caughtexception 
(assert (not (= var863 null-var2690)))
(assert true)
(define-const var2819 ClassObject (getClass/1258963082 (cast-from-var2098-to-var2005 var3173))) ; Statement: $r24 = virtualinvoke r0.<java.lang.Object: java.lang.Class getClass()>() 
(assert true)
(define-const var231 String (getSimpleName/-390194377 var2819)) ; Statement: r8 = virtualinvoke $r24.<java.lang.Class: java.lang.String getSimpleName()>() 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var3699 var2690) ; Statement: $r5 := @caughtexception 
(assert (not (= var3699 null-var2690)))
(define-const var1830 var3262 (logger/159573722 var3173)) ; Statement: $r7 = r0.<org.apache.dubbo.rpc.proxy.AbstractFallbackJdkProxyFactory: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var628 String String-init) ; Statement: $r6 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var628)) ; Statement: specialinvoke $r6.<java.lang.StringBuilder: void <init>()>() 
(declare-const var628!1 String)
(assert (= var628!1 ""))
(assert true)
(define-const var3096 String (append/672562846 var628!1 "Failed to generate invoker by ")) ; Statement: $r9 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to generate invoker by ") 
(declare-const var628!2 String)
(assert (= var628!2 (str.++ var628!1 "Failed to generate invoker by ")))
(assert true)
(define-const var2933 String (append/672562846 var3096 var231)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r8) 
(declare-const var3096!1 String)
(assert (= var3096!1 (str.++ var3096 var231)))
(assert true)
(define-const var2634 String (append/672562846 var2933 " failed. Fallback to use JDK proxy is also failed. Interfaces: ")) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" failed. Fallback to use JDK proxy is also failed. Interfaces: ") 
(declare-const var2933!1 String)
(assert (= var2933!1 (str.++ var2933 " failed. Fallback to use JDK proxy is also failed. Interfaces: ")))
(assert true)
(define-const var2641 String (append/-1031950772 var2634 (cast-from-ClassObject-to-var2005 var1280))) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r2) 
(declare-const var2634!1 String)
(assert (str.prefixof var2634 var2634!1))
(assert true)
(define-const var225 String (append/672562846 var2641 " Javassist Error.")) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" Javassist Error.") 
(declare-const var2641!1 String)
(assert (= var2641!1 (str.++ var2641 " Javassist Error.")))
(assert true)
(define-const var3289 String (toString/-2075883882 var225)) ; Statement: $r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var3262_error/377575788 var1830 "3-8" "" "" var3289 var863)) ; Statement: interfaceinvoke $r7.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("3-8", "", "", $r14, $r23) 

(declare-const var1830!1 var3262)
(declare-const var3263 String)
(declare-const var1967 String)
(declare-const var1967!1 String)
(declare-const var3289!1 String)
(declare-const var863!1 var2690)
(define-const var3168 var3262 (logger/159573722 var3173)) ; Statement: $r16 = r0.<org.apache.dubbo.rpc.proxy.AbstractFallbackJdkProxyFactory: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var1778 String String-init) ; Statement: $r15 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1778)) ; Statement: specialinvoke $r15.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1778!1 String)
(assert (= var1778!1 ""))
(assert true)
(define-const var1758 String (append/672562846 var1778!1 "Failed to generate invoker by ")) ; Statement: $r17 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to generate invoker by ") 
(declare-const var1778!2 String)
(assert (= var1778!2 (str.++ var1778!1 "Failed to generate invoker by ")))
(assert true)
(define-const var1761 String (append/672562846 var1758 var231)) ; Statement: $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r8) 
(declare-const var1758!1 String)
(assert (= var1758!1 (str.++ var1758 var231)))
(assert true)
(define-const var2870 String (append/672562846 var1761 " failed. Fallback to use JDK proxy is also failed. Interfaces: ")) ; Statement: $r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" failed. Fallback to use JDK proxy is also failed. Interfaces: ") 
(declare-const var1761!1 String)
(assert (= var1761!1 (str.++ var1761 " failed. Fallback to use JDK proxy is also failed. Interfaces: ")))
(assert true)
(define-const var3030 String (append/-1031950772 var2870 (cast-from-ClassObject-to-var2005 var1280))) ; Statement: $r20 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r2) 
(declare-const var2870!1 String)
(assert (str.prefixof var2870 var2870!1))
(assert true)
(define-const var1108 String (append/672562846 var3030 " JDK Error.")) ; Statement: $r21 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" JDK Error.") 
(declare-const var3030!1 String)
(assert (= var3030!1 (str.++ var3030 " JDK Error.")))
(assert true)
(define-const var3044 String (toString/-2075883882 var1108)) ; Statement: $r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var3262_error/377575788 var3168 "3-8" "" "" var3044 var3699)) ; Statement: interfaceinvoke $r16.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("3-8", "", "", $r22, $r5) 

(declare-const var3168!1 var3262)
(declare-const var3263!1 String)
(declare-const var1967!2 String)
(declare-const var1967!3 String)
(declare-const var3044!1 String)
(declare-const var3699!1 var2690)
 ; Statement: throw $r23 
(check-sat)
; {getClass/1258963082=([java.lang.Object], java.lang.Class), cast-from-var2098-to-var2005=([org.apache.dubbo.rpc.proxy.AbstractFallbackJdkProxyFactory], java.lang.Object), getSimpleName/-390194377=([java.lang.Class], java.lang.String), logger/159573722=([org.apache.dubbo.rpc.proxy.AbstractFallbackJdkProxyFactory], org.apache.dubbo.common.logger.ErrorTypeAwareLogger), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-ClassObject-to-var2005=([java.lang.Class], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var3262_error/377575788=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void)}
; {var2098=org.apache.dubbo.rpc.proxy.AbstractFallbackJdkProxyFactory, var3173=r0, var2005=java.lang.Object, var3835=r1, var1280=r2, var2386=org.apache.dubbo.common.URL, var691=r3, var2690=java.lang.Throwable, var863=$r23, var2819=$r24, var231=r8, var3699=$r5, var3262=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var1830=$r7, var628=$r6, var3096=$r9, var2933=$r10, var2634=$r11, var2641=$r12, var225=$r13, var3289=$r14, var3263="3-8", var1967="", var3168=$r16, var1778=$r15, var1758=$r17, var1761=$r18, var2870=$r19, var3030=$r20, var1108=$r21, var3044=$r22}
; {org.apache.dubbo.rpc.proxy.AbstractFallbackJdkProxyFactory=var2098, r0=var3173, java.lang.Object=var2005, r1=var3835, r2=var1280, org.apache.dubbo.common.URL=var2386, r3=var691, java.lang.Throwable=var2690, $r23=var863, $r24=var2819, r8=var231, $r5=var3699, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var3262, $r7=var1830, $r6=var628, $r9=var3096, $r10=var2933, $r11=var2634, $r12=var2641, $r13=var225, $r14=var3289, "3-8"=var3263, ""=var1967, $r16=var3168, $r15=var1778, $r17=var1758, $r18=var1761, $r19=var2870, $r20=var3030, $r21=var1108, $r22=var3044}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 8,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 2}
;stmts r0 := @this: org.apache.dubbo.rpc.proxy.AbstractFallbackJdkProxyFactory;	r1 := @parameter0: java.lang.Object;	r2 := @parameter1: java.lang.Class;	r3 := @parameter2: org.apache.dubbo.common.URL;	$r23 := @caughtexception;	$r24 = virtualinvoke r0.<java.lang.Object: java.lang.Class getClass()>();	r8 = virtualinvoke $r24.<java.lang.Class: java.lang.String getSimpleName()>();	$r5 := @caughtexception;	$r7 = r0.<org.apache.dubbo.rpc.proxy.AbstractFallbackJdkProxyFactory: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r6 = new java.lang.StringBuilder;	specialinvoke $r6.<java.lang.StringBuilder: void <init>()>();	$r9 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to generate invoker by ");	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r8);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" failed. Fallback to use JDK proxy is also failed. Interfaces: ");	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r2);	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" Javassist Error.");	$r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r7.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("3-8", "", "", $r14, $r23);	$r16 = r0.<org.apache.dubbo.rpc.proxy.AbstractFallbackJdkProxyFactory: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r15 = new java.lang.StringBuilder;	specialinvoke $r15.<java.lang.StringBuilder: void <init>()>();	$r17 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to generate invoker by ");	$r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r8);	$r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" failed. Fallback to use JDK proxy is also failed. Interfaces: ");	$r20 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r2);	$r21 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" JDK Error.");	$r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r16.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("3-8", "", "", $r22, $r5);	throw $r23
;block_num 3