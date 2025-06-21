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

(declare-sort var3491 0)
(declare-sort var1075 0)
(declare-sort var1515 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameter/-1307325648 (var3491 String) String)
(declare-fun var1515_isEmpty/-813097145 (String) Bool)
(declare-const null-var3491 var3491)
(declare-const null-String String)
(declare-const var3162 var3491) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var3162 null-var3491)))
(declare-const var2487 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var2487 null-String)))
(declare-const var2164 String) ; Statement: r3 := @parameter1: java.lang.String 
(assert (not (= var2164 null-String)))
(assert true)
(define-const var2782 String (getParameter/-1307325648 var3162 var2487)) ; Statement: r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>(r1) 
(define-const var2441 Bool (var1515_isEmpty/-813097145 var2782)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2) 
 ; Statement: if $z0 == 0 goto $r4 = r2 
(assert (= (ite var2441 1 0) 0)) ; Cond: $z0 == 0 
(define-const var736 String var2782) ; Statement: $r4 = r2 
(assert true) ; Non Conditional
 ; Statement: return $r4 
(check-sat)
; {getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), var1515_isEmpty/-813097145=([java.lang.String], boolean)}
; {var3491=org.apache.dubbo.common.URL, var3162=r0, var2487=r1, var1075=null_type, var2164=r3, var2782=r2, var1515=org.apache.dubbo.common.utils.StringUtils, var2441=$z0, var736=$r4}
; {org.apache.dubbo.common.URL=var3491, r0=var3162, r1=var2487, null_type=var1075, r3=var2164, r2=var2782, org.apache.dubbo.common.utils.StringUtils=var1515, $z0=var2441, $r4=var736}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	r3 := @parameter1: java.lang.String;	r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>(r1);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2);	if $z0 == 0 goto $r4 = r2;	$r4 = r2;	return $r4
;block_num 3