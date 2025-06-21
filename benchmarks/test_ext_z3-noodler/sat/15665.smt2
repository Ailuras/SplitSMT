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

(declare-sort var922 0)
(declare-sort var2104 0)
(declare-sort var2017 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2017_isBlank/-523695098 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-const null-var922 var922)
(declare-const null-String String)
(declare-const var2166 var922) ; Statement: r1 := @this: org.apache.dubbo.registry.nacos.NacosServiceName 
(assert (not (= var2166 null-var922)))
(declare-const var774 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var774 null-String)))
(declare-const var2149 String) ; Statement: r3 := @parameter1: java.lang.String 
(assert (not (= var2149 null-String)))
(define-const var852 Bool (var2017_isBlank/-523695098 (cast-from-String-to-String var774))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r0) 
 ; Statement: if $z0 == 0 goto $z1 = specialinvoke r1.<org.apache.dubbo.registry.nacos.NacosServiceName: boolean isRange(java.lang.String)>(r0) 
(assert (not (= (ite var852 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return 1 
(check-sat)
; {var2017_isBlank/-523695098=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence)}
; {var922=org.apache.dubbo.registry.nacos.NacosServiceName, var2166=r1, var774=r0, var2104=null_type, var2149=r3, var2017=org.apache.dubbo.common.utils.StringUtils, var852=$z0}
; {org.apache.dubbo.registry.nacos.NacosServiceName=var922, r1=var2166, r0=var774, null_type=var2104, r3=var2149, org.apache.dubbo.common.utils.StringUtils=var2017, $z0=var852}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>": 1}
;stmts r1 := @this: org.apache.dubbo.registry.nacos.NacosServiceName;	r0 := @parameter0: java.lang.String;	r3 := @parameter1: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r0);	if $z0 == 0 goto $z1 = specialinvoke r1.<org.apache.dubbo.registry.nacos.NacosServiceName: boolean isRange(java.lang.String)>(r0);	return 1
;block_num 2