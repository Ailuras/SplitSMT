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

(declare-sort var2666 0)
(declare-sort var2221 0)
(declare-sort var982 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameter/-1307325648 (var2666 String) String)
(declare-fun var982_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-var2666 var2666)
(declare-const null-String String)
(declare-const var499 var2666) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var499 null-var2666)))
(declare-const var1286 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var1286 null-String)))
(assert true)
(define-const var525 String (getParameter/-1307325648 var499 var1286)) ; Statement: r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>(r1) 
(define-const var2688 Bool (var982_isNotEmpty/-1251449450 var525)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r2) 
 ; Statement: return $z0 
(check-sat)
; {getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), var982_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var2666=org.apache.dubbo.common.URL, var499=r0, var1286=r1, var2221=null_type, var525=r2, var982=org.apache.dubbo.common.utils.StringUtils, var2688=$z0}
; {org.apache.dubbo.common.URL=var2666, r0=var499, r1=var1286, null_type=var2221, r2=var525, org.apache.dubbo.common.utils.StringUtils=var982, $z0=var2688}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>(r1);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r2);	return $z0
;block_num 1