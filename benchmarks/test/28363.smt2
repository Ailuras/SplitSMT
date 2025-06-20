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

(declare-sort var3868 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3868-init () var3868)
(declare-fun <init>/-586632455 (var3868) void)
(define-const var2673 var3868 var3868-init) ; Statement: $r0 = new org.apache.dubbo.common.utils.StringUtils$trim__297 
(assert true)
;(assert (<init>/-586632455 var2673)) ; Statement: specialinvoke $r0.<org.apache.dubbo.common.utils.StringUtils$trim__297: void <init>()>() 

(declare-const var2673!1 var3868)
 ; Statement: return $r0 
(check-sat)
; {var3868-init=([], org.apache.dubbo.common.utils.StringUtils$trim__297), <init>/-586632455=([org.apache.dubbo.common.utils.StringUtils$trim__297], void)}
; {var3868=org.apache.dubbo.common.utils.StringUtils$trim__297, var2673=$r0}
; {org.apache.dubbo.common.utils.StringUtils$trim__297=var3868, $r0=var2673}
;seq <org.apache.dubbo.common.utils.StringUtils$trim__297: void <init>()>
;cnt {"<org.apache.dubbo.common.utils.StringUtils$trim__297: void <init>()>": 1}
;stmts $r0 = new org.apache.dubbo.common.utils.StringUtils$trim__297;	specialinvoke $r0.<org.apache.dubbo.common.utils.StringUtils$trim__297: void <init>()>();	return $r0
;block_num 1