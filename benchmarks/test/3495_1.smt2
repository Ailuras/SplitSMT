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

(declare-sort var992 0)
(declare-sort var2 0)
(declare-sort var1844 0)
(declare-sort var622 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun overrideURL/400949567 (var992) var1844)
(declare-fun var622_isEmpty/-813097145 (String) Bool)
(declare-const null-var992 var992)
(declare-const null-String String)
(declare-const null-var1844 var1844)
(declare-const var138 var992) ; Statement: r0 := @this: org.apache.dubbo.common.url.component.DubboServiceAddressURL 
(assert (not (= var138 null-var992)))
(declare-const var3761 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var3761 null-String)))
(define-const var691 String null-String) ; Statement: r4 = null 
(define-const var1256 var1844 (overrideURL/400949567 var138)) ; Statement: $r1 = r0.<org.apache.dubbo.common.url.component.DubboServiceAddressURL: org.apache.dubbo.common.url.component.ServiceConfigURL overrideURL> 
 ; Statement: if $r1 == null goto $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r4) 
(assert (= var1256 null-var1844)) ; Cond: $r1 == null 
(define-const var1653 Bool (var622_isEmpty/-813097145 var691)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r4) 
 ; Statement: if $z0 == 0 goto return r4 
(assert (= (ite var1653 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return r4 
(check-sat)
; {overrideURL/400949567=([org.apache.dubbo.common.url.component.DubboServiceAddressURL], org.apache.dubbo.common.url.component.ServiceConfigURL), var622_isEmpty/-813097145=([java.lang.String], boolean)}
; {var992=org.apache.dubbo.common.url.component.DubboServiceAddressURL, var138=r0, var3761=r2, var2=null_type, var691=r4, var1844=org.apache.dubbo.common.url.component.ServiceConfigURL, var1256=$r1, var622=org.apache.dubbo.common.utils.StringUtils, var1653=$z0}
; {org.apache.dubbo.common.url.component.DubboServiceAddressURL=var992, r0=var138, r2=var3761, null_type=var2, r4=var691, org.apache.dubbo.common.url.component.ServiceConfigURL=var1844, $r1=var1256, org.apache.dubbo.common.utils.StringUtils=var622, $z0=var1653}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.url.component.DubboServiceAddressURL;	r2 := @parameter0: java.lang.String;	r4 = null;	$r1 = r0.<org.apache.dubbo.common.url.component.DubboServiceAddressURL: org.apache.dubbo.common.url.component.ServiceConfigURL overrideURL>;	if $r1 == null goto $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r4);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r4);	if $z0 == 0 goto return r4;	return r4
;block_num 3