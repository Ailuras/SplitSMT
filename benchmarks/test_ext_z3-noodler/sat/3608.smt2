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

(declare-sort var3754 0)
(declare-sort var2685 0)
(declare-sort var3343 0)
(declare-sort var3042 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun consumerURL/1671230243 (var3754) var3343)
(declare-fun var3042_isEmpty/-813097145 (String) Bool)
(declare-const null-var3754 var3754)
(declare-const null-String String)
(declare-const null-var3343 var3343)
(declare-const var3986 var3754) ; Statement: r0 := @this: org.apache.dubbo.common.url.component.ServiceAddressURL 
(assert (not (= var3986 null-var3754)))
(declare-const var3579 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var3579 null-String)))
(define-const var273 String null-String) ; Statement: r4 = null 
(define-const var1282 var3343 (consumerURL/1671230243 var3986)) ; Statement: $r1 = r0.<org.apache.dubbo.common.url.component.ServiceAddressURL: org.apache.dubbo.common.URL consumerURL> 
 ; Statement: if $r1 == null goto $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r4) 
(assert (= var1282 null-var3343)) ; Cond: $r1 == null 
(define-const var2172 Bool (var3042_isEmpty/-813097145 var273)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r4) 
 ; Statement: if $z0 == 0 goto return r4 
(assert (= (ite var2172 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return r4 
(check-sat)
; {consumerURL/1671230243=([org.apache.dubbo.common.url.component.ServiceAddressURL], org.apache.dubbo.common.URL), var3042_isEmpty/-813097145=([java.lang.String], boolean)}
; {var3754=org.apache.dubbo.common.url.component.ServiceAddressURL, var3986=r0, var3579=r2, var2685=null_type, var273=r4, var3343=org.apache.dubbo.common.URL, var1282=$r1, var3042=org.apache.dubbo.common.utils.StringUtils, var2172=$z0}
; {org.apache.dubbo.common.url.component.ServiceAddressURL=var3754, r0=var3986, r2=var3579, null_type=var2685, r4=var273, org.apache.dubbo.common.URL=var3343, $r1=var1282, org.apache.dubbo.common.utils.StringUtils=var3042, $z0=var2172}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.url.component.ServiceAddressURL;	r2 := @parameter0: java.lang.String;	r4 = null;	$r1 = r0.<org.apache.dubbo.common.url.component.ServiceAddressURL: org.apache.dubbo.common.URL consumerURL>;	if $r1 == null goto $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r4);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r4);	if $z0 == 0 goto return r4;	return r4
;block_num 3