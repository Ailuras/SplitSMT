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

(declare-sort var3231 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3231-init () var3231)
(declare-fun <init>/818682775 (var3231) void)
(define-const var2483 var3231 var3231-init) ; Statement: $r0 = new org.apache.dubbo.common.utils.StringUtils$add__317 
(assert true)
;(assert (<init>/818682775 var2483)) ; Statement: specialinvoke $r0.<org.apache.dubbo.common.utils.StringUtils$add__317: void <init>()>() 

(declare-const var2483!1 var3231)
 ; Statement: return $r0 
(check-sat)
; {var3231-init=([], org.apache.dubbo.common.utils.StringUtils$add__317), <init>/818682775=([org.apache.dubbo.common.utils.StringUtils$add__317], void)}
; {var3231=org.apache.dubbo.common.utils.StringUtils$add__317, var2483=$r0}
; {org.apache.dubbo.common.utils.StringUtils$add__317=var3231, $r0=var2483}
;seq <org.apache.dubbo.common.utils.StringUtils$add__317: void <init>()>
;cnt {"<org.apache.dubbo.common.utils.StringUtils$add__317: void <init>()>": 1}
;stmts $r0 = new org.apache.dubbo.common.utils.StringUtils$add__317;	specialinvoke $r0.<org.apache.dubbo.common.utils.StringUtils$add__317: void <init>()>();	return $r0
;block_num 1