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

(declare-sort var1515 0)
(declare-sort var993 0)
(declare-sort var3299 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun urlAddress/1606454354 (var1515) var3299)
(declare-fun getProtocol/-658430954 (var3299) String)
(declare-const null-var1515 var1515)
(declare-const null-String String)
(declare-const var3634 var1515) ; Statement: r7 := @this: org.apache.dubbo.common.URL 
(assert (not (= var3634 null-var1515)))
(declare-const var2413 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2413 null-String)))
(define-const var2719 String "protocol") ; Statement: $r1 = "protocol" 
(assert true)
(define-const var445 Bool (= var2719 var2413)) ; Statement: $z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0) 
 ; Statement: if $z0 == 0 goto $r2 = "username" 
(assert (not (= (ite var445 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var2117 var3299 (urlAddress/1606454354 var3634)) ; Statement: $r20 = r7.<org.apache.dubbo.common.URL: org.apache.dubbo.common.url.component.URLAddress urlAddress> 
(assert true)
(define-const var773 String (getProtocol/-658430954 var2117)) ; Statement: $r21 = virtualinvoke $r20.<org.apache.dubbo.common.url.component.URLAddress: java.lang.String getProtocol()>() 
 ; Statement: return $r21 
(check-sat)
; {urlAddress/1606454354=([org.apache.dubbo.common.URL], org.apache.dubbo.common.url.component.URLAddress), getProtocol/-658430954=([org.apache.dubbo.common.url.component.URLAddress], java.lang.String)}
; {var1515=org.apache.dubbo.common.URL, var3634=r7, var2413=r0, var993=null_type, var2719=$r1, var445=$z0, var3299=org.apache.dubbo.common.url.component.URLAddress, var2117=$r20, var773=$r21}
; {org.apache.dubbo.common.URL=var1515, r7=var3634, r0=var2413, null_type=var993, $r1=var2719, $z0=var445, org.apache.dubbo.common.url.component.URLAddress=var3299, $r20=var2117, $r21=var773}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r7 := @this: org.apache.dubbo.common.URL;	r0 := @parameter0: java.lang.String;	$r1 = "protocol";	$z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0);	if $z0 == 0 goto $r2 = "username";	$r20 = r7.<org.apache.dubbo.common.URL: org.apache.dubbo.common.url.component.URLAddress urlAddress>;	$r21 = virtualinvoke $r20.<org.apache.dubbo.common.url.component.URLAddress: java.lang.String getProtocol()>();	return $r21
;block_num 2