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

(declare-sort var771 0)
(declare-sort var1254 0)
(declare-sort var797 0)
(declare-sort var2194 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun overrideURL/400949567 (var771) var797)
(declare-fun var2194_isEmpty/-813097145 (String) Bool)
(declare-const null-var771 var771)
(declare-const null-String String)
(declare-const null-var797 var797)
(declare-const var3839 var771) ; Statement: r0 := @this: org.apache.dubbo.common.url.component.DubboServiceAddressURL 
(assert (not (= var3839 null-var771)))
(declare-const var1648 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var1648 null-String)))
(define-const var327 String null-String) ; Statement: r4 = null 
(define-const var225 var797 (overrideURL/400949567 var3839)) ; Statement: $r1 = r0.<org.apache.dubbo.common.url.component.DubboServiceAddressURL: org.apache.dubbo.common.url.component.ServiceConfigURL overrideURL> 
 ; Statement: if $r1 == null goto $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r4) 
(assert (= var225 null-var797)) ; Cond: $r1 == null 
(define-const var1370 Bool (var2194_isEmpty/-813097145 var327)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r4) 
 ; Statement: if $z0 == 0 goto return r4 
(assert (= (ite var1370 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return r4 
(check-sat)
; {overrideURL/400949567=([org.apache.dubbo.common.url.component.DubboServiceAddressURL], org.apache.dubbo.common.url.component.ServiceConfigURL), var2194_isEmpty/-813097145=([java.lang.String], boolean)}
; {var771=org.apache.dubbo.common.url.component.DubboServiceAddressURL, var3839=r0, var1648=r2, var1254=null_type, var327=r4, var797=org.apache.dubbo.common.url.component.ServiceConfigURL, var225=$r1, var2194=org.apache.dubbo.common.utils.StringUtils, var1370=$z0}
; {org.apache.dubbo.common.url.component.DubboServiceAddressURL=var771, r0=var3839, r2=var1648, null_type=var1254, r4=var327, org.apache.dubbo.common.url.component.ServiceConfigURL=var797, $r1=var225, org.apache.dubbo.common.utils.StringUtils=var2194, $z0=var1370}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.url.component.DubboServiceAddressURL;	r2 := @parameter0: java.lang.String;	r4 = null;	$r1 = r0.<org.apache.dubbo.common.url.component.DubboServiceAddressURL: org.apache.dubbo.common.url.component.ServiceConfigURL overrideURL>;	if $r1 == null goto $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r4);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r4);	if $z0 == 0 goto return r4;	return r4
;block_num 3