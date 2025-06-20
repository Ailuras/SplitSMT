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

(declare-sort var3921 0)
(declare-sort var1750 0)
(declare-sort var2045 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun url/898879186 (var3921) var1750)
(declare-fun getParameter/-1307325648 (var1750 String) String)
(declare-fun var2045_isEmpty/-813097145 (String) Bool)
(declare-const null-var3921 var3921)
(declare-const var3921-USER_HOME String)
(declare-const var966 var3921) ; Statement: r0 := @this: org.apache.dubbo.common.threadpool.support.AbortPolicyWithReport 
(assert (not (= var966 null-var3921)))
(define-const var2639 var1750 (url/898879186 var966)) ; Statement: $r1 = r0.<org.apache.dubbo.common.threadpool.support.AbortPolicyWithReport: org.apache.dubbo.common.URL url> 
(assert true)
(define-const var2327 String (getParameter/-1307325648 var2639 "dump.directory")) ; Statement: r2 = virtualinvoke $r1.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("dump.directory") 
(define-const var3242 Bool (var2045_isEmpty/-813097145 var2327)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2) 
 ; Statement: if $z0 == 0 goto $r3 = new java.io.File 
(assert (not (= (ite var3242 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var1327 String var3921-USER_HOME) ; Statement: $r14 = <org.apache.dubbo.common.threadpool.support.AbortPolicyWithReport: java.lang.String USER_HOME> 
 ; Statement: return $r14 
(check-sat)
; {url/898879186=([org.apache.dubbo.common.threadpool.support.AbortPolicyWithReport], org.apache.dubbo.common.URL), getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), var2045_isEmpty/-813097145=([java.lang.String], boolean)}
; {var3921=org.apache.dubbo.common.threadpool.support.AbortPolicyWithReport, var966=r0, var1750=org.apache.dubbo.common.URL, var2639=$r1, var2327=r2, var2045=org.apache.dubbo.common.utils.StringUtils, var3242=$z0, var1327=$r14}
; {org.apache.dubbo.common.threadpool.support.AbortPolicyWithReport=var3921, r0=var966, org.apache.dubbo.common.URL=var1750, $r1=var2639, r2=var2327, org.apache.dubbo.common.utils.StringUtils=var2045, $z0=var3242, $r14=var1327}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.threadpool.support.AbortPolicyWithReport;	$r1 = r0.<org.apache.dubbo.common.threadpool.support.AbortPolicyWithReport: org.apache.dubbo.common.URL url>;	r2 = virtualinvoke $r1.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("dump.directory");	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2);	if $z0 == 0 goto $r3 = new java.io.File;	$r14 = <org.apache.dubbo.common.threadpool.support.AbortPolicyWithReport: java.lang.String USER_HOME>;	return $r14
;block_num 2