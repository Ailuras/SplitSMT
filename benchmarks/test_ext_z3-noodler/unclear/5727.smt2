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

(declare-sort var3988 0)
(declare-sort var2423 0)
(declare-sort var2629 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameter/-1307325648 (var3988 String) String)
(declare-fun var2629_isEmpty/-813097145 (String) Bool)
(declare-const null-var3988 var3988)
(declare-const null-String String)
(declare-const null-Float32 Float32)
(declare-const var2952 var3988) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var2952 null-var3988)))
(declare-const var3192 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var3192 null-String)))
(declare-const var2538 Float32) ; Statement: f1 := @parameter1: float 
(assert (not (= var2538 null-Float32)))
(assert true)
(define-const var1914 String (getParameter/-1307325648 var2952 var3192)) ; Statement: r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>(r1) 
(define-const var3214 Bool (var2629_isEmpty/-813097145 var1914)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2) 
 ; Statement: if $z0 == 0 goto $f0 = staticinvoke <java.lang.Float: float parseFloat(java.lang.String)>(r2) 
(assert (not (= (ite var3214 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return f1 
(check-sat)
; {getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), var2629_isEmpty/-813097145=([java.lang.String], boolean)}
; {var3988=org.apache.dubbo.common.URL, var2952=r0, var3192=r1, var2423=null_type, var2538=f1, var1914=r2, var2629=org.apache.dubbo.common.utils.StringUtils, var3214=$z0}
; {org.apache.dubbo.common.URL=var3988, r0=var2952, r1=var3192, null_type=var2423, f1=var2538, r2=var1914, org.apache.dubbo.common.utils.StringUtils=var2629, $z0=var3214}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	f1 := @parameter1: float;	r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>(r1);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2);	if $z0 == 0 goto $f0 = staticinvoke <java.lang.Float: float parseFloat(java.lang.String)>(r2);	return f1
;block_num 2