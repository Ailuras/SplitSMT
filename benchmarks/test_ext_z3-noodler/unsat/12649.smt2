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

(declare-sort var1824 0)
(declare-sort var2221 0)
(declare-sort var632 0)
(declare-sort var2150 0)
(declare-sort var15 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var632_currentTimeMillis/630293680 () Int)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getMessage/849299655 (var15) String)
(declare-fun cast-from-var2150-to-var15 (var2150) var15)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var1824 var1824)
(declare-const null-var2221 var2221)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const null-var2150 var2150)
(declare-const var2027 var1824) ; Statement: r2 := @this: org.apache.dubbo.qos.command.impl.ShutdownTelnet 
(assert (not (= var2027 null-var1824)))
(declare-const var32 var2221) ; Statement: r20 := @parameter0: org.apache.dubbo.qos.api.CommandContext 
(assert (not (= var32 null-var2221)))
(declare-const var3258 (Array Int String)) ; Statement: r0 := @parameter1: java.lang.String[] 
(assert (not (= var3258 null-__Array__Int__String__)))
(define-const var931 Int 0) ; Statement: i4 = 0 
 ; Statement: if r0 == null goto $l5 = staticinvoke <java.lang.System: long currentTimeMillis()>() 
(assert (= var3258 null-__Array__Int__String__)) ; Cond: r0 == null 
(define-const var3270 Int var632_currentTimeMillis/630293680) ; Statement: $l5 = staticinvoke <java.lang.System: long currentTimeMillis()>() 
 ; Statement: if i4 <= 0 goto $r1 = new java.lang.StringBuilder 
(assert (not (<= var931 0))) ; Negate: Cond: i4 <= 0  
(define-const var1336 Int (cast-from-Int-to-Int var931)) ; Statement: $l1 = (long) i4 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var1520 var2150) ; Statement: $r14 := @caughtexception 
(assert (not (= var1520 null-var2150)))
(define-const var781 String String-init) ; Statement: $r15 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var781)) ; Statement: specialinvoke $r15.<java.lang.StringBuilder: void <init>()>() 
(declare-const var781!1 String)
(assert (= var781!1 ""))
(assert true)
(define-const var2230 String (append/672562846 var781!1 "Failed to invoke shutdown command, cause: ")) ; Statement: $r17 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to invoke shutdown command, cause: ") 
(declare-const var781!2 String)
(assert (= var781!2 (str.++ var781!1 "Failed to invoke shutdown command, cause: ")))
(assert true)
(define-const var2394 String (getMessage/849299655 (cast-from-var2150-to-var15 var1520))) ; Statement: $r16 = virtualinvoke $r14.<java.lang.InterruptedException: java.lang.String getMessage()>() 
(assert true)
(define-const var322 String (append/672562846 var2230 var2394)) ; Statement: $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r16) 
(declare-const var2230!1 String)
(assert (= var2230!1 (str.++ var2230 var2394)))
(assert true)
(define-const var793 String (toString/-2075883882 var322)) ; Statement: $r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r19 
(check-sat)
; {var632_currentTimeMillis/630293680=([], long), cast-from-Int-to-Int=([int], long), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getMessage/849299655=([java.lang.Throwable], java.lang.String), cast-from-var2150-to-var15=([java.lang.InterruptedException], java.lang.Throwable), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1824=org.apache.dubbo.qos.command.impl.ShutdownTelnet, var2027=r2, var2221=org.apache.dubbo.qos.api.CommandContext, var32=r20, var3258=r0, var931=i4, var632=java.lang.System, var3270=$l5, var1336=$l1, var2150=java.lang.InterruptedException, var1520=$r14, var781=$r15, var2230=$r17, var15=java.lang.Throwable, var2394=$r16, var322=$r18, var793=$r19}
; {org.apache.dubbo.qos.command.impl.ShutdownTelnet=var1824, r2=var2027, org.apache.dubbo.qos.api.CommandContext=var2221, r20=var32, r0=var3258, i4=var931, java.lang.System=var632, $l5=var3270, $l1=var1336, java.lang.InterruptedException=var2150, $r14=var1520, $r15=var781, $r17=var2230, java.lang.Throwable=var15, $r16=var2394, $r18=var322, $r19=var793}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r2 := @this: org.apache.dubbo.qos.command.impl.ShutdownTelnet;	r20 := @parameter0: org.apache.dubbo.qos.api.CommandContext;	r0 := @parameter1: java.lang.String[];	i4 = 0;	if r0 == null goto $l5 = staticinvoke <java.lang.System: long currentTimeMillis()>();	$l5 = staticinvoke <java.lang.System: long currentTimeMillis()>();	if i4 <= 0 goto $r1 = new java.lang.StringBuilder;	$l1 = (long) i4;	$r14 := @caughtexception;	$r15 = new java.lang.StringBuilder;	specialinvoke $r15.<java.lang.StringBuilder: void <init>()>();	$r17 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to invoke shutdown command, cause: ");	$r16 = virtualinvoke $r14.<java.lang.InterruptedException: java.lang.String getMessage()>();	$r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r16);	$r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.String toString()>();	return $r19
;block_num 4