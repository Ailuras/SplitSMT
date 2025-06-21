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

(declare-sort var1381 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1381-init () var1381)
(declare-fun <init>/-1904658063 (var1381) void)
(define-const var1030 var1381 var1381-init) ; Statement: $r0 = new org.apache.dubbo.common.utils.StringUtils$init__303 
(assert true)
;(assert (<init>/-1904658063 var1030)) ; Statement: specialinvoke $r0.<org.apache.dubbo.common.utils.StringUtils$init__303: void <init>()>() 

(declare-const var1030!1 var1381)
 ; Statement: return $r0 
(check-sat)
; {var1381-init=([], org.apache.dubbo.common.utils.StringUtils$init__303), <init>/-1904658063=([org.apache.dubbo.common.utils.StringUtils$init__303], void)}
; {var1381=org.apache.dubbo.common.utils.StringUtils$init__303, var1030=$r0}
; {org.apache.dubbo.common.utils.StringUtils$init__303=var1381, $r0=var1030}
;seq <org.apache.dubbo.common.utils.StringUtils$init__303: void <init>()>
;cnt {"<org.apache.dubbo.common.utils.StringUtils$init__303: void <init>()>": 1}
;stmts $r0 = new org.apache.dubbo.common.utils.StringUtils$init__303;	specialinvoke $r0.<org.apache.dubbo.common.utils.StringUtils$init__303: void <init>()>();	return $r0
;block_num 1