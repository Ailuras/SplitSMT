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

(declare-sort var1822 0)
(declare-sort var1258 0)
(declare-sort var2088 0)
(declare-sort var3801 0)
(declare-sort var475 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1258-init () var1258)
(declare-fun <init>/300815260 (var1258) void)
(declare-fun var1822_get/1088891777 (var1822 var2088) var2088)
(declare-fun cast-from-String-to-var2088 (String) var2088)
(declare-fun cast-from-var2088-to-String (var2088) String)
(declare-fun setType/1526678645 (var1258 String) void)
(declare-fun String_valueOf/-333372740 (var2088) String)
(declare-fun var475_error/377575788 (var475 String String String String var3801) void)
(declare-fun setSide/289832760 (var1258 String) void)
(declare-const null-var1822 var1822)
(declare-const null-var2088 var2088)
(declare-const null-var3801 var3801)
(declare-const var1258-logger var475)
(declare-const var285 var1822) ; Statement: r1 := @parameter0: java.util.Map 
(assert (not (= var285 null-var1822)))
(define-const var1430 var1258 var1258-init) ; Statement: $r0 = new org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem 
(assert true)
;(assert (<init>/300815260 var1430)) ; Statement: specialinvoke $r0.<org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem: void <init>()>() 

(declare-const var1430!1 var1258)
(define-const var3468 var2088 (var1822_get/1088891777 var285 (cast-from-String-to-var2088 "type"))) ; Statement: $r2 = interfaceinvoke r1.<java.util.Map: java.lang.Object get(java.lang.Object)>("type") 
(define-const var3901 String (cast-from-var2088-to-String var3468)) ; Statement: $r3 = (java.lang.String) $r2 
(assert true)
;(assert (setType/1526678645 var1430!1 var3901)) ; Statement: virtualinvoke $r0.<org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem: void setType(java.lang.String)>($r3) 

(declare-const var1430!2 var1258)
(declare-const var3901!1 String)
(define-const var1665 var2088 (var1822_get/1088891777 var285 (cast-from-String-to-var2088 "enabled"))) ; Statement: r4 = interfaceinvoke r1.<java.util.Map: java.lang.Object get(java.lang.Object)>("enabled") 
 ; Statement: if r4 == null goto $r60 = interfaceinvoke r1.<java.util.Map: java.lang.Object get(java.lang.Object)>("addresses") 
(assert (= var1665 null-var2088)) ; Cond: r4 == null 
(define-const var3422 var2088 (var1822_get/1088891777 var285 (cast-from-String-to-var2088 "addresses"))) ; Statement: $r60 = interfaceinvoke r1.<java.util.Map: java.lang.Object get(java.lang.Object)>("addresses") 
 ; Statement: if $r60 == null goto $r65 = interfaceinvoke r1.<java.util.Map: java.lang.Object get(java.lang.Object)>("providerAddresses") 
(assert (= var3422 null-var2088)) ; Cond: $r60 == null 
(define-const var3157 var2088 (var1822_get/1088891777 var285 (cast-from-String-to-var2088 "providerAddresses"))) ; Statement: $r65 = interfaceinvoke r1.<java.util.Map: java.lang.Object get(java.lang.Object)>("providerAddresses") 
 ; Statement: if $r65 == null goto $r66 = interfaceinvoke r1.<java.util.Map: java.lang.Object get(java.lang.Object)>("services") 
(assert (= var3157 null-var2088)) ; Cond: $r65 == null 
(define-const var1934 var2088 (var1822_get/1088891777 var285 (cast-from-String-to-var2088 "services"))) ; Statement: $r66 = interfaceinvoke r1.<java.util.Map: java.lang.Object get(java.lang.Object)>("services") 
 ; Statement: if $r66 == null goto $r67 = interfaceinvoke r1.<java.util.Map: java.lang.Object get(java.lang.Object)>("applications") 
(assert (= var1934 null-var2088)) ; Cond: $r66 == null 
(define-const var2387 var2088 (var1822_get/1088891777 var285 (cast-from-String-to-var2088 "applications"))) ; Statement: $r67 = interfaceinvoke r1.<java.util.Map: java.lang.Object get(java.lang.Object)>("applications") 
 ; Statement: if $r67 == null goto $r68 = interfaceinvoke r1.<java.util.Map: java.lang.Object get(java.lang.Object)>("parameters") 
(assert (= var2387 null-var2088)) ; Cond: $r67 == null 
(define-const var3728 var2088 (var1822_get/1088891777 var285 (cast-from-String-to-var2088 "parameters"))) ; Statement: $r68 = interfaceinvoke r1.<java.util.Map: java.lang.Object get(java.lang.Object)>("parameters") 
 ; Statement: if $r68 == null goto $r69 = interfaceinvoke r1.<java.util.Map: java.lang.Object get(java.lang.Object)>("match") 
(assert (not (= var3728 null-var2088))) ; Negate: Cond: $r68 == null  
(declare-const var471 var3801) ; Statement: $r61 := @caughtexception 
(assert (not (= var471 null-var3801)))
(define-const var2883 var475 var1258-logger) ; Statement: $r62 = <org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var1290 var2088 (var1822_get/1088891777 var285 (cast-from-String-to-var2088 "match"))) ; Statement: $r63 = interfaceinvoke r1.<java.util.Map: java.lang.Object get(java.lang.Object)>("match") 
(define-const var2936 String (String_valueOf/-333372740 var1290)) ; Statement: $r64 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>($r63) 
;(assert (var475_error/377575788 var2883 "2-13" " Failed to parse dynamic configuration rule" var2936 "Error occurred when parsing rule component." var471)) ; Statement: interfaceinvoke $r62.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("2-13", " Failed to parse dynamic configuration rule", $r64, "Error occurred when parsing rule component.", $r61) 

(declare-const var2883!1 var475)
(declare-const var3529 String)
(declare-const var2755 String)
(declare-const var2936!1 String)
(declare-const var723 String)
(declare-const var471!1 var3801)
(assert true) ; Non Conditional
(define-const var2050 var2088 (var1822_get/1088891777 var285 (cast-from-String-to-var2088 "side"))) ; Statement: $r5 = interfaceinvoke r1.<java.util.Map: java.lang.Object get(java.lang.Object)>("side") 
(define-const var1336 String (cast-from-var2088-to-String var2050)) ; Statement: $r6 = (java.lang.String) $r5 
(assert true)
;(assert (setSide/289832760 var1430!2 var1336)) ; Statement: virtualinvoke $r0.<org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem: void setSide(java.lang.String)>($r6) 

(declare-const var1430!3 var1258)
(declare-const var1336!1 String)
 ; Statement: return $r0 
(check-sat)
; {var1258-init=([], org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem), <init>/300815260=([org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem], void), var1822_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-String-to-var2088=([java.lang.String], java.lang.Object), cast-from-var2088-to-String=([java.lang.Object], java.lang.String), setType/1526678645=([org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem, java.lang.String], void), String_valueOf/-333372740=([java.lang.Object], java.lang.String), var475_error/377575788=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void), setSide/289832760=([org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem, java.lang.String], void)}
; {var1822=java.util.Map, var285=r1, var1258=org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem, var1430=$r0, var2088=java.lang.Object, var3468=$r2, var3901=$r3, var1665=r4, var3422=$r60, var3157=$r65, var1934=$r66, var2387=$r67, var3728=$r68, var3801=java.lang.Throwable, var471=$r61, var475=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var2883=$r62, var1290=$r63, var2936=$r64, var3529="2-13", var2755=" Failed to parse dynamic configuration rule", var723="Error occurred when parsing rule component.", var2050=$r5, var1336=$r6}
; {java.util.Map=var1822, r1=var285, org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem=var1258, $r0=var1430, java.lang.Object=var2088, $r2=var3468, $r3=var3901, r4=var1665, $r60=var3422, $r65=var3157, $r66=var1934, $r67=var2387, $r68=var3728, java.lang.Throwable=var3801, $r61=var471, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var475, $r62=var2883, $r63=var1290, $r64=var2936, "2-13"=var3529, " Failed to parse dynamic configuration rule"=var2755, "Error occurred when parsing rule component."=var723, $r5=var2050, $r6=var1336}
;seq <java.lang.String: java.lang.String valueOf(java.lang.Object)>
;cnt {"<java.lang.String: java.lang.String valueOf(java.lang.Object)>": 1}
;stmts r1 := @parameter0: java.util.Map;	$r0 = new org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem;	specialinvoke $r0.<org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem: void <init>()>();	$r2 = interfaceinvoke r1.<java.util.Map: java.lang.Object get(java.lang.Object)>("type");	$r3 = (java.lang.String) $r2;	virtualinvoke $r0.<org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem: void setType(java.lang.String)>($r3);	r4 = interfaceinvoke r1.<java.util.Map: java.lang.Object get(java.lang.Object)>("enabled");	if r4 == null goto $r60 = interfaceinvoke r1.<java.util.Map: java.lang.Object get(java.lang.Object)>("addresses");	$r60 = interfaceinvoke r1.<java.util.Map: java.lang.Object get(java.lang.Object)>("addresses");	if $r60 == null goto $r65 = interfaceinvoke r1.<java.util.Map: java.lang.Object get(java.lang.Object)>("providerAddresses");	$r65 = interfaceinvoke r1.<java.util.Map: java.lang.Object get(java.lang.Object)>("providerAddresses");	if $r65 == null goto $r66 = interfaceinvoke r1.<java.util.Map: java.lang.Object get(java.lang.Object)>("services");	$r66 = interfaceinvoke r1.<java.util.Map: java.lang.Object get(java.lang.Object)>("services");	if $r66 == null goto $r67 = interfaceinvoke r1.<java.util.Map: java.lang.Object get(java.lang.Object)>("applications");	$r67 = interfaceinvoke r1.<java.util.Map: java.lang.Object get(java.lang.Object)>("applications");	if $r67 == null goto $r68 = interfaceinvoke r1.<java.util.Map: java.lang.Object get(java.lang.Object)>("parameters");	$r68 = interfaceinvoke r1.<java.util.Map: java.lang.Object get(java.lang.Object)>("parameters");	if $r68 == null goto $r69 = interfaceinvoke r1.<java.util.Map: java.lang.Object get(java.lang.Object)>("match");	$r61 := @caughtexception;	$r62 = <org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r63 = interfaceinvoke r1.<java.util.Map: java.lang.Object get(java.lang.Object)>("match");	$r64 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>($r63);	interfaceinvoke $r62.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("2-13", " Failed to parse dynamic configuration rule", $r64, "Error occurred when parsing rule component.", $r61);	$r5 = interfaceinvoke r1.<java.util.Map: java.lang.Object get(java.lang.Object)>("side");	$r6 = (java.lang.String) $r5;	virtualinvoke $r0.<org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem: void setSide(java.lang.String)>($r6);	return $r0
;block_num 8