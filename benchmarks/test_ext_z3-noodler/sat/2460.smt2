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

(declare-sort var3386 0)
(declare-sort var438 0)
(declare-sort var1825 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameters/1757947146 (var3386) var438)
(declare-fun var1825_toQueryString/202647708 (var438) String)
(declare-const null-var3386 var3386)
(declare-const var258 var3386) ; Statement: r0 := @this: org.apache.dubbo.common.Parameters 
(assert (not (= var258 null-var3386)))
(assert true)
(define-const var52 var438 (getParameters/1757947146 var258)) ; Statement: $r1 = virtualinvoke r0.<org.apache.dubbo.common.Parameters: java.util.Map getParameters()>() 
(define-const var3635 String (var1825_toQueryString/202647708 var52)) ; Statement: $r2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String toQueryString(java.util.Map)>($r1) 
 ; Statement: return $r2 
(check-sat)
; {getParameters/1757947146=([org.apache.dubbo.common.Parameters], java.util.Map), var1825_toQueryString/202647708=([java.util.Map], java.lang.String)}
; {var3386=org.apache.dubbo.common.Parameters, var258=r0, var438=java.util.Map, var52=$r1, var1825=org.apache.dubbo.common.utils.StringUtils, var3635=$r2}
; {org.apache.dubbo.common.Parameters=var3386, r0=var258, java.util.Map=var438, $r1=var52, org.apache.dubbo.common.utils.StringUtils=var1825, $r2=var3635}
;seq <org.apache.dubbo.common.utils.StringUtils: java.lang.String toQueryString(java.util.Map)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: java.lang.String toQueryString(java.util.Map)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.Parameters;	$r1 = virtualinvoke r0.<org.apache.dubbo.common.Parameters: java.util.Map getParameters()>();	$r2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String toQueryString(java.util.Map)>($r1);	return $r2
;block_num 1