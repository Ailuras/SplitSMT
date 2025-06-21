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

(declare-sort var1613 0)
(declare-sort var2729 0)
(declare-sort var1509 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameter/-1307325648 (var1613 String) String)
(declare-fun var1509_isEmpty/-813097145 (String) Bool)
(declare-fun Float64_parseDouble/1471110886 (String) Float64)
(declare-const null-var1613 var1613)
(declare-const null-String String)
(declare-const null-Float64 Float64)
(declare-const var2516 var1613) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var2516 null-var1613)))
(declare-const var571 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var571 null-String)))
(declare-const var1682 Float64) ; Statement: d1 := @parameter1: double 
(assert (not (= var1682 null-Float64)))
(assert true)
(define-const var434 String (getParameter/-1307325648 var2516 var571)) ; Statement: r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>(r1) 
(define-const var2183 Bool (var1509_isEmpty/-813097145 var434)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2) 
 ; Statement: if $z0 == 0 goto $d0 = staticinvoke <java.lang.Double: double parseDouble(java.lang.String)>(r2) 
(assert (= (ite var2183 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2670 Float64 (Float64_parseDouble/1471110886 var434)) ; Statement: $d0 = staticinvoke <java.lang.Double: double parseDouble(java.lang.String)>(r2) 
 ; Statement: return $d0 
(check-sat)
; {getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), var1509_isEmpty/-813097145=([java.lang.String], boolean), Float64_parseDouble/1471110886=([java.lang.String], double)}
; {var1613=org.apache.dubbo.common.URL, var2516=r0, var571=r1, var2729=null_type, var1682=d1, var434=r2, var1509=org.apache.dubbo.common.utils.StringUtils, var2183=$z0, var2670=$d0}
; {org.apache.dubbo.common.URL=var1613, r0=var2516, r1=var571, null_type=var2729, d1=var1682, r2=var434, org.apache.dubbo.common.utils.StringUtils=var1509, $z0=var2183, $d0=var2670}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	d1 := @parameter1: double;	r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>(r1);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2);	if $z0 == 0 goto $d0 = staticinvoke <java.lang.Double: double parseDouble(java.lang.String)>(r2);	$d0 = staticinvoke <java.lang.Double: double parseDouble(java.lang.String)>(r2);	return $d0
;block_num 2