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

(declare-sort var2351 0)
(declare-sort var1969 0)
(declare-sort var3146 0)
(declare-sort var290 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3146_isBlank/-523695098 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-const null-var2351 var2351)
(declare-const null-String String)
(declare-const var290-DELETED var290)
(declare-const var1781 var2351) ; Statement: r5 := @this: org.apache.dubbo.metadata.store.nacos.NacosMetadataReport$NacosConfigListener 
(assert (not (= var1781 null-var2351)))
(declare-const var3701 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3701 null-String)))
(declare-const var3538 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var3538 null-String)))
(define-const var2185 Bool (var3146_isBlank/-523695098 (cast-from-String-to-String var3701))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r0) 
 ; Statement: if $z0 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r1) 
(assert (not (= (ite var2185 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var100 var290 var290-DELETED) ; Statement: $r4 = <org.apache.dubbo.common.config.configcenter.ConfigChangeType: org.apache.dubbo.common.config.configcenter.ConfigChangeType DELETED> 
 ; Statement: return $r4 
(check-sat)
; {var3146_isBlank/-523695098=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence)}
; {var2351=org.apache.dubbo.metadata.store.nacos.NacosMetadataReport$NacosConfigListener, var1781=r5, var3701=r0, var1969=null_type, var3538=r1, var3146=org.apache.dubbo.common.utils.StringUtils, var2185=$z0, var290=org.apache.dubbo.common.config.configcenter.ConfigChangeType, var100=$r4}
; {org.apache.dubbo.metadata.store.nacos.NacosMetadataReport$NacosConfigListener=var2351, r5=var1781, r0=var3701, null_type=var1969, r1=var3538, org.apache.dubbo.common.utils.StringUtils=var3146, $z0=var2185, org.apache.dubbo.common.config.configcenter.ConfigChangeType=var290, $r4=var100}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>": 1}
;stmts r5 := @this: org.apache.dubbo.metadata.store.nacos.NacosMetadataReport$NacosConfigListener;	r0 := @parameter0: java.lang.String;	r1 := @parameter1: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r0);	if $z0 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r1);	$r4 = <org.apache.dubbo.common.config.configcenter.ConfigChangeType: org.apache.dubbo.common.config.configcenter.ConfigChangeType DELETED>;	return $r4
;block_num 2