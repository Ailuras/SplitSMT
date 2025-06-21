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

(declare-sort var2925 0)
(declare-sort var3759 0)
(declare-sort var1884 0)
(declare-sort var3680 0)
(declare-sort var3095 0)
(declare-sort var2142 0)
(declare-sort var207 0)
(declare-sort var58 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getName/824650316 (var3759) String)
(declare-fun var3680_appendParameters/-1651738593 (var1884 var3095 String) void)
(declare-fun cast-from-var3759-to-var3095 (var3759) var3095)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var1884_containsKey/1715618542 (var1884 var3095) Bool)
(declare-fun cast-from-String-to-var3095 (String) var3095)
(declare-fun getArguments/-2068747802 (var3759) var2142)
(declare-fun var207_isNotEmpty/-572947236 (var58) Bool)
(declare-fun cast-from-var2142-to-var58 (var2142) var58)
(declare-const null-var2925 var2925)
(declare-const null-var3759 var3759)
(declare-const null-var1884 var1884)
(declare-const var3572 var2925) ; Statement: r8 := @this: org.apache.dubbo.config.ServiceConfig 
(assert (not (= var3572 null-var2925)))
(declare-const var3812 var3759) ; Statement: r1 := @parameter0: org.apache.dubbo.config.MethodConfig 
(assert (not (= var3812 null-var3759)))
(declare-const var3799 var1884) ; Statement: r0 := @parameter1: java.util.Map 
(assert (not (= var3799 null-var1884)))
(assert true)
(define-const var2706 String (getName/824650316 var3812)) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.config.MethodConfig: java.lang.String getName()>() 
;(assert (var3680_appendParameters/-1651738593 var3799 (cast-from-var3759-to-var3095 var3812) var2706)) ; Statement: staticinvoke <org.apache.dubbo.config.AbstractConfig: void appendParameters(java.util.Map,java.lang.Object,java.lang.String)>(r0, r1, $r2) 

(declare-const var3799!1 var1884)
(declare-const var3812!1 var3759)
(declare-const var2706!1 String)
(define-const var3853 String String-init) ; Statement: $r3 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3853)) ; Statement: specialinvoke $r3.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3853!1 String)
(assert (= var3853!1 ""))
(assert true)
(define-const var3272 String (getName/824650316 var3812!1)) ; Statement: $r4 = virtualinvoke r1.<org.apache.dubbo.config.MethodConfig: java.lang.String getName()>() 
(assert true)
(define-const var825 String (append/672562846 var3853!1 var3272)) ; Statement: $r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4) 
(declare-const var3853!2 String)
(assert (= var3853!2 (str.++ var3853!1 var3272)))
(assert true)
(define-const var1899 String (append/672562846 var825 ".retry")) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".retry") 
(declare-const var825!1 String)
(assert (= var825!1 (str.++ var825 ".retry")))
(assert true)
(define-const var1803 String (toString/-2075883882 var1899)) ; Statement: r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>() 
(define-const var3715 Bool (var1884_containsKey/1715618542 var3799!1 (cast-from-String-to-var3095 var1803))) ; Statement: $z0 = interfaceinvoke r0.<java.util.Map: boolean containsKey(java.lang.Object)>(r7) 
 ; Statement: if $z0 == 0 goto $r19 = virtualinvoke r1.<org.apache.dubbo.config.MethodConfig: java.util.List getArguments()>() 
(assert (= (ite var3715 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var3918 var2142 (getArguments/-2068747802 var3812!1)) ; Statement: $r19 = virtualinvoke r1.<org.apache.dubbo.config.MethodConfig: java.util.List getArguments()>() 
(define-const var2285 Bool (var207_isNotEmpty/-572947236 (cast-from-var2142-to-var58 var3918))) ; Statement: $z2 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isNotEmpty(java.util.Collection)>($r19) 
 ; Statement: if $z2 == 0 goto return 
(assert (= (ite var2285 1 0) 0)) ; Cond: $z2 == 0 
 ; Statement: return 
(check-sat)
; {getName/824650316=([org.apache.dubbo.config.MethodConfig], java.lang.String), var3680_appendParameters/-1651738593=([java.util.Map, java.lang.Object, java.lang.String], void), cast-from-var3759-to-var3095=([org.apache.dubbo.config.MethodConfig], java.lang.Object), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var1884_containsKey/1715618542=([java.util.Map, java.lang.Object], boolean), cast-from-String-to-var3095=([java.lang.String], java.lang.Object), getArguments/-2068747802=([org.apache.dubbo.config.MethodConfig], java.util.List), var207_isNotEmpty/-572947236=([java.util.Collection], boolean), cast-from-var2142-to-var58=([java.util.List], java.util.Collection)}
; {var2925=org.apache.dubbo.config.ServiceConfig, var3572=r8, var3759=org.apache.dubbo.config.MethodConfig, var3812=r1, var1884=java.util.Map, var3799=r0, var2706=$r2, var3680=org.apache.dubbo.config.AbstractConfig, var3095=java.lang.Object, var3853=$r3, var3272=$r4, var825=$r5, var1899=$r6, var1803=r7, var3715=$z0, var2142=java.util.List, var3918=$r19, var207=org.apache.dubbo.common.utils.CollectionUtils, var58=java.util.Collection, var2285=$z2}
; {org.apache.dubbo.config.ServiceConfig=var2925, r8=var3572, org.apache.dubbo.config.MethodConfig=var3759, r1=var3812, java.util.Map=var1884, r0=var3799, $r2=var2706, org.apache.dubbo.config.AbstractConfig=var3680, java.lang.Object=var3095, $r3=var3853, $r4=var3272, $r5=var825, $r6=var1899, r7=var1803, $z0=var3715, java.util.List=var2142, $r19=var3918, org.apache.dubbo.common.utils.CollectionUtils=var207, java.util.Collection=var58, $z2=var2285}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r8 := @this: org.apache.dubbo.config.ServiceConfig;	r1 := @parameter0: org.apache.dubbo.config.MethodConfig;	r0 := @parameter1: java.util.Map;	$r2 = virtualinvoke r1.<org.apache.dubbo.config.MethodConfig: java.lang.String getName()>();	staticinvoke <org.apache.dubbo.config.AbstractConfig: void appendParameters(java.util.Map,java.lang.Object,java.lang.String)>(r0, r1, $r2);	$r3 = new java.lang.StringBuilder;	specialinvoke $r3.<java.lang.StringBuilder: void <init>()>();	$r4 = virtualinvoke r1.<org.apache.dubbo.config.MethodConfig: java.lang.String getName()>();	$r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".retry");	r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>();	$z0 = interfaceinvoke r0.<java.util.Map: boolean containsKey(java.lang.Object)>(r7);	if $z0 == 0 goto $r19 = virtualinvoke r1.<org.apache.dubbo.config.MethodConfig: java.util.List getArguments()>();	$r19 = virtualinvoke r1.<org.apache.dubbo.config.MethodConfig: java.util.List getArguments()>();	$z2 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isNotEmpty(java.util.Collection)>($r19);	if $z2 == 0 goto return;	return
;block_num 3