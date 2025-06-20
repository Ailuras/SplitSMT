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

(declare-sort var4 0)
(declare-sort var3161 0)
(declare-sort var2870 0)
(declare-sort var1583 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun isHttp/-1560219278 (var3161) Bool)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun var2870-init () var2870)
(declare-fun <init>/-201242697 (var2870) void)
(declare-fun appendFrameworkConfig/850980494 (var4 (Array Int String) String var1583) void)
(declare-fun cast-from-var2870-to-var1583 (var2870) var1583)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var4 var4)
(declare-const null-var3161 var3161)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const var1729 var4) ; Statement: r3 := @this: org.apache.dubbo.qos.command.impl.GetConfig 
(assert (not (= var1729 null-var4)))
(declare-const var3173 var3161) ; Statement: r0 := @parameter0: org.apache.dubbo.qos.api.CommandContext 
(assert (not (= var3173 null-var3161)))
(declare-const var3723 (Array Int String)) ; Statement: r4 := @parameter1: java.lang.String[] 
(assert (not (= var3723 null-__Array__Int__String__)))
(assert true)
(define-const var2336 Bool (isHttp/-1560219278 var3173)) ; Statement: z0 = virtualinvoke r0.<org.apache.dubbo.qos.api.CommandContext: boolean isHttp()>() 
(define-const var29 String String-init) ; Statement: $r1 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var29)) ; Statement: specialinvoke $r1.<java.lang.StringBuilder: void <init>()>() 
(declare-const var29!1 String)
(assert (= var29!1 ""))
(define-const var2393 var2870 var2870-init) ; Statement: $r2 = new java.util.HashMap 
(assert true)
;(assert (<init>/-201242697 var2393)) ; Statement: specialinvoke $r2.<java.util.HashMap: void <init>()>() 

(declare-const var2393!1 var2870)
(assert true)
;(assert (appendFrameworkConfig/850980494 var1729 var3723 var29!1 (cast-from-var2870-to-var1583 var2393!1))) ; Statement: specialinvoke r3.<org.apache.dubbo.qos.command.impl.GetConfig: void appendFrameworkConfig(java.lang.String[],java.lang.StringBuilder,java.util.Map)>(r4, $r1, $r2) 

(declare-const var1729!1 var4)
(declare-const var3723!1 (Array Int String))
(declare-const var29!2 String)
(declare-const var2393!2 var2870)
 ; Statement: if z0 == 0 goto $r5 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert (= (ite var2336 1 0) 0)) ; Cond: z0 == 0 
(assert true)
(define-const var286 String (toString/-2075883882 var29!2)) ; Statement: $r5 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r5 
(check-sat)
; {isHttp/-1560219278=([org.apache.dubbo.qos.api.CommandContext], boolean), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), var2870-init=([], java.util.HashMap), <init>/-201242697=([java.util.HashMap], void), appendFrameworkConfig/850980494=([org.apache.dubbo.qos.command.impl.GetConfig, java.lang.String[], java.lang.StringBuilder, java.util.Map], void), cast-from-var2870-to-var1583=([java.util.HashMap], java.util.Map), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var4=org.apache.dubbo.qos.command.impl.GetConfig, var1729=r3, var3161=org.apache.dubbo.qos.api.CommandContext, var3173=r0, var3723=r4, var2336=z0, var29=$r1, var2870=java.util.HashMap, var2393=$r2, var1583=java.util.Map, var286=$r5}
; {org.apache.dubbo.qos.command.impl.GetConfig=var4, r3=var1729, org.apache.dubbo.qos.api.CommandContext=var3161, r0=var3173, r4=var3723, z0=var2336, $r1=var29, java.util.HashMap=var2870, $r2=var2393, java.util.Map=var1583, $r5=var286}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r3 := @this: org.apache.dubbo.qos.command.impl.GetConfig;	r0 := @parameter0: org.apache.dubbo.qos.api.CommandContext;	r4 := @parameter1: java.lang.String[];	z0 = virtualinvoke r0.<org.apache.dubbo.qos.api.CommandContext: boolean isHttp()>();	$r1 = new java.lang.StringBuilder;	specialinvoke $r1.<java.lang.StringBuilder: void <init>()>();	$r2 = new java.util.HashMap;	specialinvoke $r2.<java.util.HashMap: void <init>()>();	specialinvoke r3.<org.apache.dubbo.qos.command.impl.GetConfig: void appendFrameworkConfig(java.lang.String[],java.lang.StringBuilder,java.util.Map)>(r4, $r1, $r2);	if z0 == 0 goto $r5 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.String toString()>();	$r5 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.String toString()>();	return $r5
;block_num 2