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

(declare-sort var2629 0)
(declare-sort var3224 0)
(declare-sort var3718 0)
(declare-sort var1982 0)
(declare-sort var3496 0)
(declare-sort var354 0)
(declare-sort var2238 0)
(declare-sort var704 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var2238!class ClassObject)
(declare-fun var3224_get/1088891777 (var3224 var3718) var3718)
(declare-fun cast-from-String-to-var3718 (String) var3718)
(declare-fun cast-from-var3718-to-String (var3718) String)
(declare-fun var1982_isNotEmpty/-1251449450 (String) Bool)
(declare-fun applicationModel/564502169 (var2629) var3496)
(declare-fun getExtensionLoader/-514331157 (var704 ClassObject) var354)
(declare-fun cast-from-var3496-to-var704 (var3496) var704)
(declare-fun getExtension/-1809037860 (var354 String) var3718)
(declare-fun cast-from-var3718-to-var2238 (var3718) var2238)
(declare-fun var2238_mergeLocalParams/237922429 (var2238 var3224) var3224)
(declare-const null-var2629 var2629)
(declare-const null-var3224 var3224)
(declare-const var3986 var2629) ; Statement: r3 := @this: org.apache.dubbo.rpc.cluster.support.ClusterUtils 
(assert (not (= var3986 null-var2629)))
(declare-const var3642 var3224) ; Statement: r0 := @parameter0: java.util.Map 
(assert (not (= var3642 null-var3224)))
(define-const var461 var3718 (var3224_get/1088891777 var3642 (cast-from-String-to-var3718 "url-merge-processor"))) ; Statement: $r1 = interfaceinvoke r0.<java.util.Map: java.lang.Object get(java.lang.Object)>("url-merge-processor") 
(define-const var2917 String (cast-from-var3718-to-String var461)) ; Statement: r2 = (java.lang.String) $r1 
(define-const var575 Bool (var1982_isNotEmpty/-1251449450 var2917)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r2) 
 ; Statement: if $z0 == 0 goto $r4 = r3.<org.apache.dubbo.rpc.cluster.support.ClusterUtils: org.apache.dubbo.rpc.model.ApplicationModel applicationModel> 
(assert (not (= (ite var575 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var1630 var3496 (applicationModel/564502169 var3986)) ; Statement: $r8 = r3.<org.apache.dubbo.rpc.cluster.support.ClusterUtils: org.apache.dubbo.rpc.model.ApplicationModel applicationModel> 
(assert true)
(define-const var2567 var354 (getExtensionLoader/-514331157 (cast-from-var3496-to-var704 var1630) var2238!class)) ; Statement: $r9 = virtualinvoke $r8.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/rpc/cluster/ProviderURLMergeProcessor;") 
(assert true)
(define-const var2769 var3718 (getExtension/-1809037860 var2567 var2917)) ; Statement: $r10 = virtualinvoke $r9.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Object getExtension(java.lang.String)>(r2) 
(define-const var1175 var2238 (cast-from-var3718-to-var2238 var2769)) ; Statement: r11 = (org.apache.dubbo.rpc.cluster.ProviderURLMergeProcessor) $r10 
 ; Statement: goto [?= $r7 = interfaceinvoke r11.<org.apache.dubbo.rpc.cluster.ProviderURLMergeProcessor: java.util.Map mergeLocalParams(java.util.Map)>(r0)] 
(assert true) ; Non Conditional
(define-const var1296 var3224 (var2238_mergeLocalParams/237922429 var1175 var3642)) ; Statement: $r7 = interfaceinvoke r11.<org.apache.dubbo.rpc.cluster.ProviderURLMergeProcessor: java.util.Map mergeLocalParams(java.util.Map)>(r0) 
 ; Statement: return $r7 
(check-sat)
; {var3224_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-String-to-var3718=([java.lang.String], java.lang.Object), cast-from-var3718-to-String=([java.lang.Object], java.lang.String), var1982_isNotEmpty/-1251449450=([java.lang.String], boolean), applicationModel/564502169=([org.apache.dubbo.rpc.cluster.support.ClusterUtils], org.apache.dubbo.rpc.model.ApplicationModel), getExtensionLoader/-514331157=([org.apache.dubbo.common.extension.ExtensionAccessor, java.lang.Class], org.apache.dubbo.common.extension.ExtensionLoader), cast-from-var3496-to-var704=([org.apache.dubbo.rpc.model.ApplicationModel], org.apache.dubbo.common.extension.ExtensionAccessor), getExtension/-1809037860=([org.apache.dubbo.common.extension.ExtensionLoader, java.lang.String], java.lang.Object), cast-from-var3718-to-var2238=([java.lang.Object], org.apache.dubbo.rpc.cluster.ProviderURLMergeProcessor), var2238_mergeLocalParams/237922429=([org.apache.dubbo.rpc.cluster.ProviderURLMergeProcessor, java.util.Map], java.util.Map)}
; {var2629=org.apache.dubbo.rpc.cluster.support.ClusterUtils, var3986=r3, var3224=java.util.Map, var3642=r0, var3718=java.lang.Object, var461=$r1, var2917=r2, var1982=org.apache.dubbo.common.utils.StringUtils, var575=$z0, var3496=org.apache.dubbo.rpc.model.ApplicationModel, var1630=$r8, var354=org.apache.dubbo.common.extension.ExtensionLoader, var2238=org.apache.dubbo.rpc.cluster.ProviderURLMergeProcessor, var704=org.apache.dubbo.common.extension.ExtensionAccessor, var2567=$r9, var2769=$r10, var1175=r11, var1296=$r7}
; {org.apache.dubbo.rpc.cluster.support.ClusterUtils=var2629, r3=var3986, java.util.Map=var3224, r0=var3642, java.lang.Object=var3718, $r1=var461, r2=var2917, org.apache.dubbo.common.utils.StringUtils=var1982, $z0=var575, org.apache.dubbo.rpc.model.ApplicationModel=var3496, $r8=var1630, org.apache.dubbo.common.extension.ExtensionLoader=var354, org.apache.dubbo.rpc.cluster.ProviderURLMergeProcessor=var2238, org.apache.dubbo.common.extension.ExtensionAccessor=var704, $r9=var2567, $r10=var2769, r11=var1175, $r7=var1296}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r3 := @this: org.apache.dubbo.rpc.cluster.support.ClusterUtils;	r0 := @parameter0: java.util.Map;	$r1 = interfaceinvoke r0.<java.util.Map: java.lang.Object get(java.lang.Object)>("url-merge-processor");	r2 = (java.lang.String) $r1;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r2);	if $z0 == 0 goto $r4 = r3.<org.apache.dubbo.rpc.cluster.support.ClusterUtils: org.apache.dubbo.rpc.model.ApplicationModel applicationModel>;	$r8 = r3.<org.apache.dubbo.rpc.cluster.support.ClusterUtils: org.apache.dubbo.rpc.model.ApplicationModel applicationModel>;	$r9 = virtualinvoke $r8.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/rpc/cluster/ProviderURLMergeProcessor;");	$r10 = virtualinvoke $r9.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Object getExtension(java.lang.String)>(r2);	r11 = (org.apache.dubbo.rpc.cluster.ProviderURLMergeProcessor) $r10;	goto [?= $r7 = interfaceinvoke r11.<org.apache.dubbo.rpc.cluster.ProviderURLMergeProcessor: java.util.Map mergeLocalParams(java.util.Map)>(r0)];	$r7 = interfaceinvoke r11.<org.apache.dubbo.rpc.cluster.ProviderURLMergeProcessor: java.util.Map mergeLocalParams(java.util.Map)>(r0);	return $r7
;block_num 3