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

(declare-sort var2448 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2448-init () var2448)
(declare-fun <init>/117322744 (var2448 String) void)
(declare-const null-String String)
(declare-const var116 String) ; Statement: $r0 := @parameter0: java.lang.StringBuilder 
(assert (not (= var116 null-String)))
(define-const var2312 var2448 var2448-init) ; Statement: $r1 = new org.apache.dubbo.common.utils.StringUtils$lambda_encodeParameters_2__301 
(assert true)
;(assert (<init>/117322744 var2312 var116)) ; Statement: specialinvoke $r1.<org.apache.dubbo.common.utils.StringUtils$lambda_encodeParameters_2__301: void <init>(java.lang.StringBuilder)>($r0) 

(declare-const var2312!1 var2448)
(declare-const var116!1 String)
 ; Statement: return $r1 
(check-sat)
; {var2448-init=([], org.apache.dubbo.common.utils.StringUtils$lambda_encodeParameters_2__301), <init>/117322744=([org.apache.dubbo.common.utils.StringUtils$lambda_encodeParameters_2__301, java.lang.StringBuilder], void)}
; {var116=$r0, var2448=org.apache.dubbo.common.utils.StringUtils$lambda_encodeParameters_2__301, var2312=$r1}
; {$r0=var116, org.apache.dubbo.common.utils.StringUtils$lambda_encodeParameters_2__301=var2448, $r1=var2312}
;seq <org.apache.dubbo.common.utils.StringUtils$lambda_encodeParameters_2__301: void <init>(java.lang.StringBuilder)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils$lambda_encodeParameters_2__301: void <init>(java.lang.StringBuilder)>": 1}
;stmts $r0 := @parameter0: java.lang.StringBuilder;	$r1 = new org.apache.dubbo.common.utils.StringUtils$lambda_encodeParameters_2__301;	specialinvoke $r1.<org.apache.dubbo.common.utils.StringUtils$lambda_encodeParameters_2__301: void <init>(java.lang.StringBuilder)>($r0);	return $r1
;block_num 1