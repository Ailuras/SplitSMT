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

(declare-sort var779 0)
(declare-sort var1982 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getVersion/189836348 (var779) String)
(declare-fun var1982_isEmpty/-813097145 (String) Bool)
(declare-fun getServiceInterface/-1311863806 (var779) String)
(declare-const null-var779 var779)
(declare-const var2126 var779) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var2126 null-var779)))
(assert true)
(define-const var3881 String (getVersion/189836348 var2126)) ; Statement: $r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getVersion()>() 
(define-const var1827 Bool (var1982_isEmpty/-813097145 var3881)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r1) 
 ; Statement: if $z0 == 0 goto $r2 = new java.lang.StringBuilder 
(assert (not (= (ite var1827 1 0) 0))) ; Negate: Cond: $z0 == 0  
(assert true)
(define-const var2772 String (getServiceInterface/-1311863806 var2126)) ; Statement: $r9 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceInterface()>() 
 ; Statement: return $r9 
(check-sat)
; {getVersion/189836348=([org.apache.dubbo.common.URL], java.lang.String), var1982_isEmpty/-813097145=([java.lang.String], boolean), getServiceInterface/-1311863806=([org.apache.dubbo.common.URL], java.lang.String)}
; {var779=org.apache.dubbo.common.URL, var2126=r0, var3881=$r1, var1982=org.apache.dubbo.common.utils.StringUtils, var1827=$z0, var2772=$r9}
; {org.apache.dubbo.common.URL=var779, r0=var2126, $r1=var3881, org.apache.dubbo.common.utils.StringUtils=var1982, $z0=var1827, $r9=var2772}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	$r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getVersion()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r1);	if $z0 == 0 goto $r2 = new java.lang.StringBuilder;	$r9 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceInterface()>();	return $r9
;block_num 2