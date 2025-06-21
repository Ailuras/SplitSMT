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

(declare-sort var1863 0)
(declare-sort var1674 0)
(declare-sort var1217 0)
(declare-sort var1612 0)
(declare-sort var3683 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getType/-69739029 (var1863) String)
(declare-fun getEnabled/1531051175 (var1674) var1612)
(declare-fun append/-1031950772 (String var3683) String)
(declare-fun cast-from-var1612-to-var3683 (var1612) var3683)
(declare-const null-var1863 var1863)
(declare-const null-var1674 var1674)
(declare-const null-String String)
(declare-const var2391 var1863) ; Statement: r1 := @parameter0: org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem 
(assert (not (= var2391 null-var1863)))
(declare-const var952 var1674) ; Statement: r3 := @parameter1: org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfiguratorConfig 
(assert (not (= var952 null-var1674)))
(declare-const var3972 String) ; Statement: r0 := @parameter2: java.lang.StringBuilder 
(assert (not (= var3972 null-String)))
(assert true)
;(assert (append/672562846 var3972 "&enabled=")) ; Statement: virtualinvoke r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("&enabled=") 
(declare-const var3972!1 String)
(assert (= var3972!1 (str.++ var3972 "&enabled=")))
(assert true)
(define-const var2787 String (getType/-69739029 var2391)) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem: java.lang.String getType()>() 
 ; Statement: if $r2 == null goto $r4 = virtualinvoke r3.<org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfiguratorConfig: java.lang.Boolean getEnabled()>() 
(assert (= var2787 null-String)) ; Cond: $r2 == null 
(assert true)
(define-const var3231 var1612 (getEnabled/1531051175 var952)) ; Statement: $r4 = virtualinvoke r3.<org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfiguratorConfig: java.lang.Boolean getEnabled()>() 
(assert true)
;(assert (append/-1031950772 var3972!1 (cast-from-var1612-to-var3683 var3231))) ; Statement: virtualinvoke r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r4) 
(declare-const var3972!2 String)
(assert (str.prefixof var3972!1 var3972!2))
 ; Statement: goto [?= return] 
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getType/-69739029=([org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem], java.lang.String), getEnabled/1531051175=([org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfiguratorConfig], java.lang.Boolean), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var1612-to-var3683=([java.lang.Boolean], java.lang.Object)}
; {var1863=org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem, var2391=r1, var1674=org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfiguratorConfig, var952=r3, var3972=r0, var2787=$r2, var1217=null_type, var1612=java.lang.Boolean, var3231=$r4, var3683=java.lang.Object}
; {org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem=var1863, r1=var2391, org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfiguratorConfig=var1674, r3=var952, r0=var3972, $r2=var2787, null_type=var1217, java.lang.Boolean=var1612, $r4=var3231, java.lang.Object=var3683}
;seq <java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>
;cnt {"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1}
;stmts r1 := @parameter0: org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem;	r3 := @parameter1: org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfiguratorConfig;	r0 := @parameter2: java.lang.StringBuilder;	virtualinvoke r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("&enabled=");	$r2 = virtualinvoke r1.<org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem: java.lang.String getType()>();	if $r2 == null goto $r4 = virtualinvoke r3.<org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfiguratorConfig: java.lang.Boolean getEnabled()>();	$r4 = virtualinvoke r3.<org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfiguratorConfig: java.lang.Boolean getEnabled()>();	virtualinvoke r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r4);	goto [?= return];	return
;block_num 3