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

(declare-sort var1225 0)
(declare-sort var3460 0)
(declare-sort var2716 0)
(declare-sort var294 0)
(declare-sort var2147 0)
(declare-sort var1041 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var2716!class ClassObject)
(declare-fun getExtensionLoader/-514331157 (var294 ClassObject) var3460)
(declare-fun cast-from-var1225-to-var294 (var1225) var294)
(declare-fun var2716_getMode/-582985525 (var1225) String)
(declare-fun var2147_isNotEmpty/-1251449450 (String) Bool)
(declare-fun getExtension/-1809037860 (var3460 String) var1041)
(declare-fun cast-from-var1041-to-var2716 (var1041) var2716)
(declare-const null-var1225 var1225)
(declare-const var183 var1225) ; Statement: r0 := @parameter0: org.apache.dubbo.rpc.model.ApplicationModel 
(assert (not (= var183 null-var1225)))
(assert true)
(define-const var1187 var3460 (getExtensionLoader/-514331157 (cast-from-var1225-to-var294 var183) var2716!class)) ; Statement: r1 = virtualinvoke r0.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/common/threadpool/manager/ExecutorRepository;") 
(define-const var647 String (var2716_getMode/-582985525 var183)) ; Statement: r2 = staticinvoke <org.apache.dubbo.common.threadpool.manager.ExecutorRepository: java.lang.String getMode(org.apache.dubbo.rpc.model.ApplicationModel)>(r0) 
(define-const var2375 Bool (var2147_isNotEmpty/-1251449450 var647)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r2) 
 ; Statement: if $z0 == 0 goto $r3 = virtualinvoke r1.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Object getDefaultExtension()>() 
(assert (not (= (ite var2375 1 0) 0))) ; Negate: Cond: $z0 == 0  
(assert true)
(define-const var2599 var1041 (getExtension/-1809037860 var1187 var647)) ; Statement: $r4 = virtualinvoke r1.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Object getExtension(java.lang.String)>(r2) 
(define-const var2005 var2716 (cast-from-var1041-to-var2716 var2599)) ; Statement: $r5 = (org.apache.dubbo.common.threadpool.manager.ExecutorRepository) $r4 
 ; Statement: goto [?= return $r5] 
(assert true) ; Non Conditional
 ; Statement: return $r5 
(check-sat)
; {getExtensionLoader/-514331157=([org.apache.dubbo.common.extension.ExtensionAccessor, java.lang.Class], org.apache.dubbo.common.extension.ExtensionLoader), cast-from-var1225-to-var294=([org.apache.dubbo.rpc.model.ApplicationModel], org.apache.dubbo.common.extension.ExtensionAccessor), var2716_getMode/-582985525=([org.apache.dubbo.rpc.model.ApplicationModel], java.lang.String), var2147_isNotEmpty/-1251449450=([java.lang.String], boolean), getExtension/-1809037860=([org.apache.dubbo.common.extension.ExtensionLoader, java.lang.String], java.lang.Object), cast-from-var1041-to-var2716=([java.lang.Object], org.apache.dubbo.common.threadpool.manager.ExecutorRepository)}
; {var1225=org.apache.dubbo.rpc.model.ApplicationModel, var183=r0, var3460=org.apache.dubbo.common.extension.ExtensionLoader, var2716=org.apache.dubbo.common.threadpool.manager.ExecutorRepository, var294=org.apache.dubbo.common.extension.ExtensionAccessor, var1187=r1, var647=r2, var2147=org.apache.dubbo.common.utils.StringUtils, var2375=$z0, var1041=java.lang.Object, var2599=$r4, var2005=$r5}
; {org.apache.dubbo.rpc.model.ApplicationModel=var1225, r0=var183, org.apache.dubbo.common.extension.ExtensionLoader=var3460, org.apache.dubbo.common.threadpool.manager.ExecutorRepository=var2716, org.apache.dubbo.common.extension.ExtensionAccessor=var294, r1=var1187, r2=var647, org.apache.dubbo.common.utils.StringUtils=var2147, $z0=var2375, java.lang.Object=var1041, $r4=var2599, $r5=var2005}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @parameter0: org.apache.dubbo.rpc.model.ApplicationModel;	r1 = virtualinvoke r0.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/common/threadpool/manager/ExecutorRepository;");	r2 = staticinvoke <org.apache.dubbo.common.threadpool.manager.ExecutorRepository: java.lang.String getMode(org.apache.dubbo.rpc.model.ApplicationModel)>(r0);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r2);	if $z0 == 0 goto $r3 = virtualinvoke r1.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Object getDefaultExtension()>();	$r4 = virtualinvoke r1.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Object getExtension(java.lang.String)>(r2);	$r5 = (org.apache.dubbo.common.threadpool.manager.ExecutorRepository) $r4;	goto [?= return $r5];	return $r5
;block_num 3