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

(declare-sort var1105 0)
(declare-sort var1578 0)
(declare-sort var3255 0)
(declare-sort var2742 0)
(declare-sort var3160 0)
(declare-sort var2143 0)
(declare-sort var852 0)
(declare-sort var197 0)
(declare-sort var1287 0)
(declare-sort var2109 0)
(declare-sort var1392 0)
(declare-sort var1579 0)
(declare-sort var1152 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var1578!class ClassObject)
(declare-const var2742!class ClassObject)
(declare-const var3160!class ClassObject)
(declare-const var2143!class ClassObject)
(declare-const var852!class ClassObject)
(declare-const var197!class ClassObject)
(declare-const var1287!class ClassObject)
(declare-fun loadConfigsOfTypeFromProps/-1808308145 (var3255 ClassObject) var1152)
(declare-fun cast-from-var1105-to-var3255 (var1105) var3255)
(declare-fun refreshAll/549294971 (var1105) void)
(declare-fun checkConfigs/-1466358504 (var1105) void)
(declare-fun applicationModel/208128580 (var3255) var2109)
(declare-fun getModelName/-2051809897 (var1392) String)
(declare-fun cast-from-var2109-to-var1392 (var2109) var1392)
(declare-fun var1579_isBlank/-523695098 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-const null-var1105 var1105)
(declare-const var1178 var1105) ; Statement: r0 := @this: org.apache.dubbo.config.context.ConfigManager 
(assert (not (= var1178 null-var1105)))
(assert true)
;(assert (loadConfigsOfTypeFromProps/-1808308145 (cast-from-var1105-to-var3255 var1178) var1578!class)) ; Statement: virtualinvoke r0.<org.apache.dubbo.config.context.ConfigManager: java.util.List loadConfigsOfTypeFromProps(java.lang.Class)>(class "Lorg/apache/dubbo/config/ApplicationConfig;") 

(declare-const var1178!1 var1105)
(declare-const var2526 ClassObject)
(assert true)
;(assert (loadConfigsOfTypeFromProps/-1808308145 (cast-from-var1105-to-var3255 var1178!1) var2742!class)) ; Statement: virtualinvoke r0.<org.apache.dubbo.config.context.ConfigManager: java.util.List loadConfigsOfTypeFromProps(java.lang.Class)>(class "Lorg/apache/dubbo/config/MonitorConfig;") 

(declare-const var1178!2 var1105)
(declare-const var1707 ClassObject)
(assert true)
;(assert (loadConfigsOfTypeFromProps/-1808308145 (cast-from-var1105-to-var3255 var1178!2) var3160!class)) ; Statement: virtualinvoke r0.<org.apache.dubbo.config.context.ConfigManager: java.util.List loadConfigsOfTypeFromProps(java.lang.Class)>(class "Lorg/apache/dubbo/config/MetricsConfig;") 

(declare-const var1178!3 var1105)
(declare-const var3227 ClassObject)
(assert true)
;(assert (loadConfigsOfTypeFromProps/-1808308145 (cast-from-var1105-to-var3255 var1178!3) var2143!class)) ; Statement: virtualinvoke r0.<org.apache.dubbo.config.context.ConfigManager: java.util.List loadConfigsOfTypeFromProps(java.lang.Class)>(class "Lorg/apache/dubbo/config/TracingConfig;") 

(declare-const var1178!4 var1105)
(declare-const var1890 ClassObject)
(assert true)
;(assert (loadConfigsOfTypeFromProps/-1808308145 (cast-from-var1105-to-var3255 var1178!4) var852!class)) ; Statement: virtualinvoke r0.<org.apache.dubbo.config.context.ConfigManager: java.util.List loadConfigsOfTypeFromProps(java.lang.Class)>(class "Lorg/apache/dubbo/config/ProtocolConfig;") 

(declare-const var1178!5 var1105)
(declare-const var1925 ClassObject)
(assert true)
;(assert (loadConfigsOfTypeFromProps/-1808308145 (cast-from-var1105-to-var3255 var1178!5) var197!class)) ; Statement: virtualinvoke r0.<org.apache.dubbo.config.context.ConfigManager: java.util.List loadConfigsOfTypeFromProps(java.lang.Class)>(class "Lorg/apache/dubbo/config/RegistryConfig;") 

(declare-const var1178!6 var1105)
(declare-const var3347 ClassObject)
(assert true)
;(assert (loadConfigsOfTypeFromProps/-1808308145 (cast-from-var1105-to-var3255 var1178!6) var1287!class)) ; Statement: virtualinvoke r0.<org.apache.dubbo.config.context.ConfigManager: java.util.List loadConfigsOfTypeFromProps(java.lang.Class)>(class "Lorg/apache/dubbo/config/MetadataReportConfig;") 

(declare-const var1178!7 var1105)
(declare-const var1569 ClassObject)
(assert true)
;(assert (refreshAll/549294971 var1178!7)) ; Statement: virtualinvoke r0.<org.apache.dubbo.config.context.ConfigManager: void refreshAll()>() 

(declare-const var1178!8 var1105)
(assert true)
;(assert (checkConfigs/-1466358504 var1178!8)) ; Statement: specialinvoke r0.<org.apache.dubbo.config.context.ConfigManager: void checkConfigs()>() 

(declare-const var1178!9 var1105)
(define-const var2401 var2109 (applicationModel/208128580 (cast-from-var1105-to-var3255 var1178!9))) ; Statement: $r1 = r0.<org.apache.dubbo.config.context.ConfigManager: org.apache.dubbo.rpc.model.ApplicationModel applicationModel> 
(assert true)
(define-const var940 String (getModelName/-2051809897 (cast-from-var2109-to-var1392 var2401))) ; Statement: $r2 = virtualinvoke $r1.<org.apache.dubbo.rpc.model.ApplicationModel: java.lang.String getModelName()>() 
(define-const var2433 Bool (var1579_isBlank/-523695098 (cast-from-String-to-String var940))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>($r2) 
 ; Statement: if $z0 == 0 goto return 
(assert (= (ite var2433 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return 
(check-sat)
; {loadConfigsOfTypeFromProps/-1808308145=([org.apache.dubbo.config.context.AbstractConfigManager, java.lang.Class], java.util.List), cast-from-var1105-to-var3255=([org.apache.dubbo.config.context.ConfigManager], org.apache.dubbo.config.context.AbstractConfigManager), refreshAll/549294971=([org.apache.dubbo.config.context.ConfigManager], void), checkConfigs/-1466358504=([org.apache.dubbo.config.context.ConfigManager], void), applicationModel/208128580=([org.apache.dubbo.config.context.AbstractConfigManager], org.apache.dubbo.rpc.model.ApplicationModel), getModelName/-2051809897=([org.apache.dubbo.rpc.model.ScopeModel], java.lang.String), cast-from-var2109-to-var1392=([org.apache.dubbo.rpc.model.ApplicationModel], org.apache.dubbo.rpc.model.ScopeModel), var1579_isBlank/-523695098=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence)}
; {var1105=org.apache.dubbo.config.context.ConfigManager, var1178=r0, var1578=org.apache.dubbo.config.ApplicationConfig, var3255=org.apache.dubbo.config.context.AbstractConfigManager, var2526=class "Lorg/apache/dubbo/config/ApplicationConfig;", var2742=org.apache.dubbo.config.MonitorConfig, var1707=class "Lorg/apache/dubbo/config/MonitorConfig;", var3160=org.apache.dubbo.config.MetricsConfig, var3227=class "Lorg/apache/dubbo/config/MetricsConfig;", var2143=org.apache.dubbo.config.TracingConfig, var1890=class "Lorg/apache/dubbo/config/TracingConfig;", var852=org.apache.dubbo.config.ProtocolConfig, var1925=class "Lorg/apache/dubbo/config/ProtocolConfig;", var197=org.apache.dubbo.config.RegistryConfig, var3347=class "Lorg/apache/dubbo/config/RegistryConfig;", var1287=org.apache.dubbo.config.MetadataReportConfig, var1569=class "Lorg/apache/dubbo/config/MetadataReportConfig;", var2109=org.apache.dubbo.rpc.model.ApplicationModel, var2401=$r1, var1392=org.apache.dubbo.rpc.model.ScopeModel, var940=$r2, var1579=org.apache.dubbo.common.utils.StringUtils, var2433=$z0, var1152=java.util.List}
; {org.apache.dubbo.config.context.ConfigManager=var1105, r0=var1178, org.apache.dubbo.config.ApplicationConfig=var1578, org.apache.dubbo.config.context.AbstractConfigManager=var3255, class "Lorg/apache/dubbo/config/ApplicationConfig;"=var2526, org.apache.dubbo.config.MonitorConfig=var2742, class "Lorg/apache/dubbo/config/MonitorConfig;"=var1707, org.apache.dubbo.config.MetricsConfig=var3160, class "Lorg/apache/dubbo/config/MetricsConfig;"=var3227, org.apache.dubbo.config.TracingConfig=var2143, class "Lorg/apache/dubbo/config/TracingConfig;"=var1890, org.apache.dubbo.config.ProtocolConfig=var852, class "Lorg/apache/dubbo/config/ProtocolConfig;"=var1925, org.apache.dubbo.config.RegistryConfig=var197, class "Lorg/apache/dubbo/config/RegistryConfig;"=var3347, org.apache.dubbo.config.MetadataReportConfig=var1287, class "Lorg/apache/dubbo/config/MetadataReportConfig;"=var1569, org.apache.dubbo.rpc.model.ApplicationModel=var2109, $r1=var2401, org.apache.dubbo.rpc.model.ScopeModel=var1392, $r2=var940, org.apache.dubbo.common.utils.StringUtils=var1579, $z0=var2433, java.util.List=var1152}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>": 1}
;stmts r0 := @this: org.apache.dubbo.config.context.ConfigManager;	virtualinvoke r0.<org.apache.dubbo.config.context.ConfigManager: java.util.List loadConfigsOfTypeFromProps(java.lang.Class)>(class "Lorg/apache/dubbo/config/ApplicationConfig;");	virtualinvoke r0.<org.apache.dubbo.config.context.ConfigManager: java.util.List loadConfigsOfTypeFromProps(java.lang.Class)>(class "Lorg/apache/dubbo/config/MonitorConfig;");	virtualinvoke r0.<org.apache.dubbo.config.context.ConfigManager: java.util.List loadConfigsOfTypeFromProps(java.lang.Class)>(class "Lorg/apache/dubbo/config/MetricsConfig;");	virtualinvoke r0.<org.apache.dubbo.config.context.ConfigManager: java.util.List loadConfigsOfTypeFromProps(java.lang.Class)>(class "Lorg/apache/dubbo/config/TracingConfig;");	virtualinvoke r0.<org.apache.dubbo.config.context.ConfigManager: java.util.List loadConfigsOfTypeFromProps(java.lang.Class)>(class "Lorg/apache/dubbo/config/ProtocolConfig;");	virtualinvoke r0.<org.apache.dubbo.config.context.ConfigManager: java.util.List loadConfigsOfTypeFromProps(java.lang.Class)>(class "Lorg/apache/dubbo/config/RegistryConfig;");	virtualinvoke r0.<org.apache.dubbo.config.context.ConfigManager: java.util.List loadConfigsOfTypeFromProps(java.lang.Class)>(class "Lorg/apache/dubbo/config/MetadataReportConfig;");	virtualinvoke r0.<org.apache.dubbo.config.context.ConfigManager: void refreshAll()>();	specialinvoke r0.<org.apache.dubbo.config.context.ConfigManager: void checkConfigs()>();	$r1 = r0.<org.apache.dubbo.config.context.ConfigManager: org.apache.dubbo.rpc.model.ApplicationModel applicationModel>;	$r2 = virtualinvoke $r1.<org.apache.dubbo.rpc.model.ApplicationModel: java.lang.String getModelName()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>($r2);	if $z0 == 0 goto return;	return
;block_num 2