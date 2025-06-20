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

(declare-sort var374 0)
(declare-sort var62 0)
(declare-sort var391 0)
(declare-sort var1762 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var391_isNotEmpty/-1251449450 (String) Bool)
(declare-fun getExtensionLoader/-1698403979 (var374 ClassObject) var1762)
(declare-fun hasExtension/-1450549355 (var1762 String) Bool)
(declare-const null-var374 var374)
(declare-const null-ClassObject ClassObject)
(declare-const null-String String)
(declare-const var990 var374) ; Statement: r1 := @this: org.apache.dubbo.config.deploy.DefaultApplicationDeployer 
(assert (not (= var990 null-var374)))
(declare-const var2917 ClassObject) ; Statement: r2 := @parameter0: java.lang.Class 
(assert (not (= var2917 null-ClassObject)))
(declare-const var2676 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var2676 null-String)))
(define-const var609 Bool (var391_isNotEmpty/-1251449450 var2676)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto return 0 
(assert (not (= (ite var609 1 0) 0))) ; Negate: Cond: $z0 == 0  
(assert true)
(define-const var3607 var1762 (getExtensionLoader/-1698403979 var990 var2917)) ; Statement: r3 = specialinvoke r1.<org.apache.dubbo.config.deploy.DefaultApplicationDeployer: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(r2) 
(assert true)
(define-const var3272 Bool (hasExtension/-1450549355 var3607 var2676)) ; Statement: $z1 = virtualinvoke r3.<org.apache.dubbo.common.extension.ExtensionLoader: boolean hasExtension(java.lang.String)>(r0) 
 ; Statement: return $z1 
(check-sat)
; {var391_isNotEmpty/-1251449450=([java.lang.String], boolean), getExtensionLoader/-1698403979=([org.apache.dubbo.config.deploy.DefaultApplicationDeployer, java.lang.Class], org.apache.dubbo.common.extension.ExtensionLoader), hasExtension/-1450549355=([org.apache.dubbo.common.extension.ExtensionLoader, java.lang.String], boolean)}
; {var374=org.apache.dubbo.config.deploy.DefaultApplicationDeployer, var990=r1, var2917=r2, var2676=r0, var62=null_type, var391=org.apache.dubbo.common.utils.StringUtils, var609=$z0, var1762=org.apache.dubbo.common.extension.ExtensionLoader, var3607=r3, var3272=$z1}
; {org.apache.dubbo.config.deploy.DefaultApplicationDeployer=var374, r1=var990, r2=var2917, r0=var2676, null_type=var62, org.apache.dubbo.common.utils.StringUtils=var391, $z0=var609, org.apache.dubbo.common.extension.ExtensionLoader=var1762, r3=var3607, $z1=var3272}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r1 := @this: org.apache.dubbo.config.deploy.DefaultApplicationDeployer;	r2 := @parameter0: java.lang.Class;	r0 := @parameter1: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0);	if $z0 == 0 goto return 0;	r3 = specialinvoke r1.<org.apache.dubbo.config.deploy.DefaultApplicationDeployer: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(r2);	$z1 = virtualinvoke r3.<org.apache.dubbo.common.extension.ExtensionLoader: boolean hasExtension(java.lang.String)>(r0);	return $z1
;block_num 2