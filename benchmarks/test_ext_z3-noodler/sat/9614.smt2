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

(declare-sort var2665 0)
(declare-sort var2351 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameter/-1307325648 (var2665 String) String)
(declare-fun var2351_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-var2665 var2665)
(declare-const var1944 var2665) ; Statement: r0 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var1944 null-var2665)))
(assert true)
(define-const var3610 String (getParameter/-1307325648 var1944 "registry-protocol-type")) ; Statement: r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("registry-protocol-type") 
(define-const var1566 Bool (var2351_isNotEmpty/-1251449450 var3610)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto $r2 = "registry" 
(assert (= (ite var1566 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3285 String "registry") ; Statement: $r2 = "registry" 
(assert true) ; Non Conditional
 ; Statement: return $r2 
(check-sat)
; {getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), var2351_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var2665=org.apache.dubbo.common.URL, var1944=r0, var3610=r1, var2351=org.apache.dubbo.common.utils.StringUtils, var1566=$z0, var3285=$r2}
; {org.apache.dubbo.common.URL=var2665, r0=var1944, r1=var3610, org.apache.dubbo.common.utils.StringUtils=var2351, $z0=var1566, $r2=var3285}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @parameter0: org.apache.dubbo.common.URL;	r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("registry-protocol-type");	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r1);	if $z0 == 0 goto $r2 = "registry";	$r2 = "registry";	return $r2
;block_num 3