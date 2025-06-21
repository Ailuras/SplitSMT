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

(declare-sort var3659 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3659-init () var3659)
(declare-fun <init>/-710759149 (var3659) void)
(define-const var954 var3659 var3659-init) ; Statement: $r0 = new org.apache.dubbo.common.utils.StringUtils$lambda_isWord_1__299 
(assert true)
;(assert (<init>/-710759149 var954)) ; Statement: specialinvoke $r0.<org.apache.dubbo.common.utils.StringUtils$lambda_isWord_1__299: void <init>()>() 

(declare-const var954!1 var3659)
 ; Statement: return $r0 
(check-sat)
; {var3659-init=([], org.apache.dubbo.common.utils.StringUtils$lambda_isWord_1__299), <init>/-710759149=([org.apache.dubbo.common.utils.StringUtils$lambda_isWord_1__299], void)}
; {var3659=org.apache.dubbo.common.utils.StringUtils$lambda_isWord_1__299, var954=$r0}
; {org.apache.dubbo.common.utils.StringUtils$lambda_isWord_1__299=var3659, $r0=var954}
;seq <org.apache.dubbo.common.utils.StringUtils$lambda_isWord_1__299: void <init>()>
;cnt {"<org.apache.dubbo.common.utils.StringUtils$lambda_isWord_1__299: void <init>()>": 1}
;stmts $r0 = new org.apache.dubbo.common.utils.StringUtils$lambda_isWord_1__299;	specialinvoke $r0.<org.apache.dubbo.common.utils.StringUtils$lambda_isWord_1__299: void <init>()>();	return $r0
;block_num 1