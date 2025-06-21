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

(declare-sort var1986 0)
(declare-sort var3064 0)
(declare-sort var1916 0)
(declare-sort var449 0)
(declare-sort var2685 0)
(declare-sort var1071 0)
(declare-sort var2924 0)
(declare-sort var2200 0)
(declare-sort var736 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var2200!class ClassObject)
(declare-fun var1916_get/1088891777 (var1916 var449) var449)
(declare-fun cast-from-String-to-var449 (String) var449)
(declare-fun cast-from-var449-to-String (var449) String)
(declare-fun var2685_isNotEmpty/-1251449450 (String) Bool)
(declare-fun applicationModel/564502169 (var1986) var1071)
(declare-fun getExtensionLoader/-514331157 (var736 ClassObject) var2924)
(declare-fun cast-from-var1071-to-var736 (var1071) var736)
(declare-fun getExtension/-1809037860 (var2924 String) var449)
(declare-fun cast-from-var449-to-var2200 (var449) var2200)
(declare-fun var2200_mergeUrl/-1868010357 (var2200 var3064 var1916) var3064)
(declare-const null-var1986 var1986)
(declare-const null-var3064 var3064)
(declare-const null-var1916 var1916)
(declare-const var1088 var1986) ; Statement: r3 := @this: org.apache.dubbo.rpc.cluster.support.ClusterUtils 
(assert (not (= var1088 null-var1986)))
(declare-const var2669 var3064) ; Statement: r7 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var2669 null-var3064)))
(declare-const var37 var1916) ; Statement: r0 := @parameter1: java.util.Map 
(assert (not (= var37 null-var1916)))
(define-const var3628 var449 (var1916_get/1088891777 var37 (cast-from-String-to-var449 "url-merge-processor"))) ; Statement: $r1 = interfaceinvoke r0.<java.util.Map: java.lang.Object get(java.lang.Object)>("url-merge-processor") 
(define-const var2632 String (cast-from-var449-to-String var3628)) ; Statement: r2 = (java.lang.String) $r1 
(define-const var2295 Bool (var2685_isNotEmpty/-1251449450 var2632)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r2) 
 ; Statement: if $z0 == 0 goto $r4 = r3.<org.apache.dubbo.rpc.cluster.support.ClusterUtils: org.apache.dubbo.rpc.model.ApplicationModel applicationModel> 
(assert (not (= (ite var2295 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var841 var1071 (applicationModel/564502169 var1088)) ; Statement: $r9 = r3.<org.apache.dubbo.rpc.cluster.support.ClusterUtils: org.apache.dubbo.rpc.model.ApplicationModel applicationModel> 
(assert true)
(define-const var772 var2924 (getExtensionLoader/-514331157 (cast-from-var1071-to-var736 var841) var2200!class)) ; Statement: $r10 = virtualinvoke $r9.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/rpc/cluster/ProviderURLMergeProcessor;") 
(assert true)
(define-const var3566 var449 (getExtension/-1809037860 var772 var2632)) ; Statement: $r11 = virtualinvoke $r10.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Object getExtension(java.lang.String)>(r2) 
(define-const var3796 var2200 (cast-from-var449-to-var2200 var3566)) ; Statement: r12 = (org.apache.dubbo.rpc.cluster.ProviderURLMergeProcessor) $r11 
 ; Statement: goto [?= $r8 = interfaceinvoke r12.<org.apache.dubbo.rpc.cluster.ProviderURLMergeProcessor: org.apache.dubbo.common.URL mergeUrl(org.apache.dubbo.common.URL,java.util.Map)>(r7, r0)] 
(assert true) ; Non Conditional
(define-const var3251 var3064 (var2200_mergeUrl/-1868010357 var3796 var2669 var37)) ; Statement: $r8 = interfaceinvoke r12.<org.apache.dubbo.rpc.cluster.ProviderURLMergeProcessor: org.apache.dubbo.common.URL mergeUrl(org.apache.dubbo.common.URL,java.util.Map)>(r7, r0) 
 ; Statement: return $r8 
(check-sat)
; {var1916_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-String-to-var449=([java.lang.String], java.lang.Object), cast-from-var449-to-String=([java.lang.Object], java.lang.String), var2685_isNotEmpty/-1251449450=([java.lang.String], boolean), applicationModel/564502169=([org.apache.dubbo.rpc.cluster.support.ClusterUtils], org.apache.dubbo.rpc.model.ApplicationModel), getExtensionLoader/-514331157=([org.apache.dubbo.common.extension.ExtensionAccessor, java.lang.Class], org.apache.dubbo.common.extension.ExtensionLoader), cast-from-var1071-to-var736=([org.apache.dubbo.rpc.model.ApplicationModel], org.apache.dubbo.common.extension.ExtensionAccessor), getExtension/-1809037860=([org.apache.dubbo.common.extension.ExtensionLoader, java.lang.String], java.lang.Object), cast-from-var449-to-var2200=([java.lang.Object], org.apache.dubbo.rpc.cluster.ProviderURLMergeProcessor), var2200_mergeUrl/-1868010357=([org.apache.dubbo.rpc.cluster.ProviderURLMergeProcessor, org.apache.dubbo.common.URL, java.util.Map], org.apache.dubbo.common.URL)}
; {var1986=org.apache.dubbo.rpc.cluster.support.ClusterUtils, var1088=r3, var3064=org.apache.dubbo.common.URL, var2669=r7, var1916=java.util.Map, var37=r0, var449=java.lang.Object, var3628=$r1, var2632=r2, var2685=org.apache.dubbo.common.utils.StringUtils, var2295=$z0, var1071=org.apache.dubbo.rpc.model.ApplicationModel, var841=$r9, var2924=org.apache.dubbo.common.extension.ExtensionLoader, var2200=org.apache.dubbo.rpc.cluster.ProviderURLMergeProcessor, var736=org.apache.dubbo.common.extension.ExtensionAccessor, var772=$r10, var3566=$r11, var3796=r12, var3251=$r8}
; {org.apache.dubbo.rpc.cluster.support.ClusterUtils=var1986, r3=var1088, org.apache.dubbo.common.URL=var3064, r7=var2669, java.util.Map=var1916, r0=var37, java.lang.Object=var449, $r1=var3628, r2=var2632, org.apache.dubbo.common.utils.StringUtils=var2685, $z0=var2295, org.apache.dubbo.rpc.model.ApplicationModel=var1071, $r9=var841, org.apache.dubbo.common.extension.ExtensionLoader=var2924, org.apache.dubbo.rpc.cluster.ProviderURLMergeProcessor=var2200, org.apache.dubbo.common.extension.ExtensionAccessor=var736, $r10=var772, $r11=var3566, r12=var3796, $r8=var3251}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r3 := @this: org.apache.dubbo.rpc.cluster.support.ClusterUtils;	r7 := @parameter0: org.apache.dubbo.common.URL;	r0 := @parameter1: java.util.Map;	$r1 = interfaceinvoke r0.<java.util.Map: java.lang.Object get(java.lang.Object)>("url-merge-processor");	r2 = (java.lang.String) $r1;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r2);	if $z0 == 0 goto $r4 = r3.<org.apache.dubbo.rpc.cluster.support.ClusterUtils: org.apache.dubbo.rpc.model.ApplicationModel applicationModel>;	$r9 = r3.<org.apache.dubbo.rpc.cluster.support.ClusterUtils: org.apache.dubbo.rpc.model.ApplicationModel applicationModel>;	$r10 = virtualinvoke $r9.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/rpc/cluster/ProviderURLMergeProcessor;");	$r11 = virtualinvoke $r10.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Object getExtension(java.lang.String)>(r2);	r12 = (org.apache.dubbo.rpc.cluster.ProviderURLMergeProcessor) $r11;	goto [?= $r8 = interfaceinvoke r12.<org.apache.dubbo.rpc.cluster.ProviderURLMergeProcessor: org.apache.dubbo.common.URL mergeUrl(org.apache.dubbo.common.URL,java.util.Map)>(r7, r0)];	$r8 = interfaceinvoke r12.<org.apache.dubbo.rpc.cluster.ProviderURLMergeProcessor: org.apache.dubbo.common.URL mergeUrl(org.apache.dubbo.common.URL,java.util.Map)>(r7, r0);	return $r8
;block_num 3