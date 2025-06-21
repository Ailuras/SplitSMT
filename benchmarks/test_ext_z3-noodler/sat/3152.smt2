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

(declare-sort var2340 0)
(declare-sort var1497 0)
(declare-sort var1017 0)
(declare-sort var2558 0)
(declare-sort var3774 0)
(declare-sort var3678 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var1017!class ClassObject)
(declare-fun getExtensionLoader/-514331157 (var2558 ClassObject) var1497)
(declare-fun cast-from-var2340-to-var2558 (var2340) var2558)
(declare-fun var1017_getMode/-582985525 (var2340) String)
(declare-fun var3774_isNotEmpty/-1251449450 (String) Bool)
(declare-fun getDefaultExtension/1470219142 (var1497) var3678)
(declare-fun cast-from-var3678-to-var1017 (var3678) var1017)
(declare-const null-var2340 var2340)
(declare-const var1063 var2340) ; Statement: r0 := @parameter0: org.apache.dubbo.rpc.model.ApplicationModel 
(assert (not (= var1063 null-var2340)))
(assert true)
(define-const var2692 var1497 (getExtensionLoader/-514331157 (cast-from-var2340-to-var2558 var1063) var1017!class)) ; Statement: r1 = virtualinvoke r0.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/common/threadpool/manager/ExecutorRepository;") 
(define-const var3510 String (var1017_getMode/-582985525 var1063)) ; Statement: r2 = staticinvoke <org.apache.dubbo.common.threadpool.manager.ExecutorRepository: java.lang.String getMode(org.apache.dubbo.rpc.model.ApplicationModel)>(r0) 
(define-const var1504 Bool (var3774_isNotEmpty/-1251449450 var3510)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r2) 
 ; Statement: if $z0 == 0 goto $r3 = virtualinvoke r1.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Object getDefaultExtension()>() 
(assert (= (ite var1504 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var360 var3678 (getDefaultExtension/1470219142 var2692)) ; Statement: $r3 = virtualinvoke r1.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Object getDefaultExtension()>() 
(define-const var1312 var1017 (cast-from-var3678-to-var1017 var360)) ; Statement: $r5 = (org.apache.dubbo.common.threadpool.manager.ExecutorRepository) $r3 
(assert true) ; Non Conditional
 ; Statement: return $r5 
(check-sat)
; {getExtensionLoader/-514331157=([org.apache.dubbo.common.extension.ExtensionAccessor, java.lang.Class], org.apache.dubbo.common.extension.ExtensionLoader), cast-from-var2340-to-var2558=([org.apache.dubbo.rpc.model.ApplicationModel], org.apache.dubbo.common.extension.ExtensionAccessor), var1017_getMode/-582985525=([org.apache.dubbo.rpc.model.ApplicationModel], java.lang.String), var3774_isNotEmpty/-1251449450=([java.lang.String], boolean), getDefaultExtension/1470219142=([org.apache.dubbo.common.extension.ExtensionLoader], java.lang.Object), cast-from-var3678-to-var1017=([java.lang.Object], org.apache.dubbo.common.threadpool.manager.ExecutorRepository)}
; {var2340=org.apache.dubbo.rpc.model.ApplicationModel, var1063=r0, var1497=org.apache.dubbo.common.extension.ExtensionLoader, var1017=org.apache.dubbo.common.threadpool.manager.ExecutorRepository, var2558=org.apache.dubbo.common.extension.ExtensionAccessor, var2692=r1, var3510=r2, var3774=org.apache.dubbo.common.utils.StringUtils, var1504=$z0, var3678=java.lang.Object, var360=$r3, var1312=$r5}
; {org.apache.dubbo.rpc.model.ApplicationModel=var2340, r0=var1063, org.apache.dubbo.common.extension.ExtensionLoader=var1497, org.apache.dubbo.common.threadpool.manager.ExecutorRepository=var1017, org.apache.dubbo.common.extension.ExtensionAccessor=var2558, r1=var2692, r2=var3510, org.apache.dubbo.common.utils.StringUtils=var3774, $z0=var1504, java.lang.Object=var3678, $r3=var360, $r5=var1312}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @parameter0: org.apache.dubbo.rpc.model.ApplicationModel;	r1 = virtualinvoke r0.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/common/threadpool/manager/ExecutorRepository;");	r2 = staticinvoke <org.apache.dubbo.common.threadpool.manager.ExecutorRepository: java.lang.String getMode(org.apache.dubbo.rpc.model.ApplicationModel)>(r0);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r2);	if $z0 == 0 goto $r3 = virtualinvoke r1.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Object getDefaultExtension()>();	$r3 = virtualinvoke r1.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Object getDefaultExtension()>();	$r5 = (org.apache.dubbo.common.threadpool.manager.ExecutorRepository) $r3;	return $r5
;block_num 3