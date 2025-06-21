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

(declare-sort var2140 0)
(declare-sort var1563 0)
(declare-sort var1410 0)
(declare-sort var2094 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getName/824650316 (var1563) String)
(declare-fun var1410_isEmpty/-813097145 (String) Bool)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun interfaceName/2049477907 (var2140) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var2094_warn/1431914100 (var2094 String String String String) void)
(declare-const null-var2140 var2140)
(declare-const null-var1563 var1563)
(declare-const null-ClassObject ClassObject)
(declare-const null-Bool Bool)
(declare-const var2140-logger var2094)
(declare-const var328 var2140) ; Statement: r15 := @this: org.apache.dubbo.config.AbstractInterfaceConfig 
(assert (not (= var328 null-var2140)))
(declare-const var2497 var1563) ; Statement: r0 := @parameter0: org.apache.dubbo.config.MethodConfig 
(assert (not (= var2497 null-var1563)))
(declare-const var677 ClassObject) ; Statement: r2 := @parameter1: java.lang.Class 
(assert (not (= var677 null-ClassObject)))
(declare-const var3359 Bool) ; Statement: z1 := @parameter2: boolean 
(assert (not (= var3359 null-Bool)))
(assert true)
(define-const var1277 String (getName/824650316 var2497)) ; Statement: r1 = virtualinvoke r0.<org.apache.dubbo.config.MethodConfig: java.lang.String getName()>() 
(define-const var2170 Bool (var1410_isEmpty/-813097145 var1277)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto $r3 = virtualinvoke r2.<java.lang.Class: java.lang.reflect.Method[] getMethods()>() 
(assert (not (= (ite var2170 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var2814 String String-init) ; Statement: $r22 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2814)) ; Statement: specialinvoke $r22.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2814!1 String)
(assert (= var2814!1 ""))
(assert true)
(define-const var601 String (append/672562846 var2814!1 "<dubbo:method> name attribute is required! Please check: <dubbo:service interface=\u0022")) ; Statement: $r24 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("<dubbo:method> name attribute is required! Please check: <dubbo:service interface=\"") 
(declare-const var2814!2 String)
(assert (= var2814!2 (str.++ var2814!1 "<dubbo:method> name attribute is required! Please check: <dubbo:service interface=\u0022")))
(define-const var3920 String (interfaceName/2049477907 var328)) ; Statement: $r23 = r15.<org.apache.dubbo.config.AbstractInterfaceConfig: java.lang.String interfaceName> 
(assert true)
(define-const var3484 String (append/672562846 var601 var3920)) ; Statement: $r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r23) 
(declare-const var601!1 String)
(assert (= var601!1 (str.++ var601 var3920)))
(assert true)
(define-const var3718 String (append/672562846 var3484 "\u0022 ... ><dubbo:method name=\u0022\u0022 ... /></<dubbo:reference>")) ; Statement: $r26 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\" ... ><dubbo:method name=\"\" ... /></<dubbo:reference>") 
(declare-const var3484!1 String)
(assert (= var3484!1 (str.++ var3484 "\u0022 ... ><dubbo:method name=\u0022\u0022 ... /></<dubbo:reference>")))
(assert true)
(define-const var3347 String (toString/-2075883882 var3718)) ; Statement: r29 = virtualinvoke $r26.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: if z1 == 0 goto $r27 = new java.lang.IllegalStateException 
(assert (not (= (ite var3359 1 0) 0))) ; Negate: Cond: z1 == 0  
(define-const var314 var2094 var2140-logger) ; Statement: $r28 = <org.apache.dubbo.config.AbstractInterfaceConfig: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
;(assert (var2094_warn/1431914100 var314 "5-4" "" "" var3347)) ; Statement: interfaceinvoke $r28.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String)>("5-4", "", "", r29) 

(declare-const var314!1 var2094)
(declare-const var1890 String)
(declare-const var3067 String)
(declare-const var3067!1 String)
(declare-const var3347!1 String)
 ; Statement: return 0 
(check-sat)
; {getName/824650316=([org.apache.dubbo.config.MethodConfig], java.lang.String), var1410_isEmpty/-813097145=([java.lang.String], boolean), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), interfaceName/2049477907=([org.apache.dubbo.config.AbstractInterfaceConfig], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var2094_warn/1431914100=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String], void)}
; {var2140=org.apache.dubbo.config.AbstractInterfaceConfig, var328=r15, var1563=org.apache.dubbo.config.MethodConfig, var2497=r0, var677=r2, var3359=z1, var1277=r1, var1410=org.apache.dubbo.common.utils.StringUtils, var2170=$z0, var2814=$r22, var601=$r24, var3920=$r23, var3484=$r25, var3718=$r26, var3347=r29, var2094=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var314=$r28, var1890="5-4", var3067=""}
; {org.apache.dubbo.config.AbstractInterfaceConfig=var2140, r15=var328, org.apache.dubbo.config.MethodConfig=var1563, r0=var2497, r2=var677, z1=var3359, r1=var1277, org.apache.dubbo.common.utils.StringUtils=var1410, $z0=var2170, $r22=var2814, $r24=var601, $r23=var3920, $r25=var3484, $r26=var3718, r29=var3347, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var2094, $r28=var314, "5-4"=var1890, ""=var3067}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r15 := @this: org.apache.dubbo.config.AbstractInterfaceConfig;	r0 := @parameter0: org.apache.dubbo.config.MethodConfig;	r2 := @parameter1: java.lang.Class;	z1 := @parameter2: boolean;	r1 = virtualinvoke r0.<org.apache.dubbo.config.MethodConfig: java.lang.String getName()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1);	if $z0 == 0 goto $r3 = virtualinvoke r2.<java.lang.Class: java.lang.reflect.Method[] getMethods()>();	$r22 = new java.lang.StringBuilder;	specialinvoke $r22.<java.lang.StringBuilder: void <init>()>();	$r24 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("<dubbo:method> name attribute is required! Please check: <dubbo:service interface=\"");	$r23 = r15.<org.apache.dubbo.config.AbstractInterfaceConfig: java.lang.String interfaceName>;	$r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r23);	$r26 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\" ... ><dubbo:method name=\"\" ... /></<dubbo:reference>");	r29 = virtualinvoke $r26.<java.lang.StringBuilder: java.lang.String toString()>();	if z1 == 0 goto $r27 = new java.lang.IllegalStateException;	$r28 = <org.apache.dubbo.config.AbstractInterfaceConfig: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	interfaceinvoke $r28.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String)>("5-4", "", "", r29);	return 0
;block_num 3