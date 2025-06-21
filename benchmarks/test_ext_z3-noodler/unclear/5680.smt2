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

(declare-sort var2298 0)
(declare-sort var1171 0)
(declare-sort var795 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameter/-1307325648 (var2298 String) String)
(declare-fun var795_isEmpty/-813097145 (String) Bool)
(declare-const null-var2298 var2298)
(declare-const null-String String)
(declare-const null-Float64 Float64)
(declare-const var1090 var2298) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var1090 null-var2298)))
(declare-const var1936 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var1936 null-String)))
(declare-const var3422 Float64) ; Statement: d1 := @parameter1: double 
(assert (not (= var3422 null-Float64)))
(assert true)
(define-const var2902 String (getParameter/-1307325648 var1090 var1936)) ; Statement: r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>(r1) 
(define-const var2203 Bool (var795_isEmpty/-813097145 var2902)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2) 
 ; Statement: if $z0 == 0 goto $d0 = staticinvoke <java.lang.Double: double parseDouble(java.lang.String)>(r2) 
(assert (not (= (ite var2203 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return d1 
(check-sat)
; {getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), var795_isEmpty/-813097145=([java.lang.String], boolean)}
; {var2298=org.apache.dubbo.common.URL, var1090=r0, var1936=r1, var1171=null_type, var3422=d1, var2902=r2, var795=org.apache.dubbo.common.utils.StringUtils, var2203=$z0}
; {org.apache.dubbo.common.URL=var2298, r0=var1090, r1=var1936, null_type=var1171, d1=var3422, r2=var2902, org.apache.dubbo.common.utils.StringUtils=var795, $z0=var2203}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	d1 := @parameter1: double;	r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>(r1);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2);	if $z0 == 0 goto $d0 = staticinvoke <java.lang.Double: double parseDouble(java.lang.String)>(r2);	return d1
;block_num 2