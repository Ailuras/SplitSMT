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

(declare-sort var59 0)
(declare-sort var2974 0)
(declare-sort var3238 0)
(declare-sort var1584 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3238_isBlank/-523695098 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-const null-var59 var59)
(declare-const null-String String)
(declare-const var1584-DELETED var1584)
(declare-const var3252 var59) ; Statement: r5 := @this: org.apache.dubbo.configcenter.support.nacos.NacosDynamicConfiguration$NacosConfigListener 
(assert (not (= var3252 null-var59)))
(declare-const var3497 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3497 null-String)))
(declare-const var223 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var223 null-String)))
(define-const var1521 Bool (var3238_isBlank/-523695098 (cast-from-String-to-String var3497))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r0) 
 ; Statement: if $z0 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r1) 
(assert (not (= (ite var1521 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var2618 var1584 var1584-DELETED) ; Statement: $r4 = <org.apache.dubbo.common.config.configcenter.ConfigChangeType: org.apache.dubbo.common.config.configcenter.ConfigChangeType DELETED> 
 ; Statement: return $r4 
(check-sat)
; {var3238_isBlank/-523695098=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence)}
; {var59=org.apache.dubbo.configcenter.support.nacos.NacosDynamicConfiguration$NacosConfigListener, var3252=r5, var3497=r0, var2974=null_type, var223=r1, var3238=org.apache.dubbo.common.utils.StringUtils, var1521=$z0, var1584=org.apache.dubbo.common.config.configcenter.ConfigChangeType, var2618=$r4}
; {org.apache.dubbo.configcenter.support.nacos.NacosDynamicConfiguration$NacosConfigListener=var59, r5=var3252, r0=var3497, null_type=var2974, r1=var223, org.apache.dubbo.common.utils.StringUtils=var3238, $z0=var1521, org.apache.dubbo.common.config.configcenter.ConfigChangeType=var1584, $r4=var2618}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>": 1}
;stmts r5 := @this: org.apache.dubbo.configcenter.support.nacos.NacosDynamicConfiguration$NacosConfigListener;	r0 := @parameter0: java.lang.String;	r1 := @parameter1: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r0);	if $z0 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r1);	$r4 = <org.apache.dubbo.common.config.configcenter.ConfigChangeType: org.apache.dubbo.common.config.configcenter.ConfigChangeType DELETED>;	return $r4
;block_num 2