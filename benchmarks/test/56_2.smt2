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

(declare-sort var773 0)
(declare-sort var1579 0)
(declare-sort var2417 0)
(declare-sort var444 0)
(declare-sort var3070 0)
(declare-sort var2506 0)
(declare-sort var1644 0)
(declare-sort var2969 0)
(declare-sort var348 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var1644!class ClassObject)
(declare-fun var2417_isEmpty/-813097145 (String) Bool)
(declare-fun var3070_getApplicationModel/75536413 (var773) var444)
(declare-fun getExtensionLoader/-514331157 (var2969 ClassObject) var2506)
(declare-fun cast-from-var444-to-var2969 (var444) var2969)
(declare-fun getExtension/-203349416 (var2506 String Bool) var348)
(declare-fun cast-from-var348-to-var1644 (var348) var1644)
(declare-const null-var773 var773)
(declare-const null-String String)
(declare-const null-Bool Bool)
(declare-const var2541 var773) ; Statement: r0 := @parameter0: org.apache.dubbo.rpc.model.ScopeModel 
(assert (not (= var2541 null-var773)))
(declare-const var3638 String) ; Statement: r5 := @parameter1: java.lang.String 
(assert (not (= var3638 null-String)))
(declare-const var2684 Bool) ; Statement: z1 := @parameter2: boolean 
(assert (not (= var2684 null-Bool)))
(define-const var1487 Bool (var2417_isEmpty/-813097145 var3638)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r5) 
 ; Statement: if $z0 == 0 goto $r1 = staticinvoke <org.apache.dubbo.rpc.model.ScopeModelUtil: org.apache.dubbo.rpc.model.ApplicationModel getApplicationModel(org.apache.dubbo.rpc.model.ScopeModel)>(r0) 
(assert (= (ite var1487 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3089 var444 (var3070_getApplicationModel/75536413 var2541)) ; Statement: $r1 = staticinvoke <org.apache.dubbo.rpc.model.ScopeModelUtil: org.apache.dubbo.rpc.model.ApplicationModel getApplicationModel(org.apache.dubbo.rpc.model.ScopeModel)>(r0) 
(assert true)
(define-const var1468 var2506 (getExtensionLoader/-514331157 (cast-from-var444-to-var2969 var3089) var1644!class)) ; Statement: $r2 = virtualinvoke $r1.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/rpc/cluster/Cluster;") 
(assert true)
(define-const var3302 var348 (getExtension/-203349416 var1468 var3638 var2684)) ; Statement: $r3 = virtualinvoke $r2.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Object getExtension(java.lang.String,boolean)>(r5, z1) 
(define-const var1019 var1644 (cast-from-var348-to-var1644 var3302)) ; Statement: $r4 = (org.apache.dubbo.rpc.cluster.Cluster) $r3 
 ; Statement: return $r4 
(check-sat)
; {var2417_isEmpty/-813097145=([java.lang.String], boolean), var3070_getApplicationModel/75536413=([org.apache.dubbo.rpc.model.ScopeModel], org.apache.dubbo.rpc.model.ApplicationModel), getExtensionLoader/-514331157=([org.apache.dubbo.common.extension.ExtensionAccessor, java.lang.Class], org.apache.dubbo.common.extension.ExtensionLoader), cast-from-var444-to-var2969=([org.apache.dubbo.rpc.model.ApplicationModel], org.apache.dubbo.common.extension.ExtensionAccessor), getExtension/-203349416=([org.apache.dubbo.common.extension.ExtensionLoader, java.lang.String, boolean], java.lang.Object), cast-from-var348-to-var1644=([java.lang.Object], org.apache.dubbo.rpc.cluster.Cluster)}
; {var773=org.apache.dubbo.rpc.model.ScopeModel, var2541=r0, var3638=r5, var1579=null_type, var2684=z1, var2417=org.apache.dubbo.common.utils.StringUtils, var1487=$z0, var444=org.apache.dubbo.rpc.model.ApplicationModel, var3070=org.apache.dubbo.rpc.model.ScopeModelUtil, var3089=$r1, var2506=org.apache.dubbo.common.extension.ExtensionLoader, var1644=org.apache.dubbo.rpc.cluster.Cluster, var2969=org.apache.dubbo.common.extension.ExtensionAccessor, var1468=$r2, var348=java.lang.Object, var3302=$r3, var1019=$r4}
; {org.apache.dubbo.rpc.model.ScopeModel=var773, r0=var2541, r5=var3638, null_type=var1579, z1=var2684, org.apache.dubbo.common.utils.StringUtils=var2417, $z0=var1487, org.apache.dubbo.rpc.model.ApplicationModel=var444, org.apache.dubbo.rpc.model.ScopeModelUtil=var3070, $r1=var3089, org.apache.dubbo.common.extension.ExtensionLoader=var2506, org.apache.dubbo.rpc.cluster.Cluster=var1644, org.apache.dubbo.common.extension.ExtensionAccessor=var2969, $r2=var1468, java.lang.Object=var348, $r3=var3302, $r4=var1019}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @parameter0: org.apache.dubbo.rpc.model.ScopeModel;	r5 := @parameter1: java.lang.String;	z1 := @parameter2: boolean;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r5);	if $z0 == 0 goto $r1 = staticinvoke <org.apache.dubbo.rpc.model.ScopeModelUtil: org.apache.dubbo.rpc.model.ApplicationModel getApplicationModel(org.apache.dubbo.rpc.model.ScopeModel)>(r0);	$r1 = staticinvoke <org.apache.dubbo.rpc.model.ScopeModelUtil: org.apache.dubbo.rpc.model.ApplicationModel getApplicationModel(org.apache.dubbo.rpc.model.ScopeModel)>(r0);	$r2 = virtualinvoke $r1.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/rpc/cluster/Cluster;");	$r3 = virtualinvoke $r2.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Object getExtension(java.lang.String,boolean)>(r5, z1);	$r4 = (org.apache.dubbo.rpc.cluster.Cluster) $r3;	return $r4
;block_num 2