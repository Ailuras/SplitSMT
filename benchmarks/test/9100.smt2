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

(declare-sort var18 0)
(declare-sort var1734 0)
(declare-sort var1062 0)
(declare-sort var2848 0)
(declare-sort var193 0)
(declare-sort var1324 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getType/-1080442783 (var1734) String)
(declare-fun var193_isNotEmpty/-1251449450 (String) Bool)
(declare-fun hasIndex/1865153751 (var18 var1734) Bool)
(declare-fun var1324-init () var1324)
(declare-fun <init>/875830710 (var1324 String) void)
(declare-const null-var18 var18)
(declare-const null-var1734 var1734)
(declare-const null-var1062 var1062)
(declare-const null-var2848 var2848)
(declare-const var210 var18) ; Statement: r2 := @this: org.apache.dubbo.config.ServiceConfig 
(assert (not (= var210 null-var18)))
(declare-const var1819 var1734) ; Statement: r0 := @parameter0: org.apache.dubbo.config.ArgumentConfig 
(assert (not (= var1819 null-var1734)))
(declare-const var819 var1062) ; Statement: r6 := @parameter1: java.lang.reflect.Method 
(assert (not (= var819 null-var1062)))
(declare-const var1268 var2848) ; Statement: r4 := @parameter2: java.util.Map 
(assert (not (= var1268 null-var2848)))
(assert true)
(define-const var190 String (getType/-1080442783 var1819)) ; Statement: $r1 = virtualinvoke r0.<org.apache.dubbo.config.ArgumentConfig: java.lang.String getType()>() 
(define-const var2435 Bool (var193_isNotEmpty/-1251449450 var190)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r1) 
 ; Statement: if $z0 == 0 goto $z1 = specialinvoke r2.<org.apache.dubbo.config.ServiceConfig: boolean hasIndex(org.apache.dubbo.config.ArgumentConfig)>(r0) 
(assert (= (ite var2435 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var3996 Bool (hasIndex/1865153751 var210 var1819)) ; Statement: $z1 = specialinvoke r2.<org.apache.dubbo.config.ServiceConfig: boolean hasIndex(org.apache.dubbo.config.ArgumentConfig)>(r0) 
 ; Statement: if $z1 == 0 goto $r3 = new java.lang.IllegalArgumentException 
(assert (= (ite var3996 1 0) 0)) ; Cond: $z1 == 0 
(define-const var138 var1324 var1324-init) ; Statement: $r3 = new java.lang.IllegalArgumentException 
(assert true)
;(assert (<init>/875830710 var138 "Argument config must set index or type attribute.eg: <dubbo:argument index=\u00270\u0027 .../> or <dubbo:argument type=xxx .../>")) ; Statement: specialinvoke $r3.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>("Argument config must set index or type attribute.eg: <dubbo:argument index=\'0\' .../> or <dubbo:argument type=xxx .../>") 

(declare-const var138!1 var1324)
(declare-const var1581 String)
 ; Statement: throw $r3 
(check-sat)
; {getType/-1080442783=([org.apache.dubbo.config.ArgumentConfig], java.lang.String), var193_isNotEmpty/-1251449450=([java.lang.String], boolean), hasIndex/1865153751=([org.apache.dubbo.config.ServiceConfig, org.apache.dubbo.config.ArgumentConfig], boolean), var1324-init=([], java.lang.IllegalArgumentException), <init>/875830710=([java.lang.IllegalArgumentException, java.lang.String], void)}
; {var18=org.apache.dubbo.config.ServiceConfig, var210=r2, var1734=org.apache.dubbo.config.ArgumentConfig, var1819=r0, var1062=java.lang.reflect.Method, var819=r6, var2848=java.util.Map, var1268=r4, var190=$r1, var193=org.apache.dubbo.common.utils.StringUtils, var2435=$z0, var3996=$z1, var1324=java.lang.IllegalArgumentException, var138=$r3, var1581="Argument config must set index or type attribute.eg: <dubbo:argument index=\'0\' .../> or <dubbo:argument type=xxx .../>"}
; {org.apache.dubbo.config.ServiceConfig=var18, r2=var210, org.apache.dubbo.config.ArgumentConfig=var1734, r0=var1819, java.lang.reflect.Method=var1062, r6=var819, java.util.Map=var2848, r4=var1268, $r1=var190, org.apache.dubbo.common.utils.StringUtils=var193, $z0=var2435, $z1=var3996, java.lang.IllegalArgumentException=var1324, $r3=var138, "Argument config must set index or type attribute.eg: <dubbo:argument index=\'0\' .../> or <dubbo:argument type=xxx .../>"=var1581}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r2 := @this: org.apache.dubbo.config.ServiceConfig;	r0 := @parameter0: org.apache.dubbo.config.ArgumentConfig;	r6 := @parameter1: java.lang.reflect.Method;	r4 := @parameter2: java.util.Map;	$r1 = virtualinvoke r0.<org.apache.dubbo.config.ArgumentConfig: java.lang.String getType()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r1);	if $z0 == 0 goto $z1 = specialinvoke r2.<org.apache.dubbo.config.ServiceConfig: boolean hasIndex(org.apache.dubbo.config.ArgumentConfig)>(r0);	$z1 = specialinvoke r2.<org.apache.dubbo.config.ServiceConfig: boolean hasIndex(org.apache.dubbo.config.ArgumentConfig)>(r0);	if $z1 == 0 goto $r3 = new java.lang.IllegalArgumentException;	$r3 = new java.lang.IllegalArgumentException;	specialinvoke $r3.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>("Argument config must set index or type attribute.eg: <dubbo:argument index=\'0\' .../> or <dubbo:argument type=xxx .../>");	throw $r3
;block_num 3