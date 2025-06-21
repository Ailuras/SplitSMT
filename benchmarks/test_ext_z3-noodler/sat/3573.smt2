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

(declare-sort var1297 0)
(declare-sort var2446 0)
(declare-sort var3289 0)
(declare-sort var2094 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun consumerURL/1671230243 (var1297) var3289)
(declare-fun var2094_isEmpty/-813097145 (String) Bool)
(declare-const null-var1297 var1297)
(declare-const null-String String)
(declare-const null-var3289 var3289)
(declare-const var1267 var1297) ; Statement: r0 := @this: org.apache.dubbo.common.url.component.ServiceAddressURL 
(assert (not (= var1267 null-var1297)))
(declare-const var2534 String) ; Statement: r3 := @parameter0: java.lang.String 
(assert (not (= var2534 null-String)))
(declare-const var2904 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var2904 null-String)))
(define-const var3629 String null-String) ; Statement: r5 = null 
(define-const var2995 var3289 (consumerURL/1671230243 var1267)) ; Statement: $r1 = r0.<org.apache.dubbo.common.url.component.ServiceAddressURL: org.apache.dubbo.common.URL consumerURL> 
 ; Statement: if $r1 == null goto $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r5) 
(assert (= var2995 null-var3289)) ; Cond: $r1 == null 
(define-const var1404 Bool (var2094_isEmpty/-813097145 var3629)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r5) 
 ; Statement: if $z0 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r5) 
(assert (= (ite var1404 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1963 Bool (var2094_isEmpty/-813097145 var3629)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r5) 
 ; Statement: if $z1 == 0 goto return r5 
(assert (= (ite var1963 1 0) 0)) ; Cond: $z1 == 0 
 ; Statement: return r5 
(check-sat)
; {consumerURL/1671230243=([org.apache.dubbo.common.url.component.ServiceAddressURL], org.apache.dubbo.common.URL), var2094_isEmpty/-813097145=([java.lang.String], boolean)}
; {var1297=org.apache.dubbo.common.url.component.ServiceAddressURL, var1267=r0, var2534=r3, var2446=null_type, var2904=r2, var3629=r5, var3289=org.apache.dubbo.common.URL, var2995=$r1, var2094=org.apache.dubbo.common.utils.StringUtils, var1404=$z0, var1963=$z1}
; {org.apache.dubbo.common.url.component.ServiceAddressURL=var1297, r0=var1267, r3=var2534, null_type=var2446, r2=var2904, r5=var3629, org.apache.dubbo.common.URL=var3289, $r1=var2995, org.apache.dubbo.common.utils.StringUtils=var2094, $z0=var1404, $z1=var1963}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 2}
;stmts r0 := @this: org.apache.dubbo.common.url.component.ServiceAddressURL;	r3 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	r5 = null;	$r1 = r0.<org.apache.dubbo.common.url.component.ServiceAddressURL: org.apache.dubbo.common.URL consumerURL>;	if $r1 == null goto $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r5);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r5);	if $z0 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r5);	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r5);	if $z1 == 0 goto return r5;	return r5
;block_num 4