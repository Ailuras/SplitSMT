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

(declare-sort var3022 0)
(declare-sort var1153 0)
(declare-sort var3386 0)
(declare-sort var73 0)
(declare-sort var3981 0)
(declare-sort var197 0)
(declare-sort var2735 0)
(declare-sort var615 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var2735!class ClassObject)
(declare-fun var1153_get/1088891777 (var1153 var3386) var3386)
(declare-fun cast-from-String-to-var3386 (String) var3386)
(declare-fun cast-from-var3386-to-String (var3386) String)
(declare-fun var73_isNotEmpty/-1251449450 (String) Bool)
(declare-fun applicationModel/564502169 (var3022) var3981)
(declare-fun getExtensionLoader/-514331157 (var615 ClassObject) var197)
(declare-fun cast-from-var3981-to-var615 (var3981) var615)
(declare-fun getExtension/-1809037860 (var197 String) var3386)
(declare-fun cast-from-var3386-to-var2735 (var3386) var2735)
(declare-fun var2735_mergeLocalParams/237922429 (var2735 var1153) var1153)
(declare-const null-var3022 var3022)
(declare-const null-var1153 var1153)
(declare-const var1219 var3022) ; Statement: r3 := @this: org.apache.dubbo.rpc.cluster.support.ClusterUtils 
(assert (not (= var1219 null-var3022)))
(declare-const var3377 var1153) ; Statement: r0 := @parameter0: java.util.Map 
(assert (not (= var3377 null-var1153)))
(define-const var2204 var3386 (var1153_get/1088891777 var3377 (cast-from-String-to-var3386 "url-merge-processor"))) ; Statement: $r1 = interfaceinvoke r0.<java.util.Map: java.lang.Object get(java.lang.Object)>("url-merge-processor") 
(define-const var3984 String (cast-from-var3386-to-String var2204)) ; Statement: r2 = (java.lang.String) $r1 
(define-const var574 Bool (var73_isNotEmpty/-1251449450 var3984)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r2) 
 ; Statement: if $z0 == 0 goto $r4 = r3.<org.apache.dubbo.rpc.cluster.support.ClusterUtils: org.apache.dubbo.rpc.model.ApplicationModel applicationModel> 
(assert (= (ite var574 1 0) 0)) ; Cond: $z0 == 0 
(define-const var799 var3981 (applicationModel/564502169 var1219)) ; Statement: $r4 = r3.<org.apache.dubbo.rpc.cluster.support.ClusterUtils: org.apache.dubbo.rpc.model.ApplicationModel applicationModel> 
(assert true)
(define-const var3462 var197 (getExtensionLoader/-514331157 (cast-from-var3981-to-var615 var799) var2735!class)) ; Statement: $r5 = virtualinvoke $r4.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/rpc/cluster/ProviderURLMergeProcessor;") 
(assert true)
(define-const var3045 var3386 (getExtension/-1809037860 var3462 "default")) ; Statement: $r6 = virtualinvoke $r5.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Object getExtension(java.lang.String)>("default") 
(define-const var3231 var2735 (cast-from-var3386-to-var2735 var3045)) ; Statement: r11 = (org.apache.dubbo.rpc.cluster.ProviderURLMergeProcessor) $r6 
(assert true) ; Non Conditional
(define-const var1844 var1153 (var2735_mergeLocalParams/237922429 var3231 var3377)) ; Statement: $r7 = interfaceinvoke r11.<org.apache.dubbo.rpc.cluster.ProviderURLMergeProcessor: java.util.Map mergeLocalParams(java.util.Map)>(r0) 
 ; Statement: return $r7 
(check-sat)
; {var1153_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-String-to-var3386=([java.lang.String], java.lang.Object), cast-from-var3386-to-String=([java.lang.Object], java.lang.String), var73_isNotEmpty/-1251449450=([java.lang.String], boolean), applicationModel/564502169=([org.apache.dubbo.rpc.cluster.support.ClusterUtils], org.apache.dubbo.rpc.model.ApplicationModel), getExtensionLoader/-514331157=([org.apache.dubbo.common.extension.ExtensionAccessor, java.lang.Class], org.apache.dubbo.common.extension.ExtensionLoader), cast-from-var3981-to-var615=([org.apache.dubbo.rpc.model.ApplicationModel], org.apache.dubbo.common.extension.ExtensionAccessor), getExtension/-1809037860=([org.apache.dubbo.common.extension.ExtensionLoader, java.lang.String], java.lang.Object), cast-from-var3386-to-var2735=([java.lang.Object], org.apache.dubbo.rpc.cluster.ProviderURLMergeProcessor), var2735_mergeLocalParams/237922429=([org.apache.dubbo.rpc.cluster.ProviderURLMergeProcessor, java.util.Map], java.util.Map)}
; {var3022=org.apache.dubbo.rpc.cluster.support.ClusterUtils, var1219=r3, var1153=java.util.Map, var3377=r0, var3386=java.lang.Object, var2204=$r1, var3984=r2, var73=org.apache.dubbo.common.utils.StringUtils, var574=$z0, var3981=org.apache.dubbo.rpc.model.ApplicationModel, var799=$r4, var197=org.apache.dubbo.common.extension.ExtensionLoader, var2735=org.apache.dubbo.rpc.cluster.ProviderURLMergeProcessor, var615=org.apache.dubbo.common.extension.ExtensionAccessor, var3462=$r5, var3045=$r6, var3231=r11, var1844=$r7}
; {org.apache.dubbo.rpc.cluster.support.ClusterUtils=var3022, r3=var1219, java.util.Map=var1153, r0=var3377, java.lang.Object=var3386, $r1=var2204, r2=var3984, org.apache.dubbo.common.utils.StringUtils=var73, $z0=var574, org.apache.dubbo.rpc.model.ApplicationModel=var3981, $r4=var799, org.apache.dubbo.common.extension.ExtensionLoader=var197, org.apache.dubbo.rpc.cluster.ProviderURLMergeProcessor=var2735, org.apache.dubbo.common.extension.ExtensionAccessor=var615, $r5=var3462, $r6=var3045, r11=var3231, $r7=var1844}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r3 := @this: org.apache.dubbo.rpc.cluster.support.ClusterUtils;	r0 := @parameter0: java.util.Map;	$r1 = interfaceinvoke r0.<java.util.Map: java.lang.Object get(java.lang.Object)>("url-merge-processor");	r2 = (java.lang.String) $r1;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r2);	if $z0 == 0 goto $r4 = r3.<org.apache.dubbo.rpc.cluster.support.ClusterUtils: org.apache.dubbo.rpc.model.ApplicationModel applicationModel>;	$r4 = r3.<org.apache.dubbo.rpc.cluster.support.ClusterUtils: org.apache.dubbo.rpc.model.ApplicationModel applicationModel>;	$r5 = virtualinvoke $r4.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/rpc/cluster/ProviderURLMergeProcessor;");	$r6 = virtualinvoke $r5.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Object getExtension(java.lang.String)>("default");	r11 = (org.apache.dubbo.rpc.cluster.ProviderURLMergeProcessor) $r6;	$r7 = interfaceinvoke r11.<org.apache.dubbo.rpc.cluster.ProviderURLMergeProcessor: java.util.Map mergeLocalParams(java.util.Map)>(r0);	return $r7
;block_num 3