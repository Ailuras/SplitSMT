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

(declare-sort var1402 0)
(declare-sort var814 0)
(declare-sort var1184 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameter/-1307325648 (var1402 String) String)
(declare-fun var1184_isEmpty/-813097145 (String) Bool)
(declare-fun Float32_parseFloat/-1274905469 (String) Float32)
(declare-const null-var1402 var1402)
(declare-const null-String String)
(declare-const null-Float32 Float32)
(declare-const var3699 var1402) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var3699 null-var1402)))
(declare-const var3818 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var3818 null-String)))
(declare-const var345 Float32) ; Statement: f1 := @parameter1: float 
(assert (not (= var345 null-Float32)))
(assert true)
(define-const var804 String (getParameter/-1307325648 var3699 var3818)) ; Statement: r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>(r1) 
(define-const var3055 Bool (var1184_isEmpty/-813097145 var804)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2) 
 ; Statement: if $z0 == 0 goto $f0 = staticinvoke <java.lang.Float: float parseFloat(java.lang.String)>(r2) 
(assert (= (ite var3055 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1168 Float32 (Float32_parseFloat/-1274905469 var804)) ; Statement: $f0 = staticinvoke <java.lang.Float: float parseFloat(java.lang.String)>(r2) 
 ; Statement: return $f0 
(check-sat)
; {getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), var1184_isEmpty/-813097145=([java.lang.String], boolean), Float32_parseFloat/-1274905469=([java.lang.String], float)}
; {var1402=org.apache.dubbo.common.URL, var3699=r0, var3818=r1, var814=null_type, var345=f1, var804=r2, var1184=org.apache.dubbo.common.utils.StringUtils, var3055=$z0, var1168=$f0}
; {org.apache.dubbo.common.URL=var1402, r0=var3699, r1=var3818, null_type=var814, f1=var345, r2=var804, org.apache.dubbo.common.utils.StringUtils=var1184, $z0=var3055, $f0=var1168}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	f1 := @parameter1: float;	r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>(r1);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2);	if $z0 == 0 goto $f0 = staticinvoke <java.lang.Float: float parseFloat(java.lang.String)>(r2);	$f0 = staticinvoke <java.lang.Float: float parseFloat(java.lang.String)>(r2);	return $f0
;block_num 2