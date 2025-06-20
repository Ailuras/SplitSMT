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

(declare-sort var562 0)
(declare-sort var3011 0)
(declare-sort var1872 0)
(declare-sort var1812 0)
(declare-sort var3859 0)
(declare-sort var3101 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun isHttp/-1560219278 (var3011) Bool)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun var1872-init () var1872)
(declare-fun <init>/-201242697 (var1872) void)
(declare-fun appendFrameworkConfig/850980494 (var562 (Array Int String) String var1812) void)
(declare-fun cast-from-var1872-to-var1812 (var1872) var1812)
(declare-fun var3859_toJson/-637920053 (var3101) String)
(declare-fun cast-from-var1872-to-var3101 (var1872) var3101)
(declare-const null-var562 var562)
(declare-const null-var3011 var3011)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const var3038 var562) ; Statement: r3 := @this: org.apache.dubbo.qos.command.impl.GetConfig 
(assert (not (= var3038 null-var562)))
(declare-const var20 var3011) ; Statement: r0 := @parameter0: org.apache.dubbo.qos.api.CommandContext 
(assert (not (= var20 null-var3011)))
(declare-const var3213 (Array Int String)) ; Statement: r4 := @parameter1: java.lang.String[] 
(assert (not (= var3213 null-__Array__Int__String__)))
(assert true)
(define-const var1635 Bool (isHttp/-1560219278 var20)) ; Statement: z0 = virtualinvoke r0.<org.apache.dubbo.qos.api.CommandContext: boolean isHttp()>() 
(define-const var3267 String String-init) ; Statement: $r1 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3267)) ; Statement: specialinvoke $r1.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3267!1 String)
(assert (= var3267!1 ""))
(define-const var1677 var1872 var1872-init) ; Statement: $r2 = new java.util.HashMap 
(assert true)
;(assert (<init>/-201242697 var1677)) ; Statement: specialinvoke $r2.<java.util.HashMap: void <init>()>() 

(declare-const var1677!1 var1872)
(assert true)
;(assert (appendFrameworkConfig/850980494 var3038 var3213 var3267!1 (cast-from-var1872-to-var1812 var1677!1))) ; Statement: specialinvoke r3.<org.apache.dubbo.qos.command.impl.GetConfig: void appendFrameworkConfig(java.lang.String[],java.lang.StringBuilder,java.util.Map)>(r4, $r1, $r2) 

(declare-const var3038!1 var562)
(declare-const var3213!1 (Array Int String))
(declare-const var3267!2 String)
(declare-const var1677!2 var1872)
 ; Statement: if z0 == 0 goto $r5 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert (not (= (ite var1635 1 0) 0))) ; Negate: Cond: z0 == 0  
(define-const var2828 String (var3859_toJson/-637920053 (cast-from-var1872-to-var3101 var1677!2))) ; Statement: $r6 = staticinvoke <org.apache.dubbo.common.utils.JsonUtils: java.lang.String toJson(java.lang.Object)>($r2) 
 ; Statement: return $r6 
(check-sat)
; {isHttp/-1560219278=([org.apache.dubbo.qos.api.CommandContext], boolean), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), var1872-init=([], java.util.HashMap), <init>/-201242697=([java.util.HashMap], void), appendFrameworkConfig/850980494=([org.apache.dubbo.qos.command.impl.GetConfig, java.lang.String[], java.lang.StringBuilder, java.util.Map], void), cast-from-var1872-to-var1812=([java.util.HashMap], java.util.Map), var3859_toJson/-637920053=([java.lang.Object], java.lang.String), cast-from-var1872-to-var3101=([java.util.HashMap], java.lang.Object)}
; {var562=org.apache.dubbo.qos.command.impl.GetConfig, var3038=r3, var3011=org.apache.dubbo.qos.api.CommandContext, var20=r0, var3213=r4, var1635=z0, var3267=$r1, var1872=java.util.HashMap, var1677=$r2, var1812=java.util.Map, var3859=org.apache.dubbo.common.utils.JsonUtils, var3101=java.lang.Object, var2828=$r6}
; {org.apache.dubbo.qos.command.impl.GetConfig=var562, r3=var3038, org.apache.dubbo.qos.api.CommandContext=var3011, r0=var20, r4=var3213, z0=var1635, $r1=var3267, java.util.HashMap=var1872, $r2=var1677, java.util.Map=var1812, org.apache.dubbo.common.utils.JsonUtils=var3859, java.lang.Object=var3101, $r6=var2828}
;seq <java.lang.StringBuilder: void <init>()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1}
;stmts r3 := @this: org.apache.dubbo.qos.command.impl.GetConfig;	r0 := @parameter0: org.apache.dubbo.qos.api.CommandContext;	r4 := @parameter1: java.lang.String[];	z0 = virtualinvoke r0.<org.apache.dubbo.qos.api.CommandContext: boolean isHttp()>();	$r1 = new java.lang.StringBuilder;	specialinvoke $r1.<java.lang.StringBuilder: void <init>()>();	$r2 = new java.util.HashMap;	specialinvoke $r2.<java.util.HashMap: void <init>()>();	specialinvoke r3.<org.apache.dubbo.qos.command.impl.GetConfig: void appendFrameworkConfig(java.lang.String[],java.lang.StringBuilder,java.util.Map)>(r4, $r1, $r2);	if z0 == 0 goto $r5 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.String toString()>();	$r6 = staticinvoke <org.apache.dubbo.common.utils.JsonUtils: java.lang.String toJson(java.lang.Object)>($r2);	return $r6
;block_num 2