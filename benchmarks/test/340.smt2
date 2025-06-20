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

(declare-sort var1704 0)
(declare-sort var3836 0)
(declare-sort var2153 0)
(declare-sort var1993 0)
(declare-sort var3574 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getSide/-1426391378 (var1704) String)
(declare-fun getParameters/-1654505730 (var1704) var2153)
(declare-fun var1993_isEmptyMap/212689853 (var2153) Bool)
(declare-fun var3574-init () var3574)
(declare-fun <init>/-1092629202 (var3574 String) void)
(declare-const null-var1704 var1704)
(declare-const null-String String)
(declare-const var3010 var1704) ; Statement: r1 := @parameter0: org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem 
(assert (not (= var3010 null-var1704)))
(define-const var3705 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3705)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3705!1 String)
(assert (= var3705!1 ""))
(assert true)
;(assert (append/672562846 var3705!1 "category=")) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("category=") 
(declare-const var3705!2 String)
(assert (= var3705!2 (str.++ var3705!1 "category=")))
(assert true)
;(assert (append/672562846 var3705!2 "dynamicconfigurators")) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("dynamicconfigurators") 
(declare-const var3705!3 String)
(assert (= var3705!3 (str.++ var3705!2 "dynamicconfigurators")))
(assert true)
(define-const var2042 String (getSide/-1426391378 var3010)) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem: java.lang.String getSide()>() 
 ; Statement: if $r2 == null goto $r13 = virtualinvoke r1.<org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem: java.util.Map getParameters()>() 
(assert (= var2042 null-String)) ; Cond: $r2 == null 
(assert true)
(define-const var198 var2153 (getParameters/-1654505730 var3010)) ; Statement: $r13 = virtualinvoke r1.<org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem: java.util.Map getParameters()>() 
(define-const var1366 Bool (var1993_isEmptyMap/212689853 var198)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isEmptyMap(java.util.Map)>($r13) 
 ; Statement: if $z0 == 0 goto $r3 = staticinvoke <org.apache.dubbo.rpc.cluster.configurator.parser.ConfigParser$lambda_toParameterString_5__9: java.util.function.BiConsumer bootstrap$(java.lang.StringBuilder)>($r0) 
(assert (not (= (ite var1366 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var903 var3574 var3574-init) ; Statement: $r11 = new java.lang.IllegalStateException 
(assert true)
;(assert (<init>/-1092629202 var903 "Invalid configurator rule, please specify at least one parameter you want to change in the rule.")) ; Statement: specialinvoke $r11.<java.lang.IllegalStateException: void <init>(java.lang.String)>("Invalid configurator rule, please specify at least one parameter you want to change in the rule.") 

(declare-const var903!1 var3574)
(declare-const var3560 String)
 ; Statement: throw $r11 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getSide/-1426391378=([org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem], java.lang.String), getParameters/-1654505730=([org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem], java.util.Map), var1993_isEmptyMap/212689853=([java.util.Map], boolean), var3574-init=([], java.lang.IllegalStateException), <init>/-1092629202=([java.lang.IllegalStateException, java.lang.String], void)}
; {var1704=org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem, var3010=r1, var3705=$r0, var2042=$r2, var3836=null_type, var2153=java.util.Map, var198=$r13, var1993=org.apache.dubbo.common.utils.CollectionUtils, var1366=$z0, var3574=java.lang.IllegalStateException, var903=$r11, var3560="Invalid configurator rule, please specify at least one parameter you want to change in the rule."}
; {org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem=var1704, r1=var3010, $r0=var3705, $r2=var2042, null_type=var3836, java.util.Map=var2153, $r13=var198, org.apache.dubbo.common.utils.CollectionUtils=var1993, $z0=var1366, java.lang.IllegalStateException=var3574, $r11=var903, "Invalid configurator rule, please specify at least one parameter you want to change in the rule."=var3560}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2}
;stmts r1 := @parameter0: org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("category=");	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("dynamicconfigurators");	$r2 = virtualinvoke r1.<org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem: java.lang.String getSide()>();	if $r2 == null goto $r13 = virtualinvoke r1.<org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem: java.util.Map getParameters()>();	$r13 = virtualinvoke r1.<org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem: java.util.Map getParameters()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isEmptyMap(java.util.Map)>($r13);	if $z0 == 0 goto $r3 = staticinvoke <org.apache.dubbo.rpc.cluster.configurator.parser.ConfigParser$lambda_toParameterString_5__9: java.util.function.BiConsumer bootstrap$(java.lang.StringBuilder)>($r0);	$r11 = new java.lang.IllegalStateException;	specialinvoke $r11.<java.lang.IllegalStateException: void <init>(java.lang.String)>("Invalid configurator rule, please specify at least one parameter you want to change in the rule.");	throw $r11
;block_num 3