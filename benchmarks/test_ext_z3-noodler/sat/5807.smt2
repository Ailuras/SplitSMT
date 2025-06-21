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

(declare-sort var2225 0)
(declare-sort var2630 0)
(declare-sort var3719 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameter/-1307325648 (var2225 String) String)
(declare-fun var3719_isEmpty/-813097145 (String) Bool)
(declare-const null-var2225 var2225)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var1468 var2225) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var1468 null-var2225)))
(declare-const var120 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var120 null-String)))
(declare-const var2423 Int) ; Statement: i1 := @parameter1: int 
(assert (not (= var2423 null-Int)))
(assert true)
(define-const var3639 String (getParameter/-1307325648 var1468 var120)) ; Statement: r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>(r1) 
(define-const var2231 Bool (var3719_isEmpty/-813097145 var3639)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2) 
 ; Statement: if $z0 == 0 goto $i0 = staticinvoke <java.lang.Integer: int parseInt(java.lang.String)>(r2) 
(assert (not (= (ite var2231 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return i1 
(check-sat)
; {getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), var3719_isEmpty/-813097145=([java.lang.String], boolean)}
; {var2225=org.apache.dubbo.common.URL, var1468=r0, var120=r1, var2630=null_type, var2423=i1, var3639=r2, var3719=org.apache.dubbo.common.utils.StringUtils, var2231=$z0}
; {org.apache.dubbo.common.URL=var2225, r0=var1468, r1=var120, null_type=var2630, i1=var2423, r2=var3639, org.apache.dubbo.common.utils.StringUtils=var3719, $z0=var2231}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	i1 := @parameter1: int;	r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>(r1);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2);	if $z0 == 0 goto $i0 = staticinvoke <java.lang.Integer: int parseInt(java.lang.String)>(r2);	return i1
;block_num 2