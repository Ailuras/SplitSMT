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

(declare-sort var2503 0)
(declare-sort var1603 0)
(declare-sort var3549 0)
(declare-sort var1933 0)
(declare-sort var3376 0)
(declare-sort var1871 0)
(declare-sort var510 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun type/-1855590362 (var2503) ClassObject)
(declare-fun append/-1031950772 (String var510) String)
(declare-fun cast-from-ClassObject-to-var510 (ClassObject) var510)
(declare-fun cast-from-var1933-to-var510 (var1933) var510)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var1871_error/377575788 (var1871 String String String String var3376) void)
(declare-const null-var2503 var2503)
(declare-const null-var1603 var1603)
(declare-const null-var3549 var3549)
(declare-const null-var1933 var1933)
(declare-const null-Bool Bool)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const null-var3376 var3376)
(declare-const var2503-logger var1871)
(declare-const var480 var2503) ; Statement: r0 := @this: org.apache.dubbo.common.extension.ExtensionLoader 
(assert (not (= var480 null-var2503)))
(declare-const var3662 var1603) ; Statement: r9 := @parameter0: java.util.Map 
(assert (not (= var3662 null-var1603)))
(declare-const var971 var3549) ; Statement: r7 := @parameter1: java.lang.ClassLoader 
(assert (not (= var971 null-var3549)))
(declare-const var1813 var1933) ; Statement: r1 := @parameter2: java.net.URL 
(assert (not (= var1813 null-var1933)))
(declare-const var3812 Bool) ; Statement: z5 := @parameter3: boolean 
(assert (not (= var3812 null-Bool)))
(declare-const var3581 (Array Int String)) ; Statement: r6 := @parameter4: java.lang.String[] 
(assert (not (= var3581 null-__Array__Int__String__)))
(declare-const var3470 (Array Int String)) ; Statement: r5 := @parameter5: java.lang.String[] 
(assert (not (= var3470 null-__Array__Int__String__)))
(declare-const var47 (Array Int String)) ; Statement: r8 := @parameter6: java.lang.String[] 
(assert (not (= var47 null-__Array__Int__String__)))
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var1114 var3376) ; Statement: $r13 := @caughtexception 
(assert (not (= var1114 null-var3376)))
(define-const var778 var1871 var2503-logger) ; Statement: $r15 = <org.apache.dubbo.common.extension.ExtensionLoader: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var3906 String String-init) ; Statement: $r14 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3906)) ; Statement: specialinvoke $r14.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3906!1 String)
(assert (= var3906!1 ""))
(assert true)
(define-const var1093 String (append/672562846 var3906!1 "Exception occurred when loading extension class (interface: ")) ; Statement: $r17 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Exception occurred when loading extension class (interface: ") 
(declare-const var3906!2 String)
(assert (= var3906!2 (str.++ var3906!1 "Exception occurred when loading extension class (interface: ")))
(define-const var2803 ClassObject (type/-1855590362 var480)) ; Statement: $r16 = r0.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Class type> 
(assert true)
(define-const var2635 String (append/-1031950772 var1093 (cast-from-ClassObject-to-var510 var2803))) ; Statement: $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r16) 
(declare-const var1093!1 String)
(assert (str.prefixof var1093 var1093!1))
(assert true)
(define-const var2238 String (append/672562846 var2635 ", class file: ")) ; Statement: $r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", class file: ") 
(declare-const var2635!1 String)
(assert (= var2635!1 (str.++ var2635 ", class file: ")))
(assert true)
(define-const var3751 String (append/-1031950772 var2238 (cast-from-var1933-to-var510 var1813))) ; Statement: $r20 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r1) 
(declare-const var2238!1 String)
(assert (str.prefixof var2238 var2238!1))
(assert true)
(define-const var1891 String (append/672562846 var3751 ") in ")) ; Statement: $r21 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(") in ") 
(declare-const var3751!1 String)
(assert (= var3751!1 (str.++ var3751 ") in ")))
(assert true)
(define-const var2490 String (append/-1031950772 var1891 (cast-from-var1933-to-var510 var1813))) ; Statement: $r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r1) 
(declare-const var1891!1 String)
(assert (str.prefixof var1891 var1891!1))
(assert true)
(define-const var893 String (toString/-2075883882 var2490)) ; Statement: $r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var1871_error/377575788 var778 "0-15" "" "" var893 var1114)) ; Statement: interfaceinvoke $r15.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("0-15", "", "", $r23, $r13) 

(declare-const var778!1 var1871)
(declare-const var3092 String)
(declare-const var1332 String)
(declare-const var1332!1 String)
(declare-const var893!1 String)
(declare-const var1114!1 var3376)
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), type/-1855590362=([org.apache.dubbo.common.extension.ExtensionLoader], java.lang.Class), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-ClassObject-to-var510=([java.lang.Class], java.lang.Object), cast-from-var1933-to-var510=([java.net.URL], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var1871_error/377575788=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void)}
; {var2503=org.apache.dubbo.common.extension.ExtensionLoader, var480=r0, var1603=java.util.Map, var3662=r9, var3549=java.lang.ClassLoader, var971=r7, var1933=java.net.URL, var1813=r1, var3812=z5, var3581=r6, var3470=r5, var47=r8, var3376=java.lang.Throwable, var1114=$r13, var1871=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var778=$r15, var3906=$r14, var1093=$r17, var2803=$r16, var510=java.lang.Object, var2635=$r18, var2238=$r19, var3751=$r20, var1891=$r21, var2490=$r22, var893=$r23, var3092="0-15", var1332=""}
; {org.apache.dubbo.common.extension.ExtensionLoader=var2503, r0=var480, java.util.Map=var1603, r9=var3662, java.lang.ClassLoader=var3549, r7=var971, java.net.URL=var1933, r1=var1813, z5=var3812, r6=var3581, r5=var3470, r8=var47, java.lang.Throwable=var3376, $r13=var1114, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var1871, $r15=var778, $r14=var3906, $r17=var1093, $r16=var2803, java.lang.Object=var510, $r18=var2635, $r19=var2238, $r20=var3751, $r21=var1891, $r22=var2490, $r23=var893, "0-15"=var3092, ""=var1332}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.common.extension.ExtensionLoader;	r9 := @parameter0: java.util.Map;	r7 := @parameter1: java.lang.ClassLoader;	r1 := @parameter2: java.net.URL;	z5 := @parameter3: boolean;	r6 := @parameter4: java.lang.String[];	r5 := @parameter5: java.lang.String[];	r8 := @parameter6: java.lang.String[];	$r13 := @caughtexception;	$r15 = <org.apache.dubbo.common.extension.ExtensionLoader: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r14 = new java.lang.StringBuilder;	specialinvoke $r14.<java.lang.StringBuilder: void <init>()>();	$r17 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Exception occurred when loading extension class (interface: ");	$r16 = r0.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Class type>;	$r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r16);	$r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", class file: ");	$r20 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r1);	$r21 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(") in ");	$r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r1);	$r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r15.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("0-15", "", "", $r23, $r13);	return
;block_num 3