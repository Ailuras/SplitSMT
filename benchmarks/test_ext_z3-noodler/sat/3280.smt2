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

(declare-sort var2806 0)
(declare-sort var2835 0)
(declare-sort var3557 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getPath/898047937 (var2835) String)
(declare-fun cast-from-var2806-to-var2835 (var2806) var2835)
(declare-fun var3557_isNotEmpty/-1251449450 (String) Bool)
(declare-fun consumerURL/1671230243 (var2806) var2835)
(declare-const null-var2806 var2806)
(declare-const var3832 var2806) ; Statement: r0 := @this: org.apache.dubbo.common.url.component.ServiceAddressURL 
(assert (not (= var3832 null-var2806)))
(assert true)
(define-const var114 String (getPath/898047937 (cast-from-var2806-to-var2835 var3832))) ; Statement: r1 = specialinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getPath()>() 
(define-const var3167 Bool (var3557_isNotEmpty/-1251449450 var114)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto $r2 = r0.<org.apache.dubbo.common.url.component.ServiceAddressURL: org.apache.dubbo.common.URL consumerURL> 
(assert (= (ite var3167 1 0) 0)) ; Cond: $z0 == 0 
(define-const var159 var2835 (consumerURL/1671230243 var3832)) ; Statement: $r2 = r0.<org.apache.dubbo.common.url.component.ServiceAddressURL: org.apache.dubbo.common.URL consumerURL> 
(assert true)
(define-const var3973 String (getPath/898047937 var159)) ; Statement: $r3 = virtualinvoke $r2.<org.apache.dubbo.common.URL: java.lang.String getPath()>() 
 ; Statement: return $r3 
(check-sat)
; {getPath/898047937=([org.apache.dubbo.common.URL], java.lang.String), cast-from-var2806-to-var2835=([org.apache.dubbo.common.url.component.ServiceAddressURL], org.apache.dubbo.common.URL), var3557_isNotEmpty/-1251449450=([java.lang.String], boolean), consumerURL/1671230243=([org.apache.dubbo.common.url.component.ServiceAddressURL], org.apache.dubbo.common.URL)}
; {var2806=org.apache.dubbo.common.url.component.ServiceAddressURL, var3832=r0, var2835=org.apache.dubbo.common.URL, var114=r1, var3557=org.apache.dubbo.common.utils.StringUtils, var3167=$z0, var159=$r2, var3973=$r3}
; {org.apache.dubbo.common.url.component.ServiceAddressURL=var2806, r0=var3832, org.apache.dubbo.common.URL=var2835, r1=var114, org.apache.dubbo.common.utils.StringUtils=var3557, $z0=var3167, $r2=var159, $r3=var3973}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.url.component.ServiceAddressURL;	r1 = specialinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getPath()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r1);	if $z0 == 0 goto $r2 = r0.<org.apache.dubbo.common.url.component.ServiceAddressURL: org.apache.dubbo.common.URL consumerURL>;	$r2 = r0.<org.apache.dubbo.common.url.component.ServiceAddressURL: org.apache.dubbo.common.URL consumerURL>;	$r3 = virtualinvoke $r2.<org.apache.dubbo.common.URL: java.lang.String getPath()>();	return $r3
;block_num 2