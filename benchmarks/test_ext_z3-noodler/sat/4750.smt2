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

(declare-sort var432 0)
(declare-sort var2942 0)
(declare-sort var32 0)
(declare-sort var3625 0)
(declare-sort var3599 0)
(declare-sort var2265 0)
(declare-sort var50 0)
(declare-sort var3252 0)
(declare-sort var3418 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var432!class ClassObject)
(declare-fun var2942-init () var2942)
(declare-fun <init>/-201242697 (var2942) void)
(declare-fun var32_appendParameters/-678393988 (var3625 var3599) void)
(declare-fun cast-from-var2942-to-var3625 (var2942) var3625)
(declare-fun cast-from-var432-to-var3599 (var432) var3599)
(declare-fun address/-1013415841 (var432) String)
(declare-fun var2265_isEmpty/-813097145 (String) Bool)
(declare-fun getName/-1958580599 (ClassObject) String)
(declare-fun var3625_put/1464166817 (var3625 var3599 var3599) var3599)
(declare-fun cast-from-String-to-var3599 (String) var3599)
(declare-fun var3625_get/1088891777 (var3625 var3599) var3599)
(declare-fun cast-from-var3599-to-String (var3599) String)
(declare-fun var3252_parseURL/640513066 (String var3625) var50)
(declare-fun getScopeModel/-569440683 (var32) var3418)
(declare-fun cast-from-var432-to-var32 (var432) var32)
(declare-fun setScopeModel/-1563758557 (var50 var3418) var50)
(declare-const null-var432 var432)
(declare-const var579 var432) ; Statement: r1 := @this: org.apache.dubbo.config.ConfigCenterConfig 
(assert (not (= var579 null-var432)))
(define-const var2809 var2942 var2942-init) ; Statement: $r0 = new java.util.HashMap 
(assert true)
;(assert (<init>/-201242697 var2809)) ; Statement: specialinvoke $r0.<java.util.HashMap: void <init>()>() 

(declare-const var2809!1 var2942)
;(assert (var32_appendParameters/-678393988 (cast-from-var2942-to-var3625 var2809!1) (cast-from-var432-to-var3599 var579))) ; Statement: staticinvoke <org.apache.dubbo.config.ConfigCenterConfig: void appendParameters(java.util.Map,java.lang.Object)>($r0, r1) 

(declare-const var2809!2 var2942)
(declare-const var579!1 var432)
(define-const var2675 String (address/-1013415841 var579!1)) ; Statement: $r2 = r1.<org.apache.dubbo.config.ConfigCenterConfig: java.lang.String address> 
(define-const var3738 Bool (var2265_isEmpty/-813097145 var2675)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r2) 
 ; Statement: if $z0 == 0 goto $r3 = class "Lorg/apache/dubbo/config/ConfigCenterConfig;" 
(assert (= (ite var3738 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3951 ClassObject var432!class) ; Statement: $r3 = class "Lorg/apache/dubbo/config/ConfigCenterConfig;" 
(assert true)
(define-const var768 String (getName/-1958580599 var3951)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.Class: java.lang.String getName()>() 
;(assert (var3625_put/1464166817 (cast-from-var2942-to-var3625 var2809!2) (cast-from-String-to-var3599 "path") (cast-from-String-to-var3599 var768))) ; Statement: interfaceinvoke $r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("path", $r4) 

(declare-const var2809!3 var2942)
(declare-const var2230 String)
(declare-const var768!1 String)
(define-const var2172 var3599 (var3625_get/1088891777 (cast-from-var2942-to-var3625 var2809!3) (cast-from-String-to-var3599 "protocol"))) ; Statement: $r5 = interfaceinvoke $r0.<java.util.Map: java.lang.Object get(java.lang.Object)>("protocol") 
(define-const var2662 String (cast-from-var3599-to-String var2172)) ; Statement: $r6 = (java.lang.String) $r5 
(define-const var3771 Bool (var2265_isEmpty/-813097145 var2662)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r6) 
 ; Statement: if $z1 == 0 goto $r7 = r1.<org.apache.dubbo.config.ConfigCenterConfig: java.lang.String address> 
(assert (= (ite var3771 1 0) 0)) ; Cond: $z1 == 0 
(define-const var45 String (address/-1013415841 var579!1)) ; Statement: $r7 = r1.<org.apache.dubbo.config.ConfigCenterConfig: java.lang.String address> 
(define-const var1148 var50 (var3252_parseURL/640513066 var45 (cast-from-var2942-to-var3625 var2809!3))) ; Statement: $r9 = staticinvoke <org.apache.dubbo.common.utils.UrlUtils: org.apache.dubbo.common.URL parseURL(java.lang.String,java.util.Map)>($r7, $r0) 
(assert true)
(define-const var2902 var3418 (getScopeModel/-569440683 (cast-from-var432-to-var32 var579!1))) ; Statement: $r8 = virtualinvoke r1.<org.apache.dubbo.config.ConfigCenterConfig: org.apache.dubbo.rpc.model.ScopeModel getScopeModel()>() 
(assert true)
(define-const var563 var50 (setScopeModel/-1563758557 var1148 var2902)) ; Statement: $r10 = virtualinvoke $r9.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL setScopeModel(org.apache.dubbo.rpc.model.ScopeModel)>($r8) 
 ; Statement: return $r10 
(check-sat)
; {var2942-init=([], java.util.HashMap), <init>/-201242697=([java.util.HashMap], void), var32_appendParameters/-678393988=([java.util.Map, java.lang.Object], void), cast-from-var2942-to-var3625=([java.util.HashMap], java.util.Map), cast-from-var432-to-var3599=([org.apache.dubbo.config.ConfigCenterConfig], java.lang.Object), address/-1013415841=([org.apache.dubbo.config.ConfigCenterConfig], java.lang.String), var2265_isEmpty/-813097145=([java.lang.String], boolean), getName/-1958580599=([java.lang.Class], java.lang.String), var3625_put/1464166817=([java.util.Map, java.lang.Object, java.lang.Object], java.lang.Object), cast-from-String-to-var3599=([java.lang.String], java.lang.Object), var3625_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-var3599-to-String=([java.lang.Object], java.lang.String), var3252_parseURL/640513066=([java.lang.String, java.util.Map], org.apache.dubbo.common.URL), getScopeModel/-569440683=([org.apache.dubbo.config.AbstractConfig], org.apache.dubbo.rpc.model.ScopeModel), cast-from-var432-to-var32=([org.apache.dubbo.config.ConfigCenterConfig], org.apache.dubbo.config.AbstractConfig), setScopeModel/-1563758557=([org.apache.dubbo.common.URL, org.apache.dubbo.rpc.model.ScopeModel], org.apache.dubbo.common.URL)}
; {var432=org.apache.dubbo.config.ConfigCenterConfig, var579=r1, var2942=java.util.HashMap, var2809=$r0, var32=org.apache.dubbo.config.AbstractConfig, var3625=java.util.Map, var3599=java.lang.Object, var2675=$r2, var2265=org.apache.dubbo.common.utils.StringUtils, var3738=$z0, var3951=$r3, var768=$r4, var2230="path", var2172=$r5, var2662=$r6, var3771=$z1, var45=$r7, var50=org.apache.dubbo.common.URL, var3252=org.apache.dubbo.common.utils.UrlUtils, var1148=$r9, var3418=org.apache.dubbo.rpc.model.ScopeModel, var2902=$r8, var563=$r10}
; {org.apache.dubbo.config.ConfigCenterConfig=var432, r1=var579, java.util.HashMap=var2942, $r0=var2809, org.apache.dubbo.config.AbstractConfig=var32, java.util.Map=var3625, java.lang.Object=var3599, $r2=var2675, org.apache.dubbo.common.utils.StringUtils=var2265, $z0=var3738, $r3=var3951, $r4=var768, "path"=var2230, $r5=var2172, $r6=var2662, $z1=var3771, $r7=var45, org.apache.dubbo.common.URL=var50, org.apache.dubbo.common.utils.UrlUtils=var3252, $r9=var1148, org.apache.dubbo.rpc.model.ScopeModel=var3418, $r8=var2902, $r10=var563}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 2}
;stmts r1 := @this: org.apache.dubbo.config.ConfigCenterConfig;	$r0 = new java.util.HashMap;	specialinvoke $r0.<java.util.HashMap: void <init>()>();	staticinvoke <org.apache.dubbo.config.ConfigCenterConfig: void appendParameters(java.util.Map,java.lang.Object)>($r0, r1);	$r2 = r1.<org.apache.dubbo.config.ConfigCenterConfig: java.lang.String address>;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r2);	if $z0 == 0 goto $r3 = class "Lorg/apache/dubbo/config/ConfigCenterConfig;";	$r3 = class "Lorg/apache/dubbo/config/ConfigCenterConfig;";	$r4 = virtualinvoke $r3.<java.lang.Class: java.lang.String getName()>();	interfaceinvoke $r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("path", $r4);	$r5 = interfaceinvoke $r0.<java.util.Map: java.lang.Object get(java.lang.Object)>("protocol");	$r6 = (java.lang.String) $r5;	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r6);	if $z1 == 0 goto $r7 = r1.<org.apache.dubbo.config.ConfigCenterConfig: java.lang.String address>;	$r7 = r1.<org.apache.dubbo.config.ConfigCenterConfig: java.lang.String address>;	$r9 = staticinvoke <org.apache.dubbo.common.utils.UrlUtils: org.apache.dubbo.common.URL parseURL(java.lang.String,java.util.Map)>($r7, $r0);	$r8 = virtualinvoke r1.<org.apache.dubbo.config.ConfigCenterConfig: org.apache.dubbo.rpc.model.ScopeModel getScopeModel()>();	$r10 = virtualinvoke $r9.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL setScopeModel(org.apache.dubbo.rpc.model.ScopeModel)>($r8);	return $r10
;block_num 3