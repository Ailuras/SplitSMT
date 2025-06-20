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

(declare-sort var3571 0)
(declare-sort var79 0)
(declare-sort var1232 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1232_isEmpty/-813097145 (String) Bool)
(declare-const null-var3571 var3571)
(declare-const null-String String)
(declare-const var599 var3571) ; Statement: r2 := @this: org.apache.dubbo.registry.nacos.NacosNamingServiceWrapper 
(assert (not (= var599 null-var3571)))
(declare-const var3400 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3400 null-String)))
(define-const var1474 Bool (var1232_isEmpty/-813097145 var3400)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $r1 = virtualinvoke r0.<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>("$", "___") 
(assert (not (= (ite var1474 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return null 
(check-sat)
; {var1232_isEmpty/-813097145=([java.lang.String], boolean)}
; {var3571=org.apache.dubbo.registry.nacos.NacosNamingServiceWrapper, var599=r2, var3400=r0, var79=null_type, var1232=org.apache.dubbo.common.utils.StringUtils, var1474=$z0}
; {org.apache.dubbo.registry.nacos.NacosNamingServiceWrapper=var3571, r2=var599, r0=var3400, null_type=var79, org.apache.dubbo.common.utils.StringUtils=var1232, $z0=var1474}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r2 := @this: org.apache.dubbo.registry.nacos.NacosNamingServiceWrapper;	r0 := @parameter0: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $r1 = virtualinvoke r0.<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>("$", "___");	return null
;block_num 2