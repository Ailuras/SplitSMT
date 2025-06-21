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

(declare-sort var3186 0)
(declare-sort var1380 0)
(declare-sort var1095 0)
(declare-sort var3211 0)
(declare-sort var1547 0)
(declare-sort var77 0)
(declare-sort var430 0)
(declare-sort var474 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var77!class ClassObject)
(declare-fun getScopeModel/439405660 (var1095) var1380)
(declare-fun cast-from-var3186-to-var1095 (var3186) var1095)
(declare-fun getLoadbalance/34185231 (var1095) String)
(declare-fun var3211_checkExtension/1586637652 (var1547 ClassObject String String) void)
(declare-fun cast-from-var1380-to-var1547 (var1380) var1547)
(declare-fun getParameters/2109921198 (var1095) var430)
(declare-fun var3211_checkParameterName/-1741245244 (var430) void)
(declare-fun getName/824650316 (var3186) String)
(declare-fun var3211_checkMethodName/307428734 (String String) void)
(declare-fun getMock/1684862699 (var1095) String)
(declare-fun var474_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-var3186 var3186)
(declare-const var3489 var3186) ; Statement: r0 := @parameter0: org.apache.dubbo.config.MethodConfig 
(assert (not (= var3489 null-var3186)))
(assert true)
(define-const var2173 var1380 (getScopeModel/439405660 (cast-from-var3186-to-var1095 var3489))) ; Statement: $r2 = virtualinvoke r0.<org.apache.dubbo.config.MethodConfig: org.apache.dubbo.rpc.model.ModuleModel getScopeModel()>() 
(assert true)
(define-const var67 String (getLoadbalance/34185231 (cast-from-var3186-to-var1095 var3489))) ; Statement: $r1 = virtualinvoke r0.<org.apache.dubbo.config.MethodConfig: java.lang.String getLoadbalance()>() 
;(assert (var3211_checkExtension/1586637652 (cast-from-var1380-to-var1547 var2173) var77!class "loadbalance" var67)) ; Statement: staticinvoke <org.apache.dubbo.config.utils.ConfigValidationUtils: void checkExtension(org.apache.dubbo.rpc.model.ScopeModel,java.lang.Class,java.lang.String,java.lang.String)>($r2, class "Lorg/apache/dubbo/rpc/cluster/LoadBalance;", "loadbalance", $r1) 

(declare-const var2173!1 var1380)
(declare-const var693 ClassObject)
(declare-const var2057 String)
(declare-const var67!1 String)
(assert true)
(define-const var2841 var430 (getParameters/2109921198 (cast-from-var3186-to-var1095 var3489))) ; Statement: $r3 = virtualinvoke r0.<org.apache.dubbo.config.MethodConfig: java.util.Map getParameters()>() 
;(assert (var3211_checkParameterName/-1741245244 var2841)) ; Statement: staticinvoke <org.apache.dubbo.config.utils.ConfigValidationUtils: void checkParameterName(java.util.Map)>($r3) 

(declare-const var2841!1 var430)
(assert true)
(define-const var1515 String (getName/824650316 var3489)) ; Statement: $r4 = virtualinvoke r0.<org.apache.dubbo.config.MethodConfig: java.lang.String getName()>() 
;(assert (var3211_checkMethodName/307428734 "name" var1515)) ; Statement: staticinvoke <org.apache.dubbo.config.utils.ConfigValidationUtils: void checkMethodName(java.lang.String,java.lang.String)>("name", $r4) 

(declare-const var3494 String)
(declare-const var1515!1 String)
(assert true)
(define-const var3859 String (getMock/1684862699 (cast-from-var3186-to-var1095 var3489))) ; Statement: r5 = virtualinvoke r0.<org.apache.dubbo.config.MethodConfig: java.lang.String getMock()>() 
(define-const var3184 Bool (var474_isNotEmpty/-1251449450 var3859)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r5) 
 ; Statement: if $z0 == 0 goto return 
(assert (= (ite var3184 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return 
(check-sat)
; {getScopeModel/439405660=([org.apache.dubbo.config.AbstractMethodConfig], org.apache.dubbo.rpc.model.ModuleModel), cast-from-var3186-to-var1095=([org.apache.dubbo.config.MethodConfig], org.apache.dubbo.config.AbstractMethodConfig), getLoadbalance/34185231=([org.apache.dubbo.config.AbstractMethodConfig], java.lang.String), var3211_checkExtension/1586637652=([org.apache.dubbo.rpc.model.ScopeModel, java.lang.Class, java.lang.String, java.lang.String], void), cast-from-var1380-to-var1547=([org.apache.dubbo.rpc.model.ModuleModel], org.apache.dubbo.rpc.model.ScopeModel), getParameters/2109921198=([org.apache.dubbo.config.AbstractMethodConfig], java.util.Map), var3211_checkParameterName/-1741245244=([java.util.Map], void), getName/824650316=([org.apache.dubbo.config.MethodConfig], java.lang.String), var3211_checkMethodName/307428734=([java.lang.String, java.lang.String], void), getMock/1684862699=([org.apache.dubbo.config.AbstractMethodConfig], java.lang.String), var474_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var3186=org.apache.dubbo.config.MethodConfig, var3489=r0, var1380=org.apache.dubbo.rpc.model.ModuleModel, var1095=org.apache.dubbo.config.AbstractMethodConfig, var2173=$r2, var67=$r1, var3211=org.apache.dubbo.config.utils.ConfigValidationUtils, var1547=org.apache.dubbo.rpc.model.ScopeModel, var77=org.apache.dubbo.rpc.cluster.LoadBalance, var693=class "Lorg/apache/dubbo/rpc/cluster/LoadBalance;", var2057="loadbalance", var430=java.util.Map, var2841=$r3, var1515=$r4, var3494="name", var3859=r5, var474=org.apache.dubbo.common.utils.StringUtils, var3184=$z0}
; {org.apache.dubbo.config.MethodConfig=var3186, r0=var3489, org.apache.dubbo.rpc.model.ModuleModel=var1380, org.apache.dubbo.config.AbstractMethodConfig=var1095, $r2=var2173, $r1=var67, org.apache.dubbo.config.utils.ConfigValidationUtils=var3211, org.apache.dubbo.rpc.model.ScopeModel=var1547, org.apache.dubbo.rpc.cluster.LoadBalance=var77, class "Lorg/apache/dubbo/rpc/cluster/LoadBalance;"=var693, "loadbalance"=var2057, java.util.Map=var430, $r3=var2841, $r4=var1515, "name"=var3494, r5=var3859, org.apache.dubbo.common.utils.StringUtils=var474, $z0=var3184}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @parameter0: org.apache.dubbo.config.MethodConfig;	$r2 = virtualinvoke r0.<org.apache.dubbo.config.MethodConfig: org.apache.dubbo.rpc.model.ModuleModel getScopeModel()>();	$r1 = virtualinvoke r0.<org.apache.dubbo.config.MethodConfig: java.lang.String getLoadbalance()>();	staticinvoke <org.apache.dubbo.config.utils.ConfigValidationUtils: void checkExtension(org.apache.dubbo.rpc.model.ScopeModel,java.lang.Class,java.lang.String,java.lang.String)>($r2, class "Lorg/apache/dubbo/rpc/cluster/LoadBalance;", "loadbalance", $r1);	$r3 = virtualinvoke r0.<org.apache.dubbo.config.MethodConfig: java.util.Map getParameters()>();	staticinvoke <org.apache.dubbo.config.utils.ConfigValidationUtils: void checkParameterName(java.util.Map)>($r3);	$r4 = virtualinvoke r0.<org.apache.dubbo.config.MethodConfig: java.lang.String getName()>();	staticinvoke <org.apache.dubbo.config.utils.ConfigValidationUtils: void checkMethodName(java.lang.String,java.lang.String)>("name", $r4);	r5 = virtualinvoke r0.<org.apache.dubbo.config.MethodConfig: java.lang.String getMock()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r5);	if $z0 == 0 goto return;	return
;block_num 2