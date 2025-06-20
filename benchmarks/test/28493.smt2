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

(declare-sort var3194 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3194-init () var3194)
(declare-fun <init>/113465342 (var3194) void)
(define-const var1567 var3194 var3194-init) ; Statement: $r0 = new org.apache.dubbo.common.utils.StringUtils$addAll__322 
(assert true)
;(assert (<init>/113465342 var1567)) ; Statement: specialinvoke $r0.<org.apache.dubbo.common.utils.StringUtils$addAll__322: void <init>()>() 

(declare-const var1567!1 var3194)
 ; Statement: return $r0 
(check-sat)
; {var3194-init=([], org.apache.dubbo.common.utils.StringUtils$addAll__322), <init>/113465342=([org.apache.dubbo.common.utils.StringUtils$addAll__322], void)}
; {var3194=org.apache.dubbo.common.utils.StringUtils$addAll__322, var1567=$r0}
; {org.apache.dubbo.common.utils.StringUtils$addAll__322=var3194, $r0=var1567}
;seq <org.apache.dubbo.common.utils.StringUtils$addAll__322: void <init>()>
;cnt {"<org.apache.dubbo.common.utils.StringUtils$addAll__322: void <init>()>": 1}
;stmts $r0 = new org.apache.dubbo.common.utils.StringUtils$addAll__322;	specialinvoke $r0.<org.apache.dubbo.common.utils.StringUtils$addAll__322: void <init>()>();	return $r0
;block_num 1