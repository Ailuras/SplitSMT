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

(declare-sort var2924 0)
(declare-sort var1151 0)
(declare-sort var1794 0)
(declare-sort var1806 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun overrideURL/400949567 (var2924) var1794)
(declare-fun var1806_isEmpty/-813097145 (String) Bool)
(declare-const null-var2924 var2924)
(declare-const null-String String)
(declare-const null-var1794 var1794)
(declare-const var3644 var2924) ; Statement: r0 := @this: org.apache.dubbo.common.url.component.DubboServiceAddressURL 
(assert (not (= var3644 null-var2924)))
(declare-const var515 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var515 null-String)))
(declare-const var627 String) ; Statement: r3 := @parameter1: java.lang.String 
(assert (not (= var627 null-String)))
(define-const var2063 String null-String) ; Statement: r5 = null 
(define-const var502 var1794 (overrideURL/400949567 var3644)) ; Statement: $r1 = r0.<org.apache.dubbo.common.url.component.DubboServiceAddressURL: org.apache.dubbo.common.url.component.ServiceConfigURL overrideURL> 
 ; Statement: if $r1 == null goto $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r5) 
(assert (= var502 null-var1794)) ; Cond: $r1 == null 
(define-const var960 Bool (var1806_isEmpty/-813097145 var2063)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r5) 
 ; Statement: if $z0 == 0 goto return r5 
(assert (= (ite var960 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return r5 
(check-sat)
; {overrideURL/400949567=([org.apache.dubbo.common.url.component.DubboServiceAddressURL], org.apache.dubbo.common.url.component.ServiceConfigURL), var1806_isEmpty/-813097145=([java.lang.String], boolean)}
; {var2924=org.apache.dubbo.common.url.component.DubboServiceAddressURL, var3644=r0, var515=r2, var1151=null_type, var627=r3, var2063=r5, var1794=org.apache.dubbo.common.url.component.ServiceConfigURL, var502=$r1, var1806=org.apache.dubbo.common.utils.StringUtils, var960=$z0}
; {org.apache.dubbo.common.url.component.DubboServiceAddressURL=var2924, r0=var3644, r2=var515, null_type=var1151, r3=var627, r5=var2063, org.apache.dubbo.common.url.component.ServiceConfigURL=var1794, $r1=var502, org.apache.dubbo.common.utils.StringUtils=var1806, $z0=var960}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.url.component.DubboServiceAddressURL;	r2 := @parameter0: java.lang.String;	r3 := @parameter1: java.lang.String;	r5 = null;	$r1 = r0.<org.apache.dubbo.common.url.component.DubboServiceAddressURL: org.apache.dubbo.common.url.component.ServiceConfigURL overrideURL>;	if $r1 == null goto $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r5);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r5);	if $z0 == 0 goto return r5;	return r5
;block_num 3