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

(declare-sort var383 0)
(declare-sort var192 0)
(declare-sort var948 0)
(declare-sort var1358 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun checkSerializable/-647195865 (var383) var192)
(declare-fun var192_valueOf/1602327315 (Bool) var192)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-388390247 (String Bool) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var1358_info/484404803 (var1358 String) void)
(declare-fun cast-from-var948-to-var1358 (var948) var1358)
(declare-fun notifyCheckSerializable/-524901150 (var383) void)
(declare-const null-var383 var383)
(declare-const null-Bool Bool)
(declare-const null-var192 var192)
(declare-const var383-logger var948)
(declare-const var1857 var383) ; Statement: r0 := @this: org.apache.dubbo.common.utils.SerializeSecurityManager 
(assert (not (= var1857 null-var383)))
(declare-const var3328 Bool) ; Statement: z0 := @parameter0: boolean 
(assert (not (= var3328 null-Bool)))
(define-const var1945 var192 (checkSerializable/-647195865 var1857)) ; Statement: $r1 = r0.<org.apache.dubbo.common.utils.SerializeSecurityManager: java.lang.Boolean checkSerializable> 
 ; Statement: if $r1 == null goto $r2 = staticinvoke <java.lang.Boolean: java.lang.Boolean valueOf(boolean)>(z0) 
(assert (= var1945 null-var192)) ; Cond: $r1 == null 
(define-const var2953 var192 (var192_valueOf/1602327315 var3328)) ; Statement: $r2 = staticinvoke <java.lang.Boolean: java.lang.Boolean valueOf(boolean)>(z0) 
(declare-const var1857!1 var383)
(assert (not (= var1857!1 null-var383)))
(assert (= (checkSerializable/-647195865 var1857!1) var2953)) ; Statement: r0.<org.apache.dubbo.common.utils.SerializeSecurityManager: java.lang.Boolean checkSerializable> = $r2 
(define-const var3977 var948 var383-logger) ; Statement: $r4 = <org.apache.dubbo.common.utils.SerializeSecurityManager: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var1131 String String-init) ; Statement: $r3 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1131)) ; Statement: specialinvoke $r3.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1131!1 String)
(assert (= var1131!1 ""))
(assert true)
(define-const var1964 String (append/672562846 var1131!1 "Serialize check serializable: ")) ; Statement: $r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Serialize check serializable: ") 
(declare-const var1131!2 String)
(assert (= var1131!2 (str.++ var1131!1 "Serialize check serializable: ")))
(assert true)
(define-const var1609 String (append/-388390247 var1964 var3328)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(boolean)>(z0) 
(declare-const var1964!1 String)
(assert (str.prefixof var1964 var1964!1))
(assert true)
(define-const var436 String (toString/-2075883882 var1609)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var1358_info/484404803 (cast-from-var948-to-var1358 var3977) var436)) ; Statement: interfaceinvoke $r4.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void info(java.lang.String)>($r7) 

(declare-const var3977!1 var948)
(declare-const var436!1 String)
(assert true)
;(assert (notifyCheckSerializable/-524901150 var1857!1)) ; Statement: specialinvoke r0.<org.apache.dubbo.common.utils.SerializeSecurityManager: void notifyCheckSerializable()>() 

(declare-const var1857!2 var383)
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {checkSerializable/-647195865=([org.apache.dubbo.common.utils.SerializeSecurityManager], java.lang.Boolean), var192_valueOf/1602327315=([boolean], java.lang.Boolean), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-388390247=([java.lang.StringBuilder, boolean], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var1358_info/484404803=([org.apache.dubbo.common.logger.Logger, java.lang.String], void), cast-from-var948-to-var1358=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger], org.apache.dubbo.common.logger.Logger), notifyCheckSerializable/-524901150=([org.apache.dubbo.common.utils.SerializeSecurityManager], void)}
; {var383=org.apache.dubbo.common.utils.SerializeSecurityManager, var1857=r0, var3328=z0, var192=java.lang.Boolean, var1945=$r1, var2953=$r2, var948=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var3977=$r4, var1131=$r3, var1964=$r5, var1609=$r6, var436=$r7, var1358=org.apache.dubbo.common.logger.Logger}
; {org.apache.dubbo.common.utils.SerializeSecurityManager=var383, r0=var1857, z0=var3328, java.lang.Boolean=var192, $r1=var1945, $r2=var2953, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var948, $r4=var3977, $r3=var1131, $r5=var1964, $r6=var1609, $r7=var436, org.apache.dubbo.common.logger.Logger=var1358}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(boolean)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(boolean)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.common.utils.SerializeSecurityManager;	z0 := @parameter0: boolean;	$r1 = r0.<org.apache.dubbo.common.utils.SerializeSecurityManager: java.lang.Boolean checkSerializable>;	if $r1 == null goto $r2 = staticinvoke <java.lang.Boolean: java.lang.Boolean valueOf(boolean)>(z0);	$r2 = staticinvoke <java.lang.Boolean: java.lang.Boolean valueOf(boolean)>(z0);	r0.<org.apache.dubbo.common.utils.SerializeSecurityManager: java.lang.Boolean checkSerializable> = $r2;	$r4 = <org.apache.dubbo.common.utils.SerializeSecurityManager: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r3 = new java.lang.StringBuilder;	specialinvoke $r3.<java.lang.StringBuilder: void <init>()>();	$r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Serialize check serializable: ");	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(boolean)>(z0);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r4.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void info(java.lang.String)>($r7);	specialinvoke r0.<org.apache.dubbo.common.utils.SerializeSecurityManager: void notifyCheckSerializable()>();	return
;block_num 3