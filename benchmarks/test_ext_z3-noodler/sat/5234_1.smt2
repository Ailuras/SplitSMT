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

(declare-sort var2108 0)
(declare-sort var3090 0)
(declare-sort var2517 0)
(declare-sort var3572 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getName/824650316 (var3090) String)
(declare-fun var2517_isEmpty/-813097145 (String) Bool)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun interfaceName/2049477907 (var2108) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var3572-init () var3572)
(declare-fun <init>/-1092629202 (var3572 String) void)
(declare-const null-var2108 var2108)
(declare-const null-var3090 var3090)
(declare-const null-ClassObject ClassObject)
(declare-const null-Bool Bool)
(declare-const var1750 var2108) ; Statement: r15 := @this: org.apache.dubbo.config.AbstractInterfaceConfig 
(assert (not (= var1750 null-var2108)))
(declare-const var3172 var3090) ; Statement: r0 := @parameter0: org.apache.dubbo.config.MethodConfig 
(assert (not (= var3172 null-var3090)))
(declare-const var610 ClassObject) ; Statement: r2 := @parameter1: java.lang.Class 
(assert (not (= var610 null-ClassObject)))
(declare-const var571 Bool) ; Statement: z1 := @parameter2: boolean 
(assert (not (= var571 null-Bool)))
(assert true)
(define-const var791 String (getName/824650316 var3172)) ; Statement: r1 = virtualinvoke r0.<org.apache.dubbo.config.MethodConfig: java.lang.String getName()>() 
(define-const var3443 Bool (var2517_isEmpty/-813097145 var791)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto $r3 = virtualinvoke r2.<java.lang.Class: java.lang.reflect.Method[] getMethods()>() 
(assert (not (= (ite var3443 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var1590 String String-init) ; Statement: $r22 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1590)) ; Statement: specialinvoke $r22.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1590!1 String)
(assert (= var1590!1 ""))
(assert true)
(define-const var3126 String (append/672562846 var1590!1 "<dubbo:method> name attribute is required! Please check: <dubbo:service interface=\u0022")) ; Statement: $r24 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("<dubbo:method> name attribute is required! Please check: <dubbo:service interface=\"") 
(declare-const var1590!2 String)
(assert (= var1590!2 (str.++ var1590!1 "<dubbo:method> name attribute is required! Please check: <dubbo:service interface=\u0022")))
(define-const var3842 String (interfaceName/2049477907 var1750)) ; Statement: $r23 = r15.<org.apache.dubbo.config.AbstractInterfaceConfig: java.lang.String interfaceName> 
(assert true)
(define-const var3149 String (append/672562846 var3126 var3842)) ; Statement: $r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r23) 
(declare-const var3126!1 String)
(assert (= var3126!1 (str.++ var3126 var3842)))
(assert true)
(define-const var800 String (append/672562846 var3149 "\u0022 ... ><dubbo:method name=\u0022\u0022 ... /></<dubbo:reference>")) ; Statement: $r26 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\" ... ><dubbo:method name=\"\" ... /></<dubbo:reference>") 
(declare-const var3149!1 String)
(assert (= var3149!1 (str.++ var3149 "\u0022 ... ><dubbo:method name=\u0022\u0022 ... /></<dubbo:reference>")))
(assert true)
(define-const var64 String (toString/-2075883882 var800)) ; Statement: r29 = virtualinvoke $r26.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: if z1 == 0 goto $r27 = new java.lang.IllegalStateException 
(assert (= (ite var571 1 0) 0)) ; Cond: z1 == 0 
(define-const var2402 var3572 var3572-init) ; Statement: $r27 = new java.lang.IllegalStateException 
(assert true)
;(assert (<init>/-1092629202 var2402 var64)) ; Statement: specialinvoke $r27.<java.lang.IllegalStateException: void <init>(java.lang.String)>(r29) 

(declare-const var2402!1 var3572)
(declare-const var64!1 String)
 ; Statement: throw $r27 
(check-sat)
; {getName/824650316=([org.apache.dubbo.config.MethodConfig], java.lang.String), var2517_isEmpty/-813097145=([java.lang.String], boolean), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), interfaceName/2049477907=([org.apache.dubbo.config.AbstractInterfaceConfig], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var3572-init=([], java.lang.IllegalStateException), <init>/-1092629202=([java.lang.IllegalStateException, java.lang.String], void)}
; {var2108=org.apache.dubbo.config.AbstractInterfaceConfig, var1750=r15, var3090=org.apache.dubbo.config.MethodConfig, var3172=r0, var610=r2, var571=z1, var791=r1, var2517=org.apache.dubbo.common.utils.StringUtils, var3443=$z0, var1590=$r22, var3126=$r24, var3842=$r23, var3149=$r25, var800=$r26, var64=r29, var3572=java.lang.IllegalStateException, var2402=$r27}
; {org.apache.dubbo.config.AbstractInterfaceConfig=var2108, r15=var1750, org.apache.dubbo.config.MethodConfig=var3090, r0=var3172, r2=var610, z1=var571, r1=var791, org.apache.dubbo.common.utils.StringUtils=var2517, $z0=var3443, $r22=var1590, $r24=var3126, $r23=var3842, $r25=var3149, $r26=var800, r29=var64, java.lang.IllegalStateException=var3572, $r27=var2402}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r15 := @this: org.apache.dubbo.config.AbstractInterfaceConfig;	r0 := @parameter0: org.apache.dubbo.config.MethodConfig;	r2 := @parameter1: java.lang.Class;	z1 := @parameter2: boolean;	r1 = virtualinvoke r0.<org.apache.dubbo.config.MethodConfig: java.lang.String getName()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1);	if $z0 == 0 goto $r3 = virtualinvoke r2.<java.lang.Class: java.lang.reflect.Method[] getMethods()>();	$r22 = new java.lang.StringBuilder;	specialinvoke $r22.<java.lang.StringBuilder: void <init>()>();	$r24 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("<dubbo:method> name attribute is required! Please check: <dubbo:service interface=\"");	$r23 = r15.<org.apache.dubbo.config.AbstractInterfaceConfig: java.lang.String interfaceName>;	$r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r23);	$r26 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\" ... ><dubbo:method name=\"\" ... /></<dubbo:reference>");	r29 = virtualinvoke $r26.<java.lang.StringBuilder: java.lang.String toString()>();	if z1 == 0 goto $r27 = new java.lang.IllegalStateException;	$r27 = new java.lang.IllegalStateException;	specialinvoke $r27.<java.lang.IllegalStateException: void <init>(java.lang.String)>(r29);	throw $r27
;block_num 3