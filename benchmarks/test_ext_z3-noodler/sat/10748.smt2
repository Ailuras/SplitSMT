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

(declare-sort var2130 0)
(declare-sort var3568 0)
(declare-sort var743 0)
(declare-sort var1027 0)
(declare-sort var3629 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getApplicationConfigManager/1850072349 (var2130) var3568)
(declare-fun var743_ofNullable/-1077078438 (var1027) var743)
(declare-fun cast-from-var3568-to-var1027 (var3568) var1027)
(declare-fun var3629_getApplicationConfig/-1234892824 (var2130) var743)
(declare-fun isPresent/580259846 (var743) Bool)
(declare-const null-var2130 var2130)
(declare-const var1132 var2130) ; Statement: r0 := @parameter0: org.apache.dubbo.rpc.model.ApplicationModel 
(assert (not (= var1132 null-var2130)))
(assert true)
(define-const var2041 var3568 (getApplicationConfigManager/1850072349 var1132)) ; Statement: $r1 = virtualinvoke r0.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.config.context.ConfigManager getApplicationConfigManager()>() 
(define-const var1650 var743 (var743_ofNullable/-1077078438 (cast-from-var3568-to-var1027 var2041))) ; Statement: r2 = staticinvoke <java.util.Optional: java.util.Optional ofNullable(java.lang.Object)>($r1) 
(define-const var2680 var743 (var3629_getApplicationConfig/-1234892824 var1132)) ; Statement: r3 = staticinvoke <org.apache.dubbo.metadata.util.MetadataServiceVersionUtils: java.util.Optional getApplicationConfig(org.apache.dubbo.rpc.model.ApplicationModel)>(r0) 
(assert true)
(define-const var3399 Bool (isPresent/580259846 var2680)) ; Statement: $z0 = virtualinvoke r3.<java.util.Optional: boolean isPresent()>() 
 ; Statement: if $z0 == 0 goto $z1 = virtualinvoke r2.<java.util.Optional: boolean isPresent()>() 
(assert (= (ite var3399 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var3692 Bool (isPresent/580259846 var1650)) ; Statement: $z1 = virtualinvoke r2.<java.util.Optional: boolean isPresent()>() 
 ; Statement: if $z1 == 0 goto return 0 
(assert (= (ite var3692 1 0) 0)) ; Cond: $z1 == 0 
 ; Statement: return 0 
(check-sat)
; {getApplicationConfigManager/1850072349=([org.apache.dubbo.rpc.model.ApplicationModel], org.apache.dubbo.config.context.ConfigManager), var743_ofNullable/-1077078438=([java.lang.Object], java.util.Optional), cast-from-var3568-to-var1027=([org.apache.dubbo.config.context.ConfigManager], java.lang.Object), var3629_getApplicationConfig/-1234892824=([org.apache.dubbo.rpc.model.ApplicationModel], java.util.Optional), isPresent/580259846=([java.util.Optional], boolean)}
; {var2130=org.apache.dubbo.rpc.model.ApplicationModel, var1132=r0, var3568=org.apache.dubbo.config.context.ConfigManager, var2041=$r1, var743=java.util.Optional, var1027=java.lang.Object, var1650=r2, var3629=org.apache.dubbo.metadata.util.MetadataServiceVersionUtils, var2680=r3, var3399=$z0, var3692=$z1}
; {org.apache.dubbo.rpc.model.ApplicationModel=var2130, r0=var1132, org.apache.dubbo.config.context.ConfigManager=var3568, $r1=var2041, java.util.Optional=var743, java.lang.Object=var1027, r2=var1650, org.apache.dubbo.metadata.util.MetadataServiceVersionUtils=var3629, r3=var2680, $z0=var3399, $z1=var3692}
;seq 
;cnt {}
;stmts r0 := @parameter0: org.apache.dubbo.rpc.model.ApplicationModel;	$r1 = virtualinvoke r0.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.config.context.ConfigManager getApplicationConfigManager()>();	r2 = staticinvoke <java.util.Optional: java.util.Optional ofNullable(java.lang.Object)>($r1);	r3 = staticinvoke <org.apache.dubbo.metadata.util.MetadataServiceVersionUtils: java.util.Optional getApplicationConfig(org.apache.dubbo.rpc.model.ApplicationModel)>(r0);	$z0 = virtualinvoke r3.<java.util.Optional: boolean isPresent()>();	if $z0 == 0 goto $z1 = virtualinvoke r2.<java.util.Optional: boolean isPresent()>();	$z1 = virtualinvoke r2.<java.util.Optional: boolean isPresent()>();	if $z1 == 0 goto return 0;	return 0
;block_num 3