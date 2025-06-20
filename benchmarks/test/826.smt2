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

(declare-sort var1673 0)
(declare-sort var3779 0)
(declare-sort var3149 0)
(declare-sort var1864 0)
(declare-sort var3457 0)
(declare-sort var592 0)
(declare-sort var1025 0)
(declare-sort var2937 0)
(declare-sort var3624 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var2937!class ClassObject)
(declare-fun var3149_get/1088891777 (var3149 var1864) var1864)
(declare-fun cast-from-String-to-var1864 (String) var1864)
(declare-fun cast-from-var1864-to-String (var1864) String)
(declare-fun var3457_isNotEmpty/-1251449450 (String) Bool)
(declare-fun applicationModel/564502169 (var1673) var592)
(declare-fun getExtensionLoader/-514331157 (var3624 ClassObject) var1025)
(declare-fun cast-from-var592-to-var3624 (var592) var3624)
(declare-fun getExtension/-1809037860 (var1025 String) var1864)
(declare-fun cast-from-var1864-to-var2937 (var1864) var2937)
(declare-fun var2937_mergeUrl/-1868010357 (var2937 var3779 var3149) var3779)
(declare-const null-var1673 var1673)
(declare-const null-var3779 var3779)
(declare-const null-var3149 var3149)
(declare-const var86 var1673) ; Statement: r3 := @this: org.apache.dubbo.rpc.cluster.support.ClusterUtils 
(assert (not (= var86 null-var1673)))
(declare-const var1807 var3779) ; Statement: r7 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var1807 null-var3779)))
(declare-const var2828 var3149) ; Statement: r0 := @parameter1: java.util.Map 
(assert (not (= var2828 null-var3149)))
(define-const var3458 var1864 (var3149_get/1088891777 var2828 (cast-from-String-to-var1864 "url-merge-processor"))) ; Statement: $r1 = interfaceinvoke r0.<java.util.Map: java.lang.Object get(java.lang.Object)>("url-merge-processor") 
(define-const var2470 String (cast-from-var1864-to-String var3458)) ; Statement: r2 = (java.lang.String) $r1 
(define-const var9 Bool (var3457_isNotEmpty/-1251449450 var2470)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r2) 
 ; Statement: if $z0 == 0 goto $r4 = r3.<org.apache.dubbo.rpc.cluster.support.ClusterUtils: org.apache.dubbo.rpc.model.ApplicationModel applicationModel> 
(assert (= (ite var9 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3607 var592 (applicationModel/564502169 var86)) ; Statement: $r4 = r3.<org.apache.dubbo.rpc.cluster.support.ClusterUtils: org.apache.dubbo.rpc.model.ApplicationModel applicationModel> 
(assert true)
(define-const var1090 var1025 (getExtensionLoader/-514331157 (cast-from-var592-to-var3624 var3607) var2937!class)) ; Statement: $r5 = virtualinvoke $r4.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/rpc/cluster/ProviderURLMergeProcessor;") 
(assert true)
(define-const var2899 var1864 (getExtension/-1809037860 var1090 "default")) ; Statement: $r6 = virtualinvoke $r5.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Object getExtension(java.lang.String)>("default") 
(define-const var406 var2937 (cast-from-var1864-to-var2937 var2899)) ; Statement: r12 = (org.apache.dubbo.rpc.cluster.ProviderURLMergeProcessor) $r6 
(assert true) ; Non Conditional
(define-const var3349 var3779 (var2937_mergeUrl/-1868010357 var406 var1807 var2828)) ; Statement: $r8 = interfaceinvoke r12.<org.apache.dubbo.rpc.cluster.ProviderURLMergeProcessor: org.apache.dubbo.common.URL mergeUrl(org.apache.dubbo.common.URL,java.util.Map)>(r7, r0) 
 ; Statement: return $r8 
(check-sat)
; {var3149_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-String-to-var1864=([java.lang.String], java.lang.Object), cast-from-var1864-to-String=([java.lang.Object], java.lang.String), var3457_isNotEmpty/-1251449450=([java.lang.String], boolean), applicationModel/564502169=([org.apache.dubbo.rpc.cluster.support.ClusterUtils], org.apache.dubbo.rpc.model.ApplicationModel), getExtensionLoader/-514331157=([org.apache.dubbo.common.extension.ExtensionAccessor, java.lang.Class], org.apache.dubbo.common.extension.ExtensionLoader), cast-from-var592-to-var3624=([org.apache.dubbo.rpc.model.ApplicationModel], org.apache.dubbo.common.extension.ExtensionAccessor), getExtension/-1809037860=([org.apache.dubbo.common.extension.ExtensionLoader, java.lang.String], java.lang.Object), cast-from-var1864-to-var2937=([java.lang.Object], org.apache.dubbo.rpc.cluster.ProviderURLMergeProcessor), var2937_mergeUrl/-1868010357=([org.apache.dubbo.rpc.cluster.ProviderURLMergeProcessor, org.apache.dubbo.common.URL, java.util.Map], org.apache.dubbo.common.URL)}
; {var1673=org.apache.dubbo.rpc.cluster.support.ClusterUtils, var86=r3, var3779=org.apache.dubbo.common.URL, var1807=r7, var3149=java.util.Map, var2828=r0, var1864=java.lang.Object, var3458=$r1, var2470=r2, var3457=org.apache.dubbo.common.utils.StringUtils, var9=$z0, var592=org.apache.dubbo.rpc.model.ApplicationModel, var3607=$r4, var1025=org.apache.dubbo.common.extension.ExtensionLoader, var2937=org.apache.dubbo.rpc.cluster.ProviderURLMergeProcessor, var3624=org.apache.dubbo.common.extension.ExtensionAccessor, var1090=$r5, var2899=$r6, var406=r12, var3349=$r8}
; {org.apache.dubbo.rpc.cluster.support.ClusterUtils=var1673, r3=var86, org.apache.dubbo.common.URL=var3779, r7=var1807, java.util.Map=var3149, r0=var2828, java.lang.Object=var1864, $r1=var3458, r2=var2470, org.apache.dubbo.common.utils.StringUtils=var3457, $z0=var9, org.apache.dubbo.rpc.model.ApplicationModel=var592, $r4=var3607, org.apache.dubbo.common.extension.ExtensionLoader=var1025, org.apache.dubbo.rpc.cluster.ProviderURLMergeProcessor=var2937, org.apache.dubbo.common.extension.ExtensionAccessor=var3624, $r5=var1090, $r6=var2899, r12=var406, $r8=var3349}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r3 := @this: org.apache.dubbo.rpc.cluster.support.ClusterUtils;	r7 := @parameter0: org.apache.dubbo.common.URL;	r0 := @parameter1: java.util.Map;	$r1 = interfaceinvoke r0.<java.util.Map: java.lang.Object get(java.lang.Object)>("url-merge-processor");	r2 = (java.lang.String) $r1;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r2);	if $z0 == 0 goto $r4 = r3.<org.apache.dubbo.rpc.cluster.support.ClusterUtils: org.apache.dubbo.rpc.model.ApplicationModel applicationModel>;	$r4 = r3.<org.apache.dubbo.rpc.cluster.support.ClusterUtils: org.apache.dubbo.rpc.model.ApplicationModel applicationModel>;	$r5 = virtualinvoke $r4.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/rpc/cluster/ProviderURLMergeProcessor;");	$r6 = virtualinvoke $r5.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Object getExtension(java.lang.String)>("default");	r12 = (org.apache.dubbo.rpc.cluster.ProviderURLMergeProcessor) $r6;	$r8 = interfaceinvoke r12.<org.apache.dubbo.rpc.cluster.ProviderURLMergeProcessor: org.apache.dubbo.common.URL mergeUrl(org.apache.dubbo.common.URL,java.util.Map)>(r7, r0);	return $r8
;block_num 3