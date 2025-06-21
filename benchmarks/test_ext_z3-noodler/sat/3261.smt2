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

(declare-sort var3463 0)
(declare-sort var1690 0)
(declare-sort var1484 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getPath/898047937 (var1690) String)
(declare-fun cast-from-var3463-to-var1690 (var3463) var1690)
(declare-fun var1484_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-var3463 var3463)
(declare-const var2712 var3463) ; Statement: r0 := @this: org.apache.dubbo.common.url.component.ServiceAddressURL 
(assert (not (= var2712 null-var3463)))
(assert true)
(define-const var2013 String (getPath/898047937 (cast-from-var3463-to-var1690 var2712))) ; Statement: r1 = specialinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getPath()>() 
(define-const var2878 Bool (var1484_isNotEmpty/-1251449450 var2013)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto $r2 = r0.<org.apache.dubbo.common.url.component.ServiceAddressURL: org.apache.dubbo.common.URL consumerURL> 
(assert (not (= (ite var2878 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return r1 
(check-sat)
; {getPath/898047937=([org.apache.dubbo.common.URL], java.lang.String), cast-from-var3463-to-var1690=([org.apache.dubbo.common.url.component.ServiceAddressURL], org.apache.dubbo.common.URL), var1484_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var3463=org.apache.dubbo.common.url.component.ServiceAddressURL, var2712=r0, var1690=org.apache.dubbo.common.URL, var2013=r1, var1484=org.apache.dubbo.common.utils.StringUtils, var2878=$z0}
; {org.apache.dubbo.common.url.component.ServiceAddressURL=var3463, r0=var2712, org.apache.dubbo.common.URL=var1690, r1=var2013, org.apache.dubbo.common.utils.StringUtils=var1484, $z0=var2878}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.url.component.ServiceAddressURL;	r1 = specialinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getPath()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r1);	if $z0 == 0 goto $r2 = r0.<org.apache.dubbo.common.url.component.ServiceAddressURL: org.apache.dubbo.common.URL consumerURL>;	return r1
;block_num 2